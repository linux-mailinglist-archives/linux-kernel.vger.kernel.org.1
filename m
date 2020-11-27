Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91E2C6B01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgK0RxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgK0RxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:11 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF4C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:11 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s63so4866976pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzkQ7KjTmf9uNjmH2W4CF/NveH5gwN6iZCEtNMeWTEE=;
        b=ZOmulhzGbIEbaEmzl2irtH/N1ShGxJL6T5d8r+SvnP3WTI4N+cI5F+0A9PEDqjtx7t
         2kXl2GDgWHS0Tk20x9uW8JDnWL+ubIUpAZr6BV1VKPGld/kpNKAmrIvByiMgyZnKHlBi
         S6oE/xDmM4Q74j+Pr0dvqUap828I6Uh8xGm1vHecXszKtvCqXhfKfPX+tB37XQea5LcJ
         LDKrdqULkZcLm7LUcEA3ygWi52eynYnPJIt9/xMj/IJPbxOY2RENnJF1B+7ufYzT2noV
         FkBGqZJnC1z8TJC2XstrrZLiRige8wmvaOuKkaATSu25JjFHWwrAO7YqkJQy3PmsK27t
         ynKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzkQ7KjTmf9uNjmH2W4CF/NveH5gwN6iZCEtNMeWTEE=;
        b=IEs0yjfBdAGGxM907/vysSWwKKocL1ZgH0UNBKbtW1PphLGjBFvB3snEMdLYcWNaJ7
         pRwyd8YRYTR1IKPsf6XHW2VhLFai6RX3OwwMYx74L3Fr4UM/pEUz7FvRMd95sye0oG7L
         0eElb3X/c0pZz998DBsdisnNVIccjf5Ou2uEKzPPvvAVsjWuM2EbS1eQTvDRagtpeI9h
         tt3odH6MB83s+zA1JoUgC15eYlmQN1o+6z/3tfdoReOXRcsx4zha3Yv8dTWU2Tcdy5ut
         kmJ8YF6+MoNlWJ3zjCOT7oFdVoqxK9A69mfsEk/HTtIS1l+e0hTes8X6q9Ej9Bh9rf2j
         H9Ug==
X-Gm-Message-State: AOAM530xbmDR75UXdDybnlHxd0+lCRj2cSAasISJmueMiQYIjiEUN9nX
        ZYinRRCBjlUCffHf6Ju7oZLgrg==
X-Google-Smtp-Source: ABdhPJx4WSZkOS6B0Ex8g/O/SFyMYlAm6FSrwBtntbL63U5cKhYc9cEzFiVtjN9erV+7wn0BxnuitA==
X-Received: by 2002:a17:90a:4408:: with SMTP id s8mr11691745pjg.69.1606499591039;
        Fri, 27 Nov 2020 09:53:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] coresight: Fix W=1 warnings in core framework
Date:   Fri, 27 Nov 2020 10:52:54 -0700
Message-Id: <20201127175256.1092685-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/hwtracing/coresight/coresight-etm4x-sysfs.o
  CC      drivers/hwtracing/coresight/coresight-stm.o
drivers/hwtracing/coresight/coresight-core.c:440: warning: Function parameter or member 'csdev' not described in 'coresight_disable_source'
drivers/hwtracing/coresight/coresight-core.c:670: warning: Function parameter or member 'csdev' not described in 'coresight_get_ref'
drivers/hwtracing/coresight/coresight-core.c:687: warning: Function parameter or member 'csdev' not described in 'coresight_put_ref'
drivers/hwtracing/coresight/coresight-core.c:758: warning: Function parameter or member 'sink' not described in '_coresight_build_path'
  CC      drivers/hwtracing/coresight/coresight-cpu-debug.o
  CC      drivers/hwtracing/coresight/coresight-catu.o

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 29c83eac3106..4ba801dffcb7 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -432,7 +432,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
  *  coresight_disable_source - Drop the reference count by 1 and disable
  *  the device if there are no users left.
  *
- *  @csdev - The coresight device to disable
+ *  @csdev: The coresight device to disable
  *
  *  Returns true if the device has been disabled.
  */
@@ -663,6 +663,9 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
 /**
  * coresight_get_ref- Helper function to increase reference count to module
  * and device.
+ *
+ * @csdev: The coresight device to get a reference on.
+ *
  * Return true in successful case and power up the device.
  * Return false when failed to get reference of module.
  */
@@ -682,6 +685,8 @@ static inline bool coresight_get_ref(struct coresight_device *csdev)
 /**
  * coresight_put_ref- Helper function to decrease reference count to module
  * and device. Power off the device.
+ *
+ * @csdev: The coresight device to decrement a reference from.
  */
 static inline void coresight_put_ref(struct coresight_device *csdev)
 {
@@ -744,6 +749,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
+ * @sink:	The final sink we want in this path.
  * @path:	The list to add devices to.
  *
  * The tree of Coresight device is traversed until an activated sink is
-- 
2.25.1

