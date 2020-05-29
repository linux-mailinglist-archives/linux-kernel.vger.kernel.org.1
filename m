Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB251E7BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgE2L1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2L1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:27:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E843C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 124so1366700pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dgP79jKEPP7MXwHzZbUN9d9FldjpP7lv+/aoMCM0w8=;
        b=j6aJEOLx37LQfqAoeR/X9q4rItRoAeT0fPUkFBEX7Hli6YASNxJ8UHQFbMxl+5JYtG
         STQKCElCBMXh1RsorGJgqG3IOtnuRuuqPOuHaOg+julJFcPP0vTUgTAWQzoC4LpbmzPj
         n0Z7SLDnUTt8r80X8g/FSdnAWUpqoZdNTXR5yFHpo/Rb4Vhtksy2d6cNIZ+7C+WQmu9Z
         RLHpqIALYyyhRCZucQUFAkduwGAzyoJ2A707AizR2b54at5vFaRsG6aD26yj4Bd9QICO
         mYaXY8HseNlE5NMYYYnNvxb1MOkgvvSGxLwUN683D5cvNwCVzF6c1OA2QgP6WzS0Dyyl
         8F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dgP79jKEPP7MXwHzZbUN9d9FldjpP7lv+/aoMCM0w8=;
        b=W/7XKo6sJ15GhXJm6Vb/P+XDSpz8UXPJYjqXzAL4Ih+Jt04FU51MH4ptIfXzCmYhFR
         2iTg5bxGwQOrv5w0mMT4gqJqZCDn6xMj/RyRzQ/Q6nj1o7op3aXWjECJtVnqjlZfPIVa
         SN2JrPng3kIxlFQK6/V3H64zZ9EW+eU6GD85qT6xaKYORsosCxvOFk97NdwLV2Ox33Yw
         TDR6cTPrdYJuDmF6ivc+613cwkQsIjHWRIoYlyqCcehO93YUJD9RSs1HH/9paaeYSpZ7
         LT9pmfVCCIBhtmpLjATbQBAmWPHvryQsqsppfgBezJ7bvtfxjrmNAuRQbtlw59wN2wi6
         2fYg==
X-Gm-Message-State: AOAM531KvMfUgwQ/OYvAXS7oTi4Nm2jWi3dcK0Nit/2xU6scDG41OUsU
        q46X1n9+dIXW52rggFIuofhb+Q==
X-Google-Smtp-Source: ABdhPJyvF+SNj9X0aE2+/RwtRzMTeO8LTpn+2cGSVbSgb/wP+z5c/ho0ttS4850+4J4iLj6vCdF/Xg==
X-Received: by 2002:a62:e913:: with SMTP id j19mr8462277pfh.78.1590751649824;
        Fri, 29 May 2020 04:27:29 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id w190sm7016741pfw.35.2020.05.29.04.27.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:27:28 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/4] kdb: Check status of console prior to invoking handlers
Date:   Fri, 29 May 2020 16:56:45 +0530
Message-Id: <1590751607-29676-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a console is enabled prior to invoking corresponding write
handler.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index e46f33e..fad38eb 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -564,6 +564,8 @@ static void kdb_msg_write(char *msg, int msg_len)
 		kdb_io_write(msg, msg_len);
 
 	for_each_console(c) {
+		if (!(c->flags & CON_ENABLED))
+			continue;
 		c->write(c, msg, msg_len);
 		touch_nmi_watchdog();
 	}
-- 
2.7.4

