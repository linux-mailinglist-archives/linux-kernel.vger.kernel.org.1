Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D62CB5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgLBHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgLBHjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:39:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A1C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:39:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l5so2177189edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSlfPd1wcZpRJTcXKlvrDMVis2WLtuBgGFmDaht+EfE=;
        b=N1gRPTrwA1eH6UwiPi5xPKMB5Q7dqhWwKG/uBkDeLi40Ub84KpQZWRAvUuERZal9aP
         h9lgek3iZQf533QfZTm3aX4WtMYTcU2b4Ew7N6AfITBW7trC0XTWncZza0oMGgGFSeeC
         jstZ+7auh7owoScDti0B+Yo+X89SYnObe+YNHc8UqpfKqMS5JTxSyg1nhqb4jpvQw0Tj
         21s2G+1OAEH7o3Owl4G8Qq0VYlSPju2cadHgqYFSXBkt1fwJmLLpUqT54nH0rylm1ygq
         pnKSd42hx55qkccWZlx2A9DTdsxdZ25fkVzvjexuASyd4fyxwVyBbtd4M+WkKrvAMpxh
         Xkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wSlfPd1wcZpRJTcXKlvrDMVis2WLtuBgGFmDaht+EfE=;
        b=OUpmz8ZgRaxzkbNDkjBxp9bdaQi68GDeSA61Vn1LEQM58ohMrKcC3DK/3zWee/zWRl
         0FLzEGBz6URrnNnXHi9rufCGsdBRr1A/miU2FU+4wc3Of7xcqiD/b8FPvG827pklLe4C
         DpqTqWMCDqmYz36D/TduQ+u8dcTqd8ndksbf5YPD08V9XtdIzy+BsSKObFtDNjWG2Pb4
         cmTB7bhqAJ2Tgk33kHNWHo5jdTQ/c91X2rijmbSMSq8oB0+cgkGatuthURRuahCBY296
         jIK6Ev6Ysbf7/lmTM8OL+Vj5fiLhAMapBBhGeO+LIrxpXDyVZZ3x3DRf5Qginxl7x7RK
         3SMQ==
X-Gm-Message-State: AOAM530mH6X7Wl06ufqvmH1vy1AEa9lHJ/N/MbYZcQ5WUOiQJdKkPolj
        KFVBPO9MKRqJrDGE7v1ZJ6eTVCuaOGNemHpz
X-Google-Smtp-Source: ABdhPJwtNJP0lcHG7wLMpRp0XPN42p+z6Az/cIDSnpDLY7reYrult+YrXBWZDOchM9qrGleb7ID8qQ==
X-Received: by 2002:a05:6402:1701:: with SMTP id y1mr1356901edu.209.1606894739253;
        Tue, 01 Dec 2020 23:38:59 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id mb15sm529165ejb.9.2020.12.01.23.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 23:38:58 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] firmware: xilinx: Remove additional newline
Date:   Wed,  2 Dec 2020 08:38:48 +0100
Message-Id: <d927f3f2c97910958dd77a22828cd0bf8d89c9de.1606894725.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606894725.git.michal.simek@xilinx.com>
References: <cover.1606894725.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This additional newline is useless and also reported by checkpatch
--strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

(no changes since v1)

 include/linux/firmware/xlnx-zynqmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f84244ea633b..0db9005782d6 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -316,7 +316,6 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
-
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.29.2

