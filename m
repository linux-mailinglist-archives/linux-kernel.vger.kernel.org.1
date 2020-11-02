Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC12A271D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgKBJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgKBJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:37:12 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0DC0617A6;
        Mon,  2 Nov 2020 01:37:12 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id w1so12542395edv.11;
        Mon, 02 Nov 2020 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6+Y+v0mf5SvNQeLGUI6zmXJKmFCPE8MP5k1v0xa403Q=;
        b=T0IiFkoGw/VutmwGqmNfU32mueLGJj0iuYjWgcxrv2K4fC8vDS2cq/gyeP5CFKI2X0
         Q7GyrPCodpPtidHLcjgrw0DSvwarhkgh0smTPV8XOfuFuU4S2PsjR6H0oOnjTRf/iaE1
         stUIe95sYdoislI54rkk8QudNRyNV9TevNOjyKr3Gx07o6KszYHqkRfGlp3aZRCf+DfJ
         ninx03dPB5ywJ97FX7zj+/AviXdSk068IqD+SFwQD9q0n2u1jmXNmyl/sej3oN12l6xN
         CU2FdWFqjmjw16sPFaLVMR8V15iMdZQVuIOx7kuYo8MbCuxJZnhsv3J4tU++InF4nEfT
         /5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+Y+v0mf5SvNQeLGUI6zmXJKmFCPE8MP5k1v0xa403Q=;
        b=aGqVgr44FlTj8AhoyYDU4rQFeq93QD8aCBPO93mP5ug1KP8nGmgRpIJ/ddSLp/9tLe
         twZOtF9pknYyKk/ZObndFsf4vFMSE7UKDWFnWaRhbMOD16Yrkied0PksbKRQrywNFOOg
         kJGw+Ly1yChx8qnHyXa/qelcRqy4r4wmLvg+6t8/esfWuIWi57VEXQtkyR70PIzlkoj/
         cnuvCWIPciVhWo8FeW/ygj735x5nQd2APoexz+1XwIbElpceiPC22bM1qUr5KN3PzN+l
         Ow4a4kTCic7PUE1ErMpV7kpUa4qibLt3yivX5KSU4fGwjfrFcR6m50QWMTUJdJDBmuVM
         Pn8g==
X-Gm-Message-State: AOAM533XTd4UXySfQOynszj2FmHyG1B5JAu1pw28rjSLe07WX24a9t1O
        S5CI1Z7/+QpZFc9eiI3Xi5J5zUgc7XltIA==
X-Google-Smtp-Source: ABdhPJx6W+MqfydSGNKb1O3iuE8j3JN20EMQixH/SZXtccxAAFRSK/NUaB7tHa5Fdpgym41WevBedg==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr16107554edq.43.1604309831173;
        Mon, 02 Nov 2020 01:37:11 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d08:5700:a4fc:57d8:461e:80f1])
        by smtp.gmail.com with ESMTPSA id d23sm5961922eds.48.2020.11.02.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:37:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: replace non-matching patterns for loongson{2,3}
Date:   Mon,  2 Nov 2020 10:37:02 +0100
Message-Id: <20201102093702.15512-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ffe1f9356fbe ("MAINTAINERS: Add Loongson-2/Loongson-3 maintainers")
adds quite generic file entries for drivers/*/*loongson{2,3}* and
drivers/*/*/*loongson{2,3}* to be informed on changes to all loongson{2,3}
files in drivers.

However, only the pattern 'drivers/*/*loongson2*' matches to one file in
the repository, i.e., drivers/cpufreq/loongson2_cpufreq.c; all other
patterns have no file matches.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/*/*/*loongson2*
  warning: no file matches    F:    drivers/*/*/*loongson3*
  warning: no file matches    F:    drivers/*/*loongson3*

As in the last two and half years, no further files and drivers have
showed up to match those patterns, just name the one file that matches
explicitly and delete the others without a match.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201102

Keguang, Huacai, Jiaxun, please ack.

Thomas, please pick this minor non-urgent cleanup patch.

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4197e9da495..fc08f628e196 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11719,8 +11719,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson2ef/
 F:	arch/mips/loongson2ef/
-F:	drivers/*/*/*loongson2*
-F:	drivers/*/*loongson2*
+F:	drivers/cpufreq/loongson2_cpufreq.c
 
 MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
@@ -11729,8 +11728,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson64/
 F:	arch/mips/loongson64/
-F:	drivers/*/*/*loongson3*
-F:	drivers/*/*loongson3*
 F:	drivers/irqchip/irq-loongson*
 F:	drivers/platform/mips/cpu_hwmon.c
 
-- 
2.17.1

