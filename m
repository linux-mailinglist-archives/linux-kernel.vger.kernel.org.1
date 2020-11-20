Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BA2BB4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgKTTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgKTTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:12:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA106C061A48
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:22 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r18so8101576pgu.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2m7bIELcNGPekiHEneDd09dToAdbtTiKOaPTqFMZpQ=;
        b=HawV3L2nlwG1HU4wifHcgIBi81iOCTitYif/qgaordtI7UCxZhauaWNPz+zy+s1Ndo
         Oy60xWl6cCDsFT6VcuszfyCdVd5A/yt0JOnksYPhQtT2wofOlf9NvL95plZWNVQOcZE2
         a0xFP8TXVyzFjpBjobIOHCJagWHd4ZPgkfjQpktSmkMJ0PIQq5HGuVI7dO8HBwYTIT2d
         9zXNlyRV7ou3DQlEEXBjbL+9rSeZJDl14YqCG7Z1aHP2XBxoVKrjwQ6VCLql8cr7YfAh
         NAENLVshaTwGkADeBYVc2MmcAo6Rr8TMxmKfhTV5kDq49GYrXbY4/iuGRrEqN0K9/C3Y
         L+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2m7bIELcNGPekiHEneDd09dToAdbtTiKOaPTqFMZpQ=;
        b=tvF07jRC+lA1a8W/JX5VDICoAicVhq+hUMVVUDmC5GUF9Sw5bE0hfB9zqAEftGNKeZ
         S858CEz2im+UmURG4+pWqCUvDjGaPK8vTvLZVdEGCK5ctXpXptJtyyjEcNyf2UaZ3gth
         WrmQRcJ3nB+JuCmJz4HgHUs4I2lHFliBI2zwYadYxgDZSyQGEFwgfeV276idwU4O/GoQ
         vyOF07V+vXTezh8qxQrZQ68btnuRpIQZr8XHyv7qy4jakUJp2TdVCytSU3/8I7zmwgHe
         vGA0OY78KM6LTy6OWEhd1vnuREe8yzfx6z2SqMRbMMeWRvZmOTXd6YY71LvTt+GBwNjM
         LzXw==
X-Gm-Message-State: AOAM533S3yd+WtgVxEGJaJvvof3MrqN6nVXuYuuNv+UkatgcF7sA1Bmo
        GNPhX2gDluCJ/CMjHI+VoVqJ5A==
X-Google-Smtp-Source: ABdhPJxTFnQnv5jgPjmlpmapoQC4M//o1YNKSzEN5O84mmMLGO3uuhXTJn2gF6BQyW4b1IJ0Jd5R4w==
X-Received: by 2002:a17:90a:5304:: with SMTP id x4mr11537722pjh.153.1605899542357;
        Fri, 20 Nov 2020 11:12:22 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u85sm4783149pfc.124.2020.11.20.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:12:21 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: meson-axg-s400: add support for USB and PCIe
Date:   Fri, 20 Nov 2020 11:12:17 -0800
Message-Id: <160589952950.11499.15261993036625823660.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120153229.3920123-1-narmstrong@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:32:25 +0100, Neil Armstrong wrote:
> This adds the USB and PCIe to AXG, and enables USB & the two M.2 PCIe ports on the S400 board.
> 
> Dependencies:
> - Patch 1, 2, 4: None
> - Patch 3: [1] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
> 
> [1] https://lore.kernel.org/r/20201120152131.3918814-1-narmstrong@baylibre.com
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: meson-axg: add USB nodes
      commit: ca91acde9a9858a20522abbb2c79c6883ef9bc73
[2/4] arm64: dts: meson-axg-s400: enable USB OTG
      commit: 160f1630878e11668336fded29eeb0fe82fb3faf
[3/4] arm64: dts: meson-axg: add PCIe nodes
      commit: 9bfc5abed67ae7dcc837dd8f6d61396d1cc9ac2b
[4/4] arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots
      commit: eee685ef92d8cbabb2a61c45fe7d976c3ebc9b1e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
