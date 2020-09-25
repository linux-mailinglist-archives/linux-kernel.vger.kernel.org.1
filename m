Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5F279505
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgIYXr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgIYXrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m12so3962383otr.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL3UbhSLh7d+1ZqdEaNanE8PXSkKtcT1RyHqrCIqwTk=;
        b=V6Bl9f4G5+sqhOSRvV8rlGd0++3npD9GJJqtmJiHOsnN5xheVI9do4+okCULQvfKX9
         XQDjxTH4LbngebVemWeh3DZsKbiBXRavBfg6X07j8MpgEM6puLLRRhVdzqL5dJiU0ynO
         h6FmDHhWFXTK8AHdn99ml1Y9x5K0WBH3XyXOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL3UbhSLh7d+1ZqdEaNanE8PXSkKtcT1RyHqrCIqwTk=;
        b=nvid6SV56sSms7Q996E65CEzswR/A8lkzHPfW+SdIEuhUSyUyvGU+J9juw0bXTJevR
         3/XhGI+6LYKjacEwiEcyrafiq1LN4NnRsZgjMYjkMJJVmRN2mNySsAiZ6lQNpJ3NJdBN
         aOcgCMBeizKKPVtX3a+OWwZZKbyEIUJgyihOd1SkIoeSWaUxOt2rtadGmMyX7rzXsLLd
         rLXbaHXJCX0mbXz/4rfx/2JaSzfvxDn73+wocEB9sAhwp8rgUjNhpy//Eh/3yDAm4M3A
         WudS4Nwp5FvAw96LWa1Hsu+rpLL6Yvt7v2LaDTRabECEOlLpMdw4KnkLQPfilcBCMrId
         nipA==
X-Gm-Message-State: AOAM533vSiPK//xC2mEwZ3A0tr1KStt2UPoKZGM4kjIPx57jQIzaDODC
        Xas8MnU4ocJilusoPvnu2IIFAQ==
X-Google-Smtp-Source: ABdhPJyi+FJe6KdNSby3qXgRsn0i+mmOMN4X5R+eTCDPr3fSuKPK3PySbPQqKCy0siAkqIb/oZVk0A==
X-Received: by 2002:a9d:2d87:: with SMTP id g7mr1937951otb.320.1601077656778;
        Fri, 25 Sep 2020 16:47:36 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:36 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] drivers/base/devcoredump: convert devcd_count to counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:18 -0600
Message-Id: <3581777433f2cde69f5f9d2525381519131e5ea9.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
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

