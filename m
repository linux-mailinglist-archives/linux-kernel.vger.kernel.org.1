Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10A02C553A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbgKZNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbgKZNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:12 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72243C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:12 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a15so2299251edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOxHaFaYSHFSFS1HRWVj0XZDRPEipBxeH9QarBmXRCs=;
        b=zikRDujfljA+ugW+Idv5HcQrqXcJ3t0HBBSZIfp1oxoAMLeIC7sj6i/800WlQDR5DV
         7MnO6otLT//SAba7JyLznoLNtRdnAseDHmW28Bd13s1LKHHo9LTTn9RlD/N2MW3EWtuf
         vEDR7RE653Vdp2j98LAjihHkchl4l6OofMXD90V3MldklSvCiQYS+TV/sm+CIdaZ/At8
         +MFaYG/Hs9ZctyvgJRLdiqU0EQEgyR+1l4L3Ro2pC2zzxnPoDpG3BgXjJgdOvIeabXYp
         XWmdZUFJEo7kJG5Q9EKXzJnMWfHmDdGaL+IrBWNe1BzHHkNAIGE0gXvAOXBjws6Yc8IH
         hSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZOxHaFaYSHFSFS1HRWVj0XZDRPEipBxeH9QarBmXRCs=;
        b=djXO3QLbZV3nTcF+v9x90UOOrq0ogC0iQkfL1IS7HQSQikTbNXwAjJHgtfmNhsaglg
         O1CGDEfouiO3ZFd1xE4Tvdh/vWWsLD13J/pU2WGhoEQjFdE6yJgeG/jQ9sblc0Bd3rtx
         SxFylzIxhqrDMGEtDBTFLMN9SnyMPe0werAMXQlfxkYUopaaNBDi1ij6KuaoAs09WeHZ
         nOVdyYxmXjzYadiP9Q63ssY4g7YNTvvFvigRH1jsWEK7k28tefgxG0AOGsYL9deCSEVZ
         JKhbIlJ9+/wpVLCXugO+lp+V+ho8nr7Dz+cz17903dsz/bwGrqAYMx8Tx3zEnoR9id0h
         Ph1A==
X-Gm-Message-State: AOAM5306N/05okXB1EGP+eYVW1N0YU6Ef7Zn8eMTN8HL9V/gIEHMwxbQ
        qLlYmJkp4LNGBXIhQ/dcZU4Yyhq6/juo/Dva
X-Google-Smtp-Source: ABdhPJyj0gtxjYuuA9vLFsINh97ecsWvj9dhXqC3MUV/pLtVaNiWoaNjmnMod3suvOsH4bXEzYqf9g==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr2494212edb.383.1606397111017;
        Thu, 26 Nov 2020 05:25:11 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b13sm3166289edu.21.2020.11.26.05.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 05:25:10 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ARM: zynq: Fix compatible string for adi,adxl345 chip
Date:   Thu, 26 Nov 2020 14:25:00 +0100
Message-Id: <a9075ab54df13461380e46d3002302d3672325b5.1606397101.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606397101.git.michal.simek@xilinx.com>
References: <cover.1606397101.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e359a29225dd ("dt-bindings: iio: accel: adxl345: switch to YAML
bindings") switched binding to yaml and the following error pop up:
../zynq-zturn-v5.dt.yaml: accelerometer@53: compatible: 'oneOf' conditional
failed, one must be
fixed:
['adi,adxl345', 'adxl345', 'adi,adxl34x', 'adxl34x'] is too long
Additional items are not allowed ('adi,adxl34x', 'adxl34x' were unexpected)
Additional items are not allowed ('adxl345', 'adi,adxl34x', 'adxl34x' were
unexpected)
'adi,adxl346' was expected
'adi,adxl345' was expected

Use only one compatible string to be aligned with the binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zturn-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/zynq-zturn-common.dtsi
index 84f3c85c5bab..bf5d1c4568b0 100644
--- a/arch/arm/boot/dts/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/zynq-zturn-common.dtsi
@@ -104,7 +104,7 @@ stlm75@49 {
 	};
 
 	accelerometer@53 {
-		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
+		compatible = "adi,adxl345";
 		reg = <0x53>;
 		interrupt-parent = <&intc>;
 		interrupts = <0x0 0x1e 0x4>;
-- 
2.29.2

