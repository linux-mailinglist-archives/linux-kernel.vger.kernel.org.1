Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DDF2D053D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgLFNfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLFNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:35:12 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B05C061A51;
        Sun,  6 Dec 2020 05:34:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so15550350ejb.10;
        Sun, 06 Dec 2020 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
        b=JOVXuy3e6JymxKOPEoHBdkzfQUhgnoR1msgkoaiMxH70fRYib/t+qYr+VQpo7JKMln
         F91whwe0wS6E4TTblt2ayRevdquO+k5v8NBiIGfJfJ6kCo75D+I0zR/Vp3M9iOTClr+y
         RCD4WdS3002o8Co4VHrBS/SLNuFuYVhfulYpaFxC/YwFdKNT4An0K8Wd/1+AdipNSVDq
         DmHl6hIzKsAopuPY3pE8J0vQW+3Q5+kXiYphccbg7W1ZVI6bX+A6IWPSUqr82lBEhjME
         zxPxH0zFGmboVpKVBFPb3LvGF83sSP9eqfPZsKkrNaa7ufXKT5erD+NMFSrNFe0jGx/r
         fRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
        b=q0FlCsPRfidfdGSxeSC8N7dtdlCr974g8WjLO4/BOYXYdSh2+127MhbgJAKz7eLyU1
         G/m5WqMwsKl1tQy+WQ1ZO0sqJXEZxUQ/ca09uHrfnURLg4roo9U3Fbq95WUtr3AhKJMX
         HthPYX0ki3eW1Er61jq5dS8jft83O8QbMM8pvDIYqcjNhLpydXhAYvG7EDmQc+g1JJCj
         /E04k0Kh4fOPqEhK3GchcAcH3N8I6I7trQCGtH6xVRujjYBFqTkGopRDodKTQVRllRAU
         HMh7OUwP/FC8ZdAoXHEBq46LS2fwkXDLXZQNJfnA27zD1sKMWDzAEFSOTVCTXIiv2s0w
         lRlw==
X-Gm-Message-State: AOAM533naJC/E145vW9ZIbxu9hz9j0KzlpFGGCjkSUg/V1OFUd3tvUpx
        7EFkQ1pCRqC6S5vPF3MU3Xo=
X-Google-Smtp-Source: ABdhPJztME1AEa+6AzKHTpyb9Y+omIXYUc5Z2Uz2KCJGA5tPM3cmuLgOt76RoEEmj6mHLL05lTnjBQ==
X-Received: by 2002:a17:906:f05:: with SMTP id z5mr15442015eji.8.1607261651143;
        Sun, 06 Dec 2020 05:34:11 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:34:10 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] ARM: dts: rockchip: enable hdmi_sound and i2s0 for rk3066a-mk808
Date:   Sun,  6 Dec 2020 14:33:55 +0100
Message-Id: <20201206133355.16007-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
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

