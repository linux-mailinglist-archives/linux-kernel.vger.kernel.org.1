Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B40288D73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgJIP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389507AbgJIP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:56:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3994C0613DA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:56:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m7so10709342oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrZJO7Q5TAom7Iz2MDVkwWu+RVJ+trX9KvWRo2x1VQw=;
        b=Ho/Nc3BclVhqaifWfu+1IjeMUp8B6qK0yWFT7ZRKn4mQsYxPId+CXkk656OKrxcoA+
         H3aUNePqLYVhzI4YsWl9kNg0uOkx/h508PG12x/zQW5FI7HuCrrkPtNobQULfGFKQtJm
         N/XeZkVxkezpUvbv5p+a7MmhiK4MK8A8IeZPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrZJO7Q5TAom7Iz2MDVkwWu+RVJ+trX9KvWRo2x1VQw=;
        b=lnZ9AxTeT5h6VNJC/h3ScM4LzqHhpyco/qYLGp2S8SQJteju1gnpMb814zWQmLUOfj
         slXqQ/SRix4qbgvTgiX/DkRVovF2dgQR1wwAvj26IAeh0DVMbufkKpX+ka3lq7RJwn8w
         HuK20buQgmzH6Z6jkglwmkDPXQJ/CqyX/5ir/bcEbTtvHuLPkt8O/xEhADvMP3vBt8qt
         3Kxs6WvOT0Klu3dc+rBfZv0oqnjAAOuAdTG3grI80vnSlJHOU81mBppcJfdA9j4uOGWb
         C2Lw0x9cBsjEkYYNEBnAfaejWtzO1rJvbvjYWL9lYMyzYpnsepWq+i76OUR3VyMgZNnM
         Ns/w==
X-Gm-Message-State: AOAM532VeXSxEuFGlE3UwMbElGHRoh9tDJTSC9E3y9hREV4KGsw+XSh3
        b16hJnUwvLfXYBhrWycOc8g83g==
X-Google-Smtp-Source: ABdhPJzDaaMzDN3HqDRosQ53Tp2yqcP0Yo/293AdelRsk9+u82c3di74+9EV8YoEwCjUOeCZwfBa4g==
X-Received: by 2002:aca:f40b:: with SMTP id s11mr2734357oih.66.1602258975181;
        Fri, 09 Oct 2020 08:56:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:14 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] drivers/base/devcoredump: convert devcd_count to counter_atomic32
Date:   Fri,  9 Oct 2020 09:55:59 -0600
Message-Id: <9eee4448ec53e3a875e6785fa63bcda211e09d23.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows
and should not be used to guard resource lifetimes, device usage and
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

