Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BE303673
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbhAZGXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbhAYNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:34:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B800822ADF;
        Mon, 25 Jan 2021 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611574681;
        bh=wrpLUDEl/zBuFbhcdeOfCc9UxWrpKGhvhTPei7NbMyc=;
        h=From:To:Cc:Subject:Date:From;
        b=pLfaKo9ciycf7E/QR5xXj1iS0iJjRe8H0BbjR6tPabcrsXM5w6bhHCVUYzhR/QOha
         W44m36hrvoY7YkJF/MLFVkNSR/CtpB6RCsMJEAkkRmx46DWXMpxoFe0ptAvdwbrxdG
         unJ9Om/cuomt9x7Q5cu57o8bi8XwC3Iu3UhNZEAEUm81hUNSuU/dcvsCbeH5I4Zl6r
         Ym93VDlqEL724b3Y1Dstc+KR61Zx2dV40yXxgIn/DwCZTLLInYFIObroTnfTWwDLss
         k7Mx4ClnA7tuRIl1PQjNc/COMHZXjMzz62Hm33QZlDh1ZCYNZyIzpCDGOVfyS5Jwa2
         7X9l9hgBSWsJg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] optee: simplify i2c access
Date:   Mon, 25 Jan 2021 12:37:52 +0100
Message-Id: <20210125113758.2430680-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Storing a bogus i2c_client structure on the stack adds overhead and
causes a compile-time warning:

drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,

Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
open-code the i2c_transfer() call, which makes it easier to read
and avoids the warning.

Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1e3614e4798f..6cbb3643c6c4 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -54,8 +54,9 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 					     struct optee_msg_arg *arg)
 {
-	struct i2c_client client = { 0 };
 	struct tee_param *params;
+	struct i2c_adapter *adapter;
+	struct i2c_msg msg = { };
 	size_t i;
 	int ret = -EOPNOTSUPP;
 	u8 attr[] = {
@@ -85,48 +86,48 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 			goto bad;
 	}
 
-	client.adapter = i2c_get_adapter(params[0].u.value.b);
-	if (!client.adapter)
+	adapter = i2c_get_adapter(params[0].u.value.b);
+	if (!adapter)
 		goto bad;
 
 	if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
-		if (!i2c_check_functionality(client.adapter,
+		if (!i2c_check_functionality(adapter,
 					     I2C_FUNC_10BIT_ADDR)) {
-			i2c_put_adapter(client.adapter);
+			i2c_put_adapter(adapter);
 			goto bad;
 		}
 
-		client.flags = I2C_CLIENT_TEN;
+		msg.flags = I2C_M_TEN;
 	}
 
-	client.addr = params[0].u.value.c;
-	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
+	msg.addr = params[0].u.value.c;
+	msg.buf  = params[2].u.memref.shm->kaddr;
+	msg.len  = params[2].u.memref.size;
 
 	switch (params[0].u.value.a) {
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
-		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
-				      params[2].u.memref.size);
+		msg.flags |= I2C_M_RD;
 		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
-		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
-				      params[2].u.memref.size);
 		break;
 	default:
-		i2c_put_adapter(client.adapter);
+		i2c_put_adapter(adapter);
 		goto bad;
 	}
 
+	ret = i2c_transfer(adapter, &msg, 1);
+
 	if (ret < 0) {
 		arg->ret = TEEC_ERROR_COMMUNICATION;
 	} else {
-		params[3].u.value.a = ret;
+		params[3].u.value.a = msg.len;
 		if (optee_to_msg_param(arg->params, arg->num_params, params))
 			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 		else
 			arg->ret = TEEC_SUCCESS;
 	}
 
-	i2c_put_adapter(client.adapter);
+	i2c_put_adapter(adapter);
 	kfree(params);
 	return;
 bad:
-- 
2.29.2

