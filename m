Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C794F26C88F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgIPSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgIPR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79099C02C2A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:27:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3493653wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gHI+qbWIwz9zkfajM31/QHKTBowobUtVBlgpmXh5N7s=;
        b=UFVJz5tTo6C0VyjXX/WcBw4YWSm38jrjzw37NIxCFSx3Qp0nVdggFLoxIXhaPqbVcl
         Obul3SMRumuEMBdTFUoG0QJxDyyo+yWYTUwQ2Ra81NgVCb+5WWAyHQesbyMIMNtWotrE
         hQ2M9/DShebggI+QPb7g5ruDtxYwHINh1AnZ6GIGs8bGFdD5Qt8WEb0RdWGfXTYCFf3y
         Q//vM2qemP4XobUIkdT2U4rXUxRzAkY/WbzEWP56KbISuJqkTxi+e1I3VIJ5w1zfBf1f
         XAW63VwYcWLt96yS8gn4PHaXESh3uwM7PIDBDSrzKJi8sAxxD2j8/IQhBZ26jMNI7wNM
         yynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gHI+qbWIwz9zkfajM31/QHKTBowobUtVBlgpmXh5N7s=;
        b=jCoCU7G8BfVA1FssT5lWWRQPeq24cKeJw5tBXNJmjx5IwSUrpuIugFmyfYtJ84lbNy
         8HdI0OPOO9cXTgglEQe5nUg2SmtGleZPSBd3oPA24Nr1IXMLFFXIemeTJHfWPsV9o87Y
         cbp4ebQqpYhP2A4KiXQJYm9g7g7dsFnAX4NJgMHUdnDByXnH+DDK5P8Nz5bdaVtFjbOw
         atPcPfVLLhIYFPijt9l2LX6LeWdnpJkSfpFbiY3r9cDKZKRVVpm895Nr7ZkWWn3JLbsM
         GrkMvQ5gDqwISDaMoeAelo2KSP0Pk3dW7bl8CbUrgNMdVsEOkjxoTYtvLJOIBw9CBJLZ
         bRDA==
X-Gm-Message-State: AOAM531P0COSW9K7c/AGqvTYt0MJj1kkHAQDVfnMVtdBl923Z/tXGvG1
        IWAHuAHu/fP4mD7SJlZcwzQAcA==
X-Google-Smtp-Source: ABdhPJyWpf7GuCYH2j9JIHZwPM0CvWEYa0JL52jwJznQxhAcMVYaQ8HK8sTJtrkd9orGlxk/1UDEmw==
X-Received: by 2002:a05:600c:2906:: with SMTP id i6mr5489059wmd.48.1600270056076;
        Wed, 16 Sep 2020 08:27:36 -0700 (PDT)
Received: from localhost.localdomain (123.red-81-34-51.dynamicip.rima-tde.net. [81.34.51.123])
        by smtp.gmail.com with ESMTPSA id i3sm33009626wrs.4.2020.09.16.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:27:35 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org,
        sumit.garg@linaro.org
Cc:     ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: optee: i2c: add bus retry configuration
Date:   Wed, 16 Sep 2020 17:27:32 +0200
Message-Id: <20200916152732.23604-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow OP-TEE to specify the number of retries in the adaptor.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/tee/optee/rpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1e3614e4798f..2d46a9ecb1de 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 	struct tee_param *params;
 	size_t i;
 	int ret = -EOPNOTSUPP;
+	int retries = 0;
 	u8 attr[] = {
 		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
 		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
@@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 	client.addr = params[0].u.value.c;
 	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
 
+	/* cache the current value */
+	retries = client.adapter->retries;
+
 	switch (params[0].u.value.a) {
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
+		client.adapter->retries = params[1].u.value.b;
 		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
 				      params[2].u.memref.size);
 		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
+		client.adapter->retries = params[1].u.value.b;
 		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
 				      params[2].u.memref.size);
 		break;
@@ -126,6 +132,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 			arg->ret = TEEC_SUCCESS;
 	}
 
+	client.adapter->retries = retries;
 	i2c_put_adapter(client.adapter);
 	kfree(params);
 	return;
-- 
2.17.1

