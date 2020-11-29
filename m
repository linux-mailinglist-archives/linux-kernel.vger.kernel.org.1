Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC512C7829
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgK2GGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgK2GGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:06:10 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200DBC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:05:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so8103993pfu.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AP1He76mSIpMJ7kjPnH8UBYNbpoUWQOGvAFw0wjETBU=;
        b=AuYlyvsbuCxBGS6m3QFCQKhe5yg7MLKYCz9120Im5R3hmszQkNuAqnXMxZkbuHEZYW
         PKgtLlMUnVrxJtBNwhNg2oGZ2MH3FHHj/f6ZaaYd+RjtqR1po1Ppi7vF8z1nRUOBclTW
         MNSS5sVphuQkf5qh/RMTMXW3FGCgEhuBjgMjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AP1He76mSIpMJ7kjPnH8UBYNbpoUWQOGvAFw0wjETBU=;
        b=rcdxmKXjNixCec5wyjxWiJuo+hSt2Fh5bsiYkPvSBZPQZBZiNAsDKjikI9ZjD0xb6n
         ibGIx8vo6Gtp4LysqK7a/QcPPSJX/N6INEsieQTQFaCAQiEBXhqrH8sBg4G0mSlvYjN7
         Rmh0K8T8FlnedoO69ZRWqLknj7Cmml8U/9JzfhViGYbbI0vwTjt/TMSUyZNTx0f30J9q
         ZkUBkH+4Py/LRxdvz8nKQR5o4c5dj2k5SE2o10tvUXsFpZLSoQAooyFhZW3LuaEBKkbG
         eDdr9lTti8xFH8dO1xSLYzh9bCuOuqpXIL/bIUDpBZoLAnm5DEGu+6qHP+EBt481KCt7
         DhCQ==
X-Gm-Message-State: AOAM531EAAkBESS+cUg9LU6tbA/hzjOpu5rEFm5v/XfqsRKEAXW11yDV
        eXXhOBIbpNm5dl1YtFXbH7QbIg==
X-Google-Smtp-Source: ABdhPJwGbVaKeNQPzHDymfV6x9Nb27z0MQSqwKBXslQZGoMB9tfF+MSanOfoMzKnWKUxh8dBdE8tHw==
X-Received: by 2002:a17:90a:4405:: with SMTP id s5mr19544319pjg.219.1606629929757;
        Sat, 28 Nov 2020 22:05:29 -0800 (PST)
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with ESMTPSA id 65sm12273232pfd.184.2020.11.28.22.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:05:29 -0800 (PST)
From:   Fritz Koenig <frkoenig@chromium.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanimir.varbanov@linaro.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org,
        acourbot@chromium.org
Cc:     Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH] venus: venc: Add VIDIOC_TRY_ENCODER_CMD support
Date:   Sun, 29 Nov 2020 06:05:18 +0000
Message-Id: <20201129060517.2029659-1-frkoenig@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2_ENC_CMD_STOP and V4L2_ENC_CMD_START are already
supported.  Add a way to query for support.

---
 drivers/media/platform/qcom/venus/venc.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 2ddfeddf98514..e05db3c4bfb24 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -507,6 +507,27 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
 	return 0;
 }
 
+static int
+venc_try_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
+{
+	struct venus_inst *inst = to_inst(file);
+	struct device *dev = inst->core->dev_dec;
+
+	switch (cmd->cmd) {
+	case V4L2_ENC_CMD_STOP:
+	case V4L2_ENC_CMD_START:
+		if (cmd->flags != 0) {
+			dev_dbg(dev, "flags=%u are not supported", cmd->flags);
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
 {
@@ -514,6 +535,10 @@ venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
 	struct hfi_frame_data fdata = {0};
 	int ret = 0;
 
+	ret = venc_try_encoder_cmd(file, fh, cmd);
+	if (ret < 0)
+		return ret;
+
 	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
 	if (ret)
 		return ret;
@@ -575,6 +600,7 @@ static const struct v4l2_ioctl_ops venc_ioctl_ops = {
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 	.vidioc_encoder_cmd = venc_encoder_cmd,
+	.vidioc_try_encoder_cmd = venc_try_encoder_cmd,
 };
 
 static int venc_set_properties(struct venus_inst *inst)
-- 
2.29.2.454.gaff20da3a2-goog

