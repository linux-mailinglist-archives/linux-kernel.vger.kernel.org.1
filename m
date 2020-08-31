Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18123257C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHaPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgHaPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:24:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:24:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so5766150wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dvYzGJEwlKQ4oaoHvH6x6ZwL9J6MC4fiH/79xLovz68=;
        b=tHtUBwm8E4bgbcV6ybDffvHXUIA7ZNp7nRlJBr1IOkROnwDdqEOfA/lcXj4vJcN/hp
         h3iqbqtZpmPRtMpbYwsh9XxBLeINWXruq8+EilFAalRX2jrUO8ERMlN8oY6sYFriOQjT
         Mioxc290LaLX9kfWVyvZVlMS4WzqSibG6JOlKRvjdhwO+lfVOfwo9CLCSmKLd0G0pJgF
         Ck2lcr5Su6N2dTN9O37rq5R1rhuBULGrvhZem+158d2eFtteYCClX1+oCshCoESYMOvG
         hrJEevACtw8PYY3NK5SwFHv4KtOe4fIXzscUsd9oi94pXxNP3QpK+HFspNCZo0TYtTN+
         24qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dvYzGJEwlKQ4oaoHvH6x6ZwL9J6MC4fiH/79xLovz68=;
        b=qTN/HdOg4GqiJLMNP4kYv/asHA78Paa7DT1MibMzTKn+1L3DmCB/GYxixRxmChYb/v
         H3ftvIZDyMKOCgwZXOJMg9hzjk3woZvadSvi+2piKw2dNfq5R9XivHt5Jez64XrYWwLd
         8ExyqHQK+AZX5A22Pns6Yp6T5hOkIqcfZh6mfhxT+vB0l0PPezUrOx/URLtglVkVDgjF
         ltEjZIDD14eQdkQYtNiT8mIA6Mm6Z3fRKlnF2IH+8sFOHUGwLlQfqZl1OD7jyKRPcaMA
         2db9HLTJ3F9jXGDznHZVgyloRx1nDFIhVxCokz2PVhogMIx0OkAEaeh2+uln26xqidws
         mCIA==
X-Gm-Message-State: AOAM531T5D5VIHEgT5g3Xi8lqfLMTLIclZ6ORgmmoR95cC9akLQnxScS
        84PXRf1P6GfdsVcSwbwUhLM8hQ==
X-Google-Smtp-Source: ABdhPJwuGf5Us4UjDxHn44IbwjOuU2baGp20DyJPXp8qWXqg/iwIZvy4fwgD5L08tnTEle8yrIgh+g==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr1932623wma.13.1598887443837;
        Mon, 31 Aug 2020 08:24:03 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id m1sm12012333wmc.28.2020.08.31.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 08:24:03 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, ricardo@foundries.io
Subject: [PATCH] drivers: optee: fix i2c build issue
Date:   Mon, 31 Aug 2020 17:23:59 +0200
Message-Id: <20200831152359.9122-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the optee driver is compiled into the kernel while the i2c core
is configured as a module, the i2c symbols are not available.

This commit addresses the situation by disabling the i2c support for
this use case while allowing it in all other scenarios:

 i2c=y, optee=y
 i2c=m, optee=m
 i2c=y, optee=m
 i2c=m, optee=y (not supported)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---

  This patch applies on top of
  https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=optee-i2c-for-v5.10

 drivers/tee/optee/rpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 64a206c56264..96e91d5f0a86 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -51,6 +51,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 }
 
 #if IS_ENABLED(CONFIG_I2C)
+#if !defined(CONFIG_I2C_MODULE) || defined(CONFIG_OPTEE_MODULE)
 static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 					     struct optee_msg_arg *arg)
 {
@@ -140,6 +141,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 	arg->ret = TEEC_ERROR_NOT_SUPPORTED;
 }
 #endif
+#endif
 
 static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
 {
-- 
2.17.1

