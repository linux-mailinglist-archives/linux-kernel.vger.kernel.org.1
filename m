Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC9F2D053B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgLFNex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgLFNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:34:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59134C0613D4;
        Sun,  6 Dec 2020 05:34:10 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cw27so10813470edb.5;
        Sun, 06 Dec 2020 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=YdnQLiCBK/wBANdCyVFkDIuYa/Owf4imk6/kuZS+qLWOfNAnswRN6psvtJ+xR0sEmt
         ATVRfxNf+UUyiETI3QWMjzXJpGSoB5x0PF4tOzzbpLjuBtI3pBsExo8hF/wendpfC1Ls
         G50g+Gh6D1SAaAgkjYElwb5rF7b5wvXUkO9vFy/fzd/XkZgd+Zc/HqnAoH6PVb8m6saR
         QbtwHR4HI471Ws4jqKUEBawrQDuKmQrjASR3CWaScxinx7qj7hwrObD//yqNrmxiawgC
         rPBMHlrH8dTfgBoq1q84zAdYk8H9J0yq8MjmlJaPa/TvqPsIoqgkycNFhCNKwFNL/oGN
         4PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
        b=JmLp+n6reL+bSIsb6544OVnwsjDuXlqvz/ytP1kh2WcmIRweRfGQgJI3VzbIAPGjjF
         CiNqBAhzFcUW7BgtXITkJ+zhspbAcZna9hVvmgNaKgzVmKZkk1HaiemqK5JjMBBTRhmi
         yBuQ+Vap2M5TdaMwL/95IEchdfVybFjcSi/MfnPhn0/l7Vl9YQknjXFy80OifPiYknI8
         WecF0CFNuXQTuH1B/e9a6tWorhGi30BlLKq7hGQ9Bs7Rz898c8y+Glhw3U59HgjH+2rJ
         9WQTa+tZhQdOr9Sj/5KzOgwTB0wcBKehv1KnjyMRCwcyOwdYofS6F9jwWxxUuJropKaW
         w+fw==
X-Gm-Message-State: AOAM530yE2GAe/HceoH0+8lAVZ5OL/5WcnD3B13hiV9AK9jzOAbHyO1j
        a+NB1fiKX8lGCJ+7x2udl+I=
X-Google-Smtp-Source: ABdhPJyTcga5ryTaOcjxeErZN0uSNiSlX+EAdf/VgZlWQgBUllwgGITJy/IVUbE7EtRHuBbkau4EpQ==
X-Received: by 2002:aa7:d784:: with SMTP id s4mr15760934edq.215.1607261649141;
        Sun, 06 Dec 2020 05:34:09 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:34:08 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/5] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
Date:   Sun,  6 Dec 2020 14:33:53 +0100
Message-Id: <20201206133355.16007-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to the 'hdmi' node for 'rk3066a.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 252750c97..67fcb0dc9 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -124,6 +124,7 @@
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.11.0

