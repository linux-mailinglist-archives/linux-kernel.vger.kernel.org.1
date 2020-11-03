Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D292A49BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgKCP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70354C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so18996912wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09rWMfnYlRyV4fsHRd/rYRk+bGuNPAWsDGRa94IF8Wk=;
        b=S+09FZvFo+rK/fy0qh1+2+2ezmDUOTqA9WfstkdC8TVG+rdrmhYY9rJMIcDCXpsL/G
         bDLmAQnwpYAZMoRXcQ4N01Gy8ojxHPkG9neRk9sfn5pJnQnQ0JxkbXBQzWB9DdEPCN+a
         p8gHudq7skun6bpt+D9RMmdq1zkxYIpkgGR/kFlwnhfEOlIoA3PQenpl5h7k3TKUgrV4
         Db/dO+666vsL2jh7ymUlDQueZ2LXqrvE0K179aq+tOiRm2DCu94BbtxbzWQkDya4shKM
         zNT0iY8O0m4KwVaPFPn5xE+71dTtKMVQhFSTecmquvcggiC1kfwA0aBc9mnQCZYtvk9B
         +z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09rWMfnYlRyV4fsHRd/rYRk+bGuNPAWsDGRa94IF8Wk=;
        b=Hn8AWF6KW5KHIqsYbhDw4ohxB9WPWQim/29/bihZjoProl2I8IrcH5OS+tZB9UUog9
         dXpbUXQX1Qw8eB+up1g2sGiO1EW1H4NTBbe2cb2wwRQIeoxn0AuKVEHAGTPaduWTsyYK
         qWQfWdFnPh9IpkHaLcK+kK3OVw7p2h81eHMMlSdr1Cffn8jIem8fD+PeutwIJbAOizMy
         dtkxbiAzXGzu5K4Txs1tl2dGpqtGZkRVRUmMvbwJn2tXiJRjyFISgUqikantJUSSDvX0
         kmtxJQkl5J1xeLTIxntOAfScCcwgLPAcDhT+KmQpTfQHnatCxSba1JWPduVsSNuhJ2mX
         sPHA==
X-Gm-Message-State: AOAM530ieHLO576pLig9o9SSUN96BUwG9PbHbFDMUQGwLFhUZ0jp8IFe
        GYS7w23BIilKCUhr2gupeb9wkg==
X-Google-Smtp-Source: ABdhPJzIyWFyZ3KPxpe4y9AY0PXslJv88KbGM78JaEbhk9VnsCtW3zJgrDjS4ckZLYicz+h9XI7yfw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr26077698wrt.51.1604417363188;
        Tue, 03 Nov 2020 07:29:23 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 10/25] soc: ti: wkup_m3_ipc: Document 'm3_ipc' parameter throughout
Date:   Tue,  3 Nov 2020 15:28:23 +0000
Message-Id: <20201103152838.1290217-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/wkup_m3_ipc.c:227: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_set_mem_type'
 drivers/soc/ti/wkup_m3_ipc.c:236: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_set_resume_address'
 drivers/soc/ti/wkup_m3_ipc.c:248: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_request_pm_status'
 drivers/soc/ti/wkup_m3_ipc.c:268: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_prepare_low_power'
 drivers/soc/ti/wkup_m3_ipc.c:322: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_finish_low_power'
 drivers/soc/ti/wkup_m3_ipc.c:369: warning: Function parameter or member 'm3_ipc' not described in 'wkup_m3_set_rtc_only'
 drivers/soc/ti/wkup_m3_ipc.c:369: warning: Excess function parameter 'wkup_m3_wakeup' description in 'wkup_m3_set_rtc_only'

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/wkup_m3_ipc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index e9ece45d7a333..c3e2161df732b 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -218,6 +218,7 @@ static int wkup_m3_is_available(struct wkup_m3_ipc *m3_ipc)
 /* Public functions */
 /**
  * wkup_m3_set_mem_type - Pass wkup_m3 which type of memory is in use
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  * @mem_type: memory type value read directly from emif
  *
  * wkup_m3 must know what memory type is in use to properly suspend
@@ -230,6 +231,7 @@ static void wkup_m3_set_mem_type(struct wkup_m3_ipc *m3_ipc, int mem_type)
 
 /**
  * wkup_m3_set_resume_address - Pass wkup_m3 resume address
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  * @addr: Physical address from which resume code should execute
  */
 static void wkup_m3_set_resume_address(struct wkup_m3_ipc *m3_ipc, void *addr)
@@ -239,6 +241,7 @@ static void wkup_m3_set_resume_address(struct wkup_m3_ipc *m3_ipc, void *addr)
 
 /**
  * wkup_m3_request_pm_status - Retrieve wkup_m3 status code after suspend
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  *
  * Returns code representing the status of a low power mode transition.
  *	0 - Successful transition
@@ -260,6 +263,7 @@ static int wkup_m3_request_pm_status(struct wkup_m3_ipc *m3_ipc)
 /**
  * wkup_m3_prepare_low_power - Request preparation for transition to
  *			       low power state
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  * @state: A kernel suspend state to enter, either MEM or STANDBY
  *
  * Returns 0 if preparation was successful, otherwise returns error code
@@ -315,6 +319,7 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 
 /**
  * wkup_m3_finish_low_power - Return m3 to reset state
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  *
  * Returns 0 if reset was successful, otherwise returns error code
  */
@@ -362,8 +367,7 @@ static const char *wkup_m3_request_wake_src(struct wkup_m3_ipc *m3_ipc)
 
 /**
  * wkup_m3_set_rtc_only - Set the rtc_only flag
- * @wkup_m3_wakeup: struct wkup_m3_wakeup_src * gets assigned the
- *                  wakeup src value
+ * @m3_ipc: Pointer to wkup_m3_ipc context
  */
 static void wkup_m3_set_rtc_only(struct wkup_m3_ipc *m3_ipc)
 {
-- 
2.25.1

