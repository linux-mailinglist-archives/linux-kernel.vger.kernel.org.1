Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFDD294502
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438987AbgJTWPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438978AbgJTWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:15:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A78C0613CE;
        Tue, 20 Oct 2020 15:15:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so55382otj.11;
        Tue, 20 Oct 2020 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rv4qFTv25KqnYnglUjSv+IYVPK04sSlNOwpw43zg4F4=;
        b=TiVvp3IQiVH8w3fbaITLMtKf4RVlIR8Nf2Xtw7/DPUl7cZTFG8o8Ihbu6sQUVtRCTu
         4wQmWvElKnod+aMvkCFRKTTCMJd4XgfhGVF2MABgscH/PVNeDc6yBOwk0EcsU09ORd9V
         Vqu0PfaE1P+u6OG7gXPibLZRFGnn3wyd6iW54vF3Rqr/T3ZyHOyA+YP/7yyrJ1QjZzHt
         y0qdCTTLrPUw0bplS7h6yDSn1vKGahEIWUToflYHswNuQPL1QV7OgOyRbqMvodlNEn+i
         dneIZaO5YanWAPkFW8K+FWXDDpdka4uAMPXqUbgtTmW/Owd3mRRIO9DRSvJIsAwcNra2
         bJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rv4qFTv25KqnYnglUjSv+IYVPK04sSlNOwpw43zg4F4=;
        b=UEcP03puo2Z7HHsuwP9J/GbhasCBNgEV/dpJo5WEeXga2qMSGAnpqBxttZxKqMKr5M
         fuvxXzfZV/zQaDYKOoFffRCwB4z/HDj42frhGxgidaZICf6wDH5pfae1/P9rp3R5al8V
         +Fp+a+T7pMaeIIw0LvEFbL4LnyLkAS5YOKLa5xyIqEpdTs6s+6n/O3NvuaeF9Sy0duGG
         Y9zhP9IukCq9dgnPV0Gwpl81Av0Ch9uZcvsX5iXh//xBS6rP999Wr0ENOnpHvL1yAayM
         C5tyACrhlKrty3zDLjx2fKuXQdZi/YCrUUr3+0dkDRQRBCtsPUcLdiYhzFSDMWe6n+CT
         Jopw==
X-Gm-Message-State: AOAM5300h9XCXt8N9r1s01enI9/h3Kj0FFWFuIsJt4SRrUmfamJIyVCD
        v2PoYEu4gTsAmzNMeikRHoY=
X-Google-Smtp-Source: ABdhPJwPJhdXClV6mKkVtb4k+SG2MQb/0NO1UmCNo7vCUuPUkba2a1oHY5yrWEL8/StWEZCb8LAAog==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr377764otp.67.1603232114779;
        Tue, 20 Oct 2020 15:15:14 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 81sm57005oti.79.2020.10.20.15.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:15:14 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     sam@ravnborg.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] dt-bindings: display: sii902x: Add supply bindings
Date:   Tue, 20 Oct 2020 17:14:59 -0500
Message-Id: <20201020221501.260025-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
References: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sii902x chip family requires IO and core voltages to reach the
correct voltage before chip initialization. Add binding for describing
the two supplies.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v1, v2:
  * Nothing. version incremented to stay in sync with sii902x regulator patch
  * Added Rob's acked-by line

 Documentation/devicetree/bindings/display/bridge/sii902x.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
index 0d1db3f9da84..02c21b584741 100644
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
@@ -8,6 +8,8 @@ Optional properties:
 	- interrupts: describe the interrupt line used to inform the host
 	  about hotplug events.
 	- reset-gpios: OF device-tree gpio specification for RST_N pin.
+	- iovcc-supply: I/O Supply Voltage (1.8V or 3.3V)
+	- cvcc12-supply: Digital Core Supply Voltage (1.2V)
 
 	HDMI audio properties:
 	- #sound-dai-cells: <0> or <1>. <0> if only i2s or spdif pin
@@ -54,6 +56,8 @@ Example:
 		compatible = "sil,sii9022";
 		reg = <0x39>;
 		reset-gpios = <&pioA 1 0>;
+		iovcc-supply = <&v3v3_hdmi>;
+		cvcc12-supply = <&v1v2_hdmi>;
 
 		#sound-dai-cells = <0>;
 		sil,i2s-data-lanes = < 0 1 2 >;
-- 
2.26.2

