Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B752B7EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgKRN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgKRN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:40 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4573DC0613D4;
        Wed, 18 Nov 2020 05:58:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so2906574ejk.2;
        Wed, 18 Nov 2020 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
        b=YxD4BW5cjmQdz4D/NWPOTYFDoj79erTso5jj6MSUrfUHf5OPHU//Y+UjP6rHQ8VYEi
         vBjQQBNvcP9cw+uaMWj5PTsXnqGwi+kVyf/BQa0kDaY381yNAEK3VpqAAZ093jnk/LMK
         uTtUZiMYKd8Yzkuafi0CZD6v8UN+ngYxLTCukSBE1wNJ/fl4NlZ4t+DWlUI+C/vjax69
         nouAaB5P0vcCRk3Ub6qTmGOojyV8lhP+JClrNBmQxficjyoktGm12RqQIMnkW051Za3x
         r2gagmHv/V2uVmIY3M0N9T9Dl9MIz3112FQOwMO59615Oe+Zq9Y611rb0gojGj2SwgSl
         KrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
        b=a8NEHxjZyAZdDSI/gLvONpQ1johPu3qg+gwPdtOsuUyOUeh7g8bJ2tu4GfSTdcCT2H
         06+qBL8ZPxau6xpHh+CLyLnl3YkwxT1B7d9d+3ep2WOVDqGeLLZKNpzA4KxoU5jMWwnJ
         VuiVIjfazYtDvE+GPUd/VixUTOQJsMG2VY8ps+UE9YAg/Ac2x2bOW0EyU7fak1xvJ4SQ
         zb7IkHmC2Jg+NVSmks+dEZcQ8NxoAncoC6YCVwn0lkdHqS1VsWE2hjwnIQq+drzGRlHX
         UI7s5pC+aYmywNrJezcJBZa4/bVIL0efXSRLJan2v4I9zxwohc32ZtyoQUwbzWpe7d6T
         YYbg==
X-Gm-Message-State: AOAM531vC98TXot9YabHK5L5nfm6KBWjbHmnW7ejx3TLKiFAQ3O2e7yd
        897W0aeKHZfgYEfzi4e8Wcw=
X-Google-Smtp-Source: ABdhPJyl5SpYNZp2HUHCYYO8l+T0uxxnjSi9rjNGR0CciOkx5xPSCoFR3ksws8b0r8sM04dsBaG9wA==
X-Received: by 2002:a17:906:374a:: with SMTP id e10mr14400381ejc.246.1605707918063;
        Wed, 18 Nov 2020 05:58:38 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:37 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] ARM: dts: rockchip: enable hdmi_sound and i2s0 for rk3066a-mk808
Date:   Wed, 18 Nov 2020 14:58:22 +0100
Message-Id: <20201118135822.9582-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some noise with mk808. Enable the hdmi_sound node and
add i2s0 as sound source for hdmi.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index eed9e60cf..5fe74c097 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -116,6 +116,14 @@
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.11.0

