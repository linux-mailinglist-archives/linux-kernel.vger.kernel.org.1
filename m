Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C125CB37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgICUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgICUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F39FC06123D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e14so2948640qtm.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wTbIhLiuyTm+XoSeGxmt2GAAo+IvKYWaIE8cYk7ZU44=;
        b=ppe0VpEZBeDfsEU5ITwny6NkcdkxKAFIdZQ3UQnzTBxYV1ctHU67inW4vW137h4gBv
         nWXa8buMLxkA1rBskFYK1Eq0jsE+Qw/6BSGfBW65fCge+eKI/kv4A55AD2s+47ypACRJ
         cVE0+4wdwaCT6SrkHGr9ymZTLU8/wNLASZe7MqnKgh8hB4+OUomA4eJmR7t0BZXrjJW/
         LOvoQCoshN1779crEt6wAJjVHKmUtlw45dC2cFZP8uDI0DaAgpfMMNr88O/e/upP1nRo
         CSOVQI7ODlZsWF9jyXFOiYjx8Wwf0ptZxrDsx86udsnr+hYtU3KnXTgcc4ezeQUCHDis
         66oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wTbIhLiuyTm+XoSeGxmt2GAAo+IvKYWaIE8cYk7ZU44=;
        b=IEFk0/2+7y+imeCXN/bGle9Ru7Aq9H4sasqlcJgXx0X5aK1C6nlQ7Z10NpIPhW/tDT
         9tWodNdmHA5fZGIWazpV2tualfqBo5gkWMa9XrEwCWV29N+lULIRIWkPizBbqdmvlDbU
         k0QewKLYq0TOs4P2H+qpQjjhJ52BO8NvKm1GF4/L4r5m99rxB8OrlTGa8nHCQRCYegzj
         Qc9D1s4SjhqNPrZRmmfTLxmOMsIduZOG0mpp5cqA/MlV0hAhtgR3lxAlX+joXPvQh+ZM
         KMSmHngLQK2SYzpAnjpk1fTL0Au0gNAfdjb9sYtFQiQ8UCNjXM94ZuDYiSlUD7pLmny/
         mmvA==
X-Gm-Message-State: AOAM532LG2Pb/vxo32cz48PZ10GUIdaLvblc5IxXybZTdrpPYvgm7OaS
        pjeQsysajwr6+xHE030NqxX6djpw4yZmS+xbTnM=
X-Google-Smtp-Source: ABdhPJyv9bEdV3xRGJWnQr7fgcxwXMprdZ7rQuE4G3j1pIhhWyO6nI10INeeai4ZhUeY9OF61z4g8Dh58X2KMzWpmUw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:a342:: with SMTP id
 u60mr3554884qvu.2.1599165062979; Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:29 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 04/28] RAS/CEC: Fix cec_init() prototype
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Luca Stefani <luca.stefani.ge1@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Stefani <luca.stefani.ge1@gmail.com>

late_initcall() expects a function that returns an integer. Update the
function signature to match.

 [ bp: Massage commit message into proper sentences. ]

Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20200805095708.83939-1-luca.stefani.ge1@gmail.com
---
 drivers/ras/cec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c594..6939aa5b3dc7 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
 	.priority	= MCE_PRIO_CEC,
 };
 
-static void __init cec_init(void)
+static int __init cec_init(void)
 {
 	if (ce_arr.disabled)
-		return;
+		return -ENODEV;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
@@ -575,6 +575,7 @@ static void __init cec_init(void)
 	mce_register_decode_chain(&cec_nb);
 
 	pr_info("Correctable Errors collector initialized.\n");
+	return 0;
 }
 late_initcall(cec_init);
 
-- 
2.28.0.402.g5ffc5be6b7-goog

