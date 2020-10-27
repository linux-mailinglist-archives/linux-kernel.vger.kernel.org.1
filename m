Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6529AC37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900063AbgJ0MiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:38:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40734 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900053AbgJ0MiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:38:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id 23so1557010ljv.7;
        Tue, 27 Oct 2020 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vahP35hIg4Z9TX7Ulxw+JLPNjil+mWhfbx0IQp4z3Hk=;
        b=RpQ+Mlo6+D4vhkapHBOgMWurkzcLiQzSs5ACIKPeZXZobPykthQ+RLo7bqEd4UZgSu
         j+JJHJsXyApfvZL7P3wNe9g5KIQ/Xu89mnTzl9Ci9VoCjW8DHvvH13BHBozBUT9j0I+s
         U8j7pcrWKV3OUXv7uT1roALobi/RfgIktRnFCcWyzcAg4R3kBi/dmDSglEE0awySgraV
         9cdWG56+vJXUw+zr3avUGWg3abyIN4cyxSrSsOI3tXij/bxprUsP01mvqJ9TPiwr/CvA
         uyZSmL69oLkD2wiN00QYdF6JIY9AijgoOvqEi1L4niQdFtyDdjzLSXJr7jr+S98IQJEc
         Ldbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vahP35hIg4Z9TX7Ulxw+JLPNjil+mWhfbx0IQp4z3Hk=;
        b=gEVCFwdxhYVuCuGKNE5b/bFh30mz6nh2pCrZ3uxG1O0bEqpD0+xix9zuSaGmPTaNcv
         qqN/FqspC82lUBM6ep0I5PR5G0/cWasStVavh5hmbEG1bpBZ8nvXbO1dI0TJiS33o2FX
         QC/JN/GG1hn8M3bO4K5GCSWKUzECAGXDa29kMQXWQEhXYIyWkUOUFiMpuLm4/E6ekdS1
         ld/JaIhH3tIzEY7slk1yu/jee8X6569ICNhZoDS/eC7nlsw3usViLK50p6Z5ZzPDZoTd
         H9i8U0G4UE27jZA8i8Fq9dIKcLP/oKRcLE5LSnzgKwuLWtrvap8sgkgQKJpmOnNPkprS
         +I8Q==
X-Gm-Message-State: AOAM530VB9ikdwJarS44vZ4OSCLoeMkNgxcgm6Xnv8/PaE9GagkGr94c
        jVKbvrFJKOehaFC5RImW4P/PaT535A2qjtAA
X-Google-Smtp-Source: ABdhPJw+G0h55774/2Dna177AbD16UbvkWwJWYVmHDifFEnaYenPakmczFrXvoTkjirCT1kIqPxMNQ==
X-Received: by 2002:a2e:b5c1:: with SMTP id g1mr938842ljn.305.1603802284106;
        Tue, 27 Oct 2020 05:38:04 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-8-148.ip.moscow.rt.ru. [46.242.8.148])
        by smtp.gmail.com with ESMTPSA id e15sm49132ljj.60.2020.10.27.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:38:03 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to use v2 binding
Date:   Tue, 27 Oct 2020 15:37:20 +0300
Message-Id: <20201027123722.2935-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
changed to use v2 binding in the commit fa4c8ec6feaa
("ARM: dts: aspeed: Change KCS nodes to v2 binding").
For the proper initialization of /dev/ipmi-kcs* devices
KCS node variables also need to be changed to use v2 binding.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 60ba86f3e5bc..89ddc3847222 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -139,17 +139,17 @@
 
 &kcs1 {
 	status = "okay";
-	kcs_addr = <0x60>;
+	aspeed,lpc-io-reg = <0x60>;
 };
 
 &kcs2 {
 	status = "okay";
-	kcs_addr = <0x62>;
+	aspeed,lpc-io-reg = <0x62>;
 };
 
 &kcs4 {
 	status = "okay";
-	kcs_addr = <0x97DE>;
+	aspeed,lpc-io-reg = <0x97DE>;
 };
 
 &lpc_snoop {
-- 
2.17.1

