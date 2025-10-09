module VehiclesHelper
  def state_badge(state)
    colors = {
      "intake" => "#3b82f6", "inspect" => "#06b6d4", "parts" => "#f59e0b",
      "service" => "#8b5cf6", "detail" => "#22c55e", "photo" => "#10b981",
      "live" => "#16a34a", "hold" => "#ef4444"
    }
    color = colors[state.to_s] || "#6b7280"
    %(<span style="background:#{color};color:#fff;padding:2px 6px;border-radius:6px;font-size:12px">#{state}</span>).html_safe
  end
end
