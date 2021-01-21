Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC82FF2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbhAUSEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbhAUK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:28:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C57C061794
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ox12so1880659ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTDIuTc0U8fse5lYanlEDxbQeooG0OMqfA5FbckRqJ8=;
        b=T6kbEPjXSsmcVinKCO6J8hPsllDVgX4+2rFC6FP4RUZIdTpwhKuj0GDASK4dBIuzlm
         e6lvX4eQDDmROB1olcc5GNA68blp7my824cSZLc08tPIyh2nXOwtXsoVjZtQ5Rd2/RlP
         BeBdTBoXkR1jfZnnOGfdjuhw06dyBBEjEb8uBX/17naCS6YZmDZ7GDx8T2/ZbxARWiwd
         AyIAapbc9zDKGaf7nAOojF3EBxDl14UCt4EnFBbrnBjursxGWP1YDa/qned/J/MHHr5u
         tWG9kHpJjeAP8U7TTS43tboY2xFlsrK5+Yg/dyYVGADlfK4v9t17dperQ3E+pPbvK8We
         5hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dTDIuTc0U8fse5lYanlEDxbQeooG0OMqfA5FbckRqJ8=;
        b=WCL2PL7r4ZA8/2vRo0R5y9K3JJR9l3ZUVU9SP9ljfsbcxswo3s07JKT/HyKti4F7eZ
         i+4FqIgUPYoz4l/MgXuVsoaowmQm9QllNRW6e499wuQxA7tBu4PoFjNPJ25yMAOEeTHm
         adQdwgwTic1uJvYLELOzgypz6teZS/VYcBGziD6/aLf5N5khR0xk6Qn6bnZM0Y9RElC8
         8yQVWCdbp13YOlWkM9a6xprWx72ciJLjw8YBa67LBQpQa3Wj0EB/IBAE3UhTojZkjGt4
         ofAD9LdpQTgHfop8oyYSfkGQW7dxfUQVA3VeuQHg0FqAUsTTBa25MW69kg+Tfl86wFr4
         FvFg==
X-Gm-Message-State: AOAM531QcqA7CUUzi8MyiOe3uxyrTZe8R0K9lWYCNkoqxDPn91F+U8y9
        bnkxYiqX31G/HfDhGoco98pRvFPlqL4qb5Gk
X-Google-Smtp-Source: ABdhPJwmyScYHu7MGf5khxbIvxwB6eQ3Vxjpa5gJzsbED8H4xTRzj6eQ7YMQ+faEkaR9cdp/53tdhQ==
X-Received: by 2002:a17:906:4e0c:: with SMTP id z12mr8583626eju.370.1611224832578;
        Thu, 21 Jan 2021 02:27:12 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c14sm2601834edr.46.2021.01.21.02.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:12 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/12] arm64: dts: zynqmp: Enable reset controller driver
Date:   Thu, 21 Jan 2021 11:26:52 +0100
Message-Id: <4fb62952f61e5046d750fff0e3e469c7abd1d0d0.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable reset controller to be prepared for use.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Remove reset description for IPs from this patch. IPs will be enabled
  separately with DT binding update.
- Change patch subject

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index cdc1a0ddfa01..94a2e1f2b713 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
 			xlnx_aes: zynqmp-aes {
 				compatible = "xlnx,zynqmp-aes";
 			};
+
+			zynqmp_reset: reset-controller {
+				compatible = "xlnx,zynqmp-reset";
+				#reset-cells = <1>;
+			};
 		};
 	};
 
-- 
2.30.0

