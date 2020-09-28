Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6D27B33A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1RbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1RbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:31:08 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6EC061755;
        Mon, 28 Sep 2020 10:31:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c2so1721161otp.7;
        Mon, 28 Sep 2020 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJGv07+JHeVcrfJOxkfeh9QoG+u0r3z2uEbgMDvlPAw=;
        b=HpTYidOcB3OjyjUs+CaeziYjrSUWMeP+7/0xx30dJwc8znJPBHRWxz28ZgF4nPOwNb
         XNQFPWgzItCWPW4buKXRrR0ZsVKOe9hgYpwFsw7BHsVnV+4ETabpCpuaY1n7SyDtcP6P
         7pQ9v80l39rwf0dfHWugNwALy4hB1bXhUpPgryBLVoCFyl774I+g9DFQsCqdzn9cAqZV
         BnrOkydZy3dMYnM7XxSykpr1kNUKoEozhqUiooEvuioU9CcgrVN0QemB+hYfXcQhf12M
         bKTftbMqx63toGDh4s53pxxFUC1YI2Z7af6jItOFTka+lDCja6n8Ob5Qvm/W8Qdx19hW
         iwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJGv07+JHeVcrfJOxkfeh9QoG+u0r3z2uEbgMDvlPAw=;
        b=ZBrFbdAgOs6d6XYVhzLGae8AoI4wrufmdkrQTiLFbaplEo1pCcqJn4rMqdm5gfqcJw
         Mngm1azxlAaYhCSnEeozJ68UXfa4BSsNDClJRUxfCr+eYAiV9ephxAGb0wyQou3Dp8C2
         GstNtnwR2HWJt4lJ/EfclruMXal8G1fIqE6LKj+dX0ARRwp6PcJCMHy3X8+8VKmy3NzA
         LAWu/PIk83sd8s5K5woE2Jw9o4GA8OyCKp5MefmTuNhZrZumWhD0YaG0RpJ7uL7DLN+Q
         dXATk1X3haN4xJI2vGeG7H34zsalHoEDRZZZRJCqtEshP6goAsAzEjePRmBKRA/aIcro
         7CJw==
X-Gm-Message-State: AOAM532MY8Oa/JJTn++iFzBjSlP4nR/Dc9rVsATpssZtpBc7tRw0L6K5
        owqLbWJu7w4CZ5luCh+DePSH/Xe96cOS6w==
X-Google-Smtp-Source: ABdhPJyCpkUkNmAh2IUG4xY92+ML/ksOW0Nga82x371b0KsM9Uu2/e8u27f3BY9YCjkoKr6TTueb2A==
X-Received: by 2002:a9d:674f:: with SMTP id w15mr32816otm.213.1601314267528;
        Mon, 28 Sep 2020 10:31:07 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id g23sm2348484ooh.45.2020.09.28.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:31:07 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] dt-bindings: display: sii902x: Add supply bindings
Date:   Mon, 28 Sep 2020 12:30:54 -0500
Message-Id: <20200928173056.1674274-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200928173056.1674274-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sii902x chip family requires IO and core voltages to reach the
correct voltage before chip initialization. Add binding for describing
the two supplies.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
  * Nothing. version incremented to stay in sync with sii902x regulator patch
  
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
2.25.4

