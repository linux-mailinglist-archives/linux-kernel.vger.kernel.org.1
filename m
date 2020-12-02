Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5352CB5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgLBHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgLBHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:39:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:39:04 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so1997088ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zn1WORb+fwgcTwpy2Ku70Wdb1cJFmwbuu6lag/0wEvU=;
        b=JYTj2gN4gm2x2fsPv/LfZBb9oN5E8pVZWQSlDFbnWPn+dagamy2pYUTN//S1KhtQNW
         ApUn9kg8UIv2tnWStyiSDraStlAMZQ5IkWZVULaAmbGhOmrjj9MzWaeGf6JkbEbwarsB
         uXXghk47c2Xhb+fWZyfxHok7B+ZsW6Zzh59EqocMxSTupzbmyr3rkb8tqj4Uk6wnqxMv
         BAzRlRQA7AoSYYE2f5gT5kVv/EiAfOJwgGJimTJv3fIfpK9LJlVvvjhNZZeA7M/ZtlNC
         NODP/JQPs8Zj9MEkF5Ddsu1pzTLs/7FuCb5xn7ETDPGZN4pF1+djMb9pBLI0M1SZE+U5
         ioNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zn1WORb+fwgcTwpy2Ku70Wdb1cJFmwbuu6lag/0wEvU=;
        b=IlviuQDjLeNWzlKEL38W7OJQgC+AQu51LowwpakD+C9P/SCN2PEBsMbNvwlUlmjGMs
         72VwOtq82/lvjoFZ/dU5r+IvMXq3ZPD9p3VqJ1VOsNrN0XOTr1xU4UxSWwEuFJN/sdWY
         uXMRJ2PCC/OL3pdkaYX6SxS8GylVi8dltl93HT2hIo5IStCSunj9oEN++qiZulGhaacx
         Jrxg15BqdWaIfXGTlkDpUqLtin//pPYN2xWV8k8KUhmxE6kLcLCEkmJhOWAoipmifDtW
         x6nEmbKN0bP6CS3q63GcL66P5i5QRh2sitHnxFjlZeHO1f2GZCwJ8le7s+j2JFMzBayf
         XnIQ==
X-Gm-Message-State: AOAM531S83nL0gH+UngMA9sR31UC1wxtUHMvwDaZQKaZArwOJ7UP9CBO
        ETOJdEVkG3Ea4JJ+V167+w3gPiHnsP++5L9U
X-Google-Smtp-Source: ABdhPJxrWTRmiF3m/XYc+4HpOYp0GasuSwCTTsb1YoszLSEXsDPS/x/oEMYW69btRoX/JbiHefS6Tg==
X-Received: by 2002:a17:906:edc4:: with SMTP id sb4mr1074061ejb.21.1606894742567;
        Tue, 01 Dec 2020 23:39:02 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id pk19sm527580ejb.32.2020.12.01.23.39.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 23:39:02 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] firmware: xilinx: Properly align function parameter
Date:   Wed,  2 Dec 2020 08:38:50 +0100
Message-Id: <00ed9fcb94a6c22eff1fe8afdea46b2764a8687d.1606894725.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606894725.git.michal.simek@xilinx.com>
References: <cover.1606894725.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix parameters alignment reported by checkpatch --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- keep variable name and type on the same line - reported by Joe Perches

 include/linux/firmware/xlnx-zynqmp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 0e7e72650ed3..edc2977b26d9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -456,7 +456,7 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 }
 
 static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
-			   const enum zynqmp_pm_reset_action assert_flag)
+					 const enum zynqmp_pm_reset_action assert_flag)
 {
 	return -ENODEV;
 }
@@ -490,9 +490,9 @@ static inline int zynqmp_pm_release_node(const u32 node)
 }
 
 static inline int zynqmp_pm_set_requirement(const u32 node,
-					const u32 capabilities,
-					const u32 qos,
-					const enum zynqmp_pm_request_ack ack)
+					    const u32 capabilities,
+					    const u32 qos,
+					    const enum zynqmp_pm_request_ack ack)
 {
 	return -ENODEV;
 }
-- 
2.29.2

