Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AEF2F9B87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbhARIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbhARItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:49:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:49:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dj23so14035047edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLgy4uJbi+BQB5I4n190H52GDURQtZ4WJsf6fAFPqdk=;
        b=j/gB5XW41QN04mhHc1JIZCBnvWyQYHBi8pv1txPW0yWZlsUTW2i5aFhcFqTC42OBNg
         eh9q4FD+5yx+dHELPUB2H+v8U7LV8Ji5LnnXqCCZaPvVFDQUYsYzINghE3MQLelBgNJX
         Bq2CChUODvtlqG5Up0B9eBky3M/DBKTPF1IWf/OkfJu2FQB9alz3HpA5YlPpuVXBqNTu
         JeGbDDaup0RkqS6ndG9qqSHePJiT8XcJEZK4Pi6WX0FzjBYdbo8exd0twAzIFhhxGNO3
         zOJ4DhkL55BcWM1cPqnoPvpKNaX9zqSs8u1FPJSPNvqUGlNKYPqGRX4gbvQ0yYp+SV10
         SLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KLgy4uJbi+BQB5I4n190H52GDURQtZ4WJsf6fAFPqdk=;
        b=KPgkTG3JIDeW7hiSe0sVvPW9cDRPlMgIirtWH+GT+4zUQqxwOFJJfQTAzFpJzP/eOa
         4qHJTgmBdjzy9FfqshF5AyFcpKnelQnH4hUYuWIgenZtI1IWsUf4Wcnd3mrwAR4Vb8/B
         lOfQD/0pTxQtvBzrmU1kJbqrgO+Q1znm0megTOSb/dmCJnKH+3aeq6/PVm5erxvbNcX/
         drAmJKbVac9M/9X1DwgMEljqKcp5VRY6/+VeH3SBNg+2tRu70WND3OgDsguZu0CLaj6e
         C2+MPpMNRVPp8yagsAqHVmHTT03Rk8KmOEq5XGTB4A0waMF+zgmWqEjVWA4Ohq+5XMI8
         tsBQ==
X-Gm-Message-State: AOAM532z5AILdEbmld429IAQjnZktkvIUZi6pqDS8LP95933JYzEOJit
        m+sywVCirJK+R+GuQPK6WzzrNCioXrOJb/iR
X-Google-Smtp-Source: ABdhPJwih4nvB/5Q3a9bW/KRLWfSHgumWIqNV/eHRUz84LwmuOib5Vrw8bdAr1dtPcehN+4RTQ56Vg==
X-Received: by 2002:a05:6402:4310:: with SMTP id m16mr1627018edc.207.1610959738570;
        Mon, 18 Jan 2021 00:48:58 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q20sm9152392eju.1.2021.01.18.00.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jan 2021 00:48:58 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: xilinx: Remove PM_API_MAX value
Date:   Mon, 18 Jan 2021 09:48:56 +0100
Message-Id: <86e94593a29a1b5b1958c539a1bfabdd08c0948e.1610959734.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep PM_API_MAX around. The commit acfdd18591ea
("firmware: xilinx: Use hash-table for api feature check") removed its
usage that's why it is not used anywhere now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 include/linux/firmware/xlnx-zynqmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2a0da841c942..0a483249ff30 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -85,7 +85,6 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
-	PM_API_MAX,
 };
 
 /* PMU-FW return status codes */
-- 
2.30.0

