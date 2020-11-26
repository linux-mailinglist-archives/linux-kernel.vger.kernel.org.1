Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72CD2C5533
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbgKZNZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgKZNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37298C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v22so2257075edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrcIvsH9Hjzci43TYB8Ej2o1CgDZS38SPJarDszE6Y4=;
        b=AYF80LwMV4eBPKCE/E7YzXAdLntyRCTW9ZM9n2ATa9Wbu3qoI8UrBs9/ZF2pK1ja1p
         vxWfzkhMxiQhjYm+8WFfoq7/0xLHby4uyQ1B41QC37vEG3vLccMpmRuEzF9opnwW08c+
         OWgKUG6d9DdSLWVjzy/Sbel76lfhlA3t4+UoxJZQMW04zktPeSUYd9NCLWE+9cDeZFdj
         Z4ot2uLW4Qu7sROoqPWFIhOdBrqP+zVOSdYKnhBLqt4oLF+WUabEJc/t49XCHxYnCuh6
         cWFiG8KSHUsgodfl91DvP7DUL96frNo4Fd5hBVxMSnz7KNxiXg+JXV8PFxgGGT+mAdWk
         ZrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RrcIvsH9Hjzci43TYB8Ej2o1CgDZS38SPJarDszE6Y4=;
        b=VNgdYBHNl02KE8QCjAKOn8hW8R+FUk+9GsL2czdR2WwPmYi9kRPgepRKhUGAcwFU5v
         g+tQlztEefDdfRhEBCjJxSGm6YHnBrXI0hcnKYlVzuERLiAfdCGbq/aydWx4+Uhw/y92
         VzMQgVhqDRDD+vZI4gPzDfoPaY0gM9dgDSDkY10sRx5E6Fd/OY2FsgQW9bg8QHWM4mog
         f+0jc8dLJ8cAkzsQS89eUy/qVLyJf/FNURlolg3LGpzvmIBnMOQFBTFaL3w05Lx6p1/Y
         XTrNh/6w3V9v+Q6vfAFZdNQnw8ls+nI+IxFPvrAkuctNA0mbvtmGCaiATTjQ5BHUd5dc
         LlXA==
X-Gm-Message-State: AOAM533tXAjsHLYMVWhA6ry5/qFomGk0KgOElMNHOIDPGZux0VTajuWY
        MQwzWw4uB4Zmj/B4Kp4TSY5pBnZ5KNSNpwjZ
X-Google-Smtp-Source: ABdhPJyCaiHrUMXH1oiMoTK8vsURMDBVH2fSMknyvLJocsUFhCEvXXx4wkuBHyiaZeHeYL0W8Gl6zw==
X-Received: by 2002:aa7:d5d7:: with SMTP id d23mr2430425eds.203.1606397112732;
        Thu, 26 Nov 2020 05:25:12 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f13sm3017707ejf.42.2020.11.26.05.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 05:25:12 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] ARM: zynq: Rename bus to be align with simple-bus yaml
Date:   Thu, 26 Nov 2020 14:25:01 +0100
Message-Id: <8a4bc80debfbb79c296e76fc1e4c173e62657286.1606397101.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606397101.git.michal.simek@xilinx.com>
References: <cover.1606397101.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename amba to AXI. Based on Xilinx Zynq TRM (Chapter 5) chip is "AXI
point-to-point channels for communicating addresses, data, and response
transactions between master and slave clients. This ARM AMBA 3.0..."

Issues are reported as:
.. amba: $nodename:0: 'amba' does not match
'^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
From schema:
../github.com/devicetree-org/dt-schema/dtschema/schemas/simple-bus.yaml

Similar change has been done for Xilinx ZynqMP SoC.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index db3899b07992..df9ad831cf05 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -92,7 +92,7 @@ replicator_in_port0: endpoint {
 		};
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.29.2

