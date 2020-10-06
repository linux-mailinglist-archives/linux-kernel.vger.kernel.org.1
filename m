Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9128535D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgJFUpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbgJFUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:45:49 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2522C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:45:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id 67so11205852iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL3UbhSLh7d+1ZqdEaNanE8PXSkKtcT1RyHqrCIqwTk=;
        b=ak34+J6BY/OCwhBPDFbVW3xHa8XwH7H7yjyBmbk3s1QQ9nfM9ir+oFxz83TgABIe5R
         cCLxwbyneRcVZswESgse1P3xFb93GIX0vuAsZfYmMOH0T7bjkY44glEmsRpX1spCUzS9
         Sn2zMcU950AQdhJZZLmBQC69/cVEh20vVc+Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL3UbhSLh7d+1ZqdEaNanE8PXSkKtcT1RyHqrCIqwTk=;
        b=tKJeElx81JEg5SvksKxTFs6k0CRI5/zzBd5pyej3ZXCw+vdmtfw4MzwuXOFOcG1JHi
         LQ/FBiRCrCfjl1VU/QF1fz+maJ9l5I7x3rsi0Fw+9LSUX9OpNzjZ4X60+reBuLjuM3ei
         Ys4a7ZGMtmhQSgt+KSB0lNp7bRQ9/sK6JRMPvnkQjCYD0oVa7DXCzz0ha+l/JgRWUPPw
         I6KjcsturvEq0oLTGqMcViqg+A9uvxWL2QOSsddtA0KGDHwYRKL3VAp3pMuMRnpHzUqQ
         ejQ55lVG8GizKyvumXFwPI58TUfuTamstrWzCIQXIaSlcPz9lq7jbqYWYSDJArSE9qYS
         MZ7A==
X-Gm-Message-State: AOAM533pWeVDD/bCGwAV5IZAzFJ9rW2aiMuDK78c+u8iLQiAgOMac/Nb
        cvbTafE7f04uq0YCIF6/fQI3rw==
X-Google-Smtp-Source: ABdhPJyD20RJw/Vi1O2SZEehUtfx5tUgq1awjVyOcxcwtq+aJ4wH/tGLcMw5po0Hqb1/8DGCj6LYFw==
X-Received: by 2002:a6b:15c7:: with SMTP id 190mr2730191iov.54.1602017149121;
        Tue, 06 Oct 2020 13:45:49 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:48 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count to counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:35 -0600
Message-Id: <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

devcd_count is used to track dev_coredumpm device count and used in
device name string. It doesn't guard object lifetimes, device usage
counts, device open counts, and pm states. There is very little chance
of this counter overflowing. Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/base/devcoredump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b514384..59bc48ee44af 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/counters.h>
 
 static struct class devcd_class;
 
@@ -255,7 +256,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 				   void *data, size_t datalen),
 		   void (*free)(void *data))
 {
-	static atomic_t devcd_count = ATOMIC_INIT(0);
+	static struct counter_atomic32 devcd_count = COUNTER_ATOMIC_INIT(0);
 	struct devcd_entry *devcd;
 	struct device *existing;
 
@@ -286,7 +287,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
-		     atomic_inc_return(&devcd_count));
+		     counter_atomic32_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
 	if (device_add(&devcd->devcd_dev))
-- 
2.25.1

