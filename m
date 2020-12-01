Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC802CA76C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbgLAPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLAPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:51:17 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75FC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:50:36 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id m19so5025451ejj.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5Fi5YoyT6MBjo5vUsLo0fuG9ESwTVMogXJl67sgqJk=;
        b=r+6EfvR40U6/LOyA8XJbL767OhPmq5ESnlu6TXnFLI8kV1dUVGtHSFMEUqhEdp828L
         j30x5qJcvhzaE3/0QHXoLEHJMvy5gjg/XdvDNLw17B/w4A0m0yyP8aQt6nqxh7OmRNKO
         yj5uSZWR3hXNY7vuDFgi00x4ajk7L68bGyE5xCsfdcKd+FORUb+ifIcLnddXJc4VO2AI
         Mx2jrndjn2dRafDwDjT2ItjPYZom5AgaLUL+I6WH7R/VGnTbqpOi3qriMFvclijyUFwC
         IaUCJ728Qr+AxEqW8gDkqQiDasCeDVpqnOLARL5wCTb5YnHSf0bYSQbHuZ9h4GfyKoHO
         uc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=d5Fi5YoyT6MBjo5vUsLo0fuG9ESwTVMogXJl67sgqJk=;
        b=I0UnE4lKMUQ/YjaAQ/G8cmklxYAmQK9FCQGFUWiZbQgq9kztVerJS3YtgeIIOw7GQe
         z21knMzj5TrbZis6GK8hSo+BFSUxhTq8moxDZPgJ5WUMPalGsnNv/ClbqyPZpPL7yfQQ
         +ESgOenaXTWPPhZfrOHYVhMtHzKu4xnw6z4llEpC+SS3tFhyNQYqU0j7Cgg9pTfojNoI
         /U9Jr3nxXDOItr2VepTe60Ce1+rYkINGzXaYuTWirH4ai0Q1MG1yedDNCEchiOSVuGqO
         f8hcci+PgnVxdSYUce5st88rcP2G+LqaxOY8F/JrwBqqglp62Jl3JyFVRPDprxmDV7Ze
         vVeg==
X-Gm-Message-State: AOAM532xpO7ZqKTs1Crht2Xzxl98IGF1FPvQyJ2+uJytNY+NSgiVX6t7
        vV/Jz6BusX57M3dPsd0iMST+xiw6fJpZNDwA
X-Google-Smtp-Source: ABdhPJxMqOOxJ4PPdAU2gwXpT+BWqh42jFC6oi5BWOi76yqIpmWNKQD6z+EFoHE5o4UvEtYUBBpQUg==
X-Received: by 2002:a17:906:4f04:: with SMTP id t4mr3611704eju.50.1606837835069;
        Tue, 01 Dec 2020 07:50:35 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id dx7sm54945ejb.120.2020.12.01.07.50.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 07:50:34 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] firmware: xilinx: Properly align function parameter
Date:   Tue,  1 Dec 2020 16:50:26 +0100
Message-Id: <fb0a22fd12f6a1d69e4e66aafba5b84859d4a60c.1606837822.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606837822.git.michal.simek@xilinx.com>
References: <cover.1606837822.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix parameters alignment reported by checkpatch --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 include/linux/firmware/xlnx-zynqmp.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 0e7e72650ed3..c5cdc68e431f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -456,7 +456,8 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 }
 
 static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
-			   const enum zynqmp_pm_reset_action assert_flag)
+					 const enum zynqmp_pm_reset_action
+					 assert_flag)
 {
 	return -ENODEV;
 }
@@ -490,9 +491,10 @@ static inline int zynqmp_pm_release_node(const u32 node)
 }
 
 static inline int zynqmp_pm_set_requirement(const u32 node,
-					const u32 capabilities,
-					const u32 qos,
-					const enum zynqmp_pm_request_ack ack)
+					    const u32 capabilities,
+					    const u32 qos,
+					    const enum zynqmp_pm_request_ack
+					    ack)
 {
 	return -ENODEV;
 }
-- 
2.29.2

