Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F82B9F15
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKTAK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKTAK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:10:57 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1554C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:10:55 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so10452051ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHTQ09ms588+UpKY9R43+BC+T+D0Aapxn3qmLnckRdI=;
        b=XPlXiw46FSemcBKRoOKNNQnGUdTBhsiSyqgouYR1IbEKgCJYNMz/FXHvSq4dJ6P7Xj
         pkwE7cCegNift3rcuFCdN+ArxEv6b1PbvvBebtRSBAUovmlY2fKenivK7xDb+E3LZEcA
         MWil0sBIeGCBrewI6yZI9tKI/2QKqqZ9SrWQ/6cAuvT9PYGi9JlzxnlXxgOW60I/hdQb
         uuuOiPXikS11Vj5bZ1zV2HvqD+f+XSaCx+Pw3WCNcTh5ub/B9Z+CqZAnTnCqYm9AH/Yd
         wvvwkaR66lE33F1MLn7BLAMsNy+DsufZE3s8MdQ2eKrOItJBYn7Wnu4Lt47qpP8EGwKY
         j+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHTQ09ms588+UpKY9R43+BC+T+D0Aapxn3qmLnckRdI=;
        b=bTyPleEYtm2vkm3IN/mGgICkKCBRp+es50KZW2B3aqk6+V1c05InA7jKm/J72tU/Z1
         VeImIEWUGTTAAWcwqeYPVuQ7kChPMrCOsG/s2x9fmNi6rzam3JKBEB9JiGv+eKFrf2M6
         hYDRwk5bHdEPsFUZlbYE3WeP0P27nSW+fW06h8aUo87i2C85bbHr7Ag1Zadzy2R+BoBI
         ETjSLtlDJCJVGUP/0QoLA37uYRFFfzxOUpXW6VW4N5Ap9YAjrkty1rBob2wmqdh04cCi
         wRJthaVkJv9d0pJ26X7dY3PuvwMJiqisG+O+73HqwbuucTOgkDcE62+6nuniDHlg10td
         g7pQ==
X-Gm-Message-State: AOAM533MTztYcIEuqzwId3O91X0atyvsY1DONn8dcQIRk0myQysgtQ13
        bPFDfIWc/93KRI4+u969LQLXtw==
X-Google-Smtp-Source: ABdhPJzPi3Jx7MUnkqEKljskzOgWFThcO1Da5cfP8MZv//FMfGocVErt9cyG6x97pmaYOrtVcu2OwQ==
X-Received: by 2002:a17:906:1b04:: with SMTP id o4mr17902421ejg.531.1605831054650;
        Thu, 19 Nov 2020 16:10:54 -0800 (PST)
Received: from localhost.localdomain (hst-221-4.medicom.bg. [84.238.221.4])
        by smtp.gmail.com with ESMTPSA id k23sm383556edv.97.2020.11.19.16.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 16:10:54 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 2/3] venus: Limit HFI sessions to the maximum supported
Date:   Fri, 20 Nov 2020 02:10:36 +0200
Message-Id: <20201120001037.10032-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
References: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we rely on firmware to return error when we reach the maximum
supported number of sessions. But this errors are happened at reqbuf
time which is a bit later. The more reasonable way looks like is to
return the error on driver open.

To achieve that modify hfi_session_create to return error when we reach
maximum count of sessions and thus refuse open.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/hfi.c       | 19 +++++++++++++++----
 .../media/platform/qcom/venus/hfi_parser.c    |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index db0e6738281e..3a477fcdd3a8 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -96,6 +96,7 @@ struct venus_format {
 #define MAX_CAP_ENTRIES		32
 #define MAX_ALLOC_MODE_ENTRIES	16
 #define MAX_CODEC_NUM		32
+#define MAX_SESSIONS		16
 
 struct raw_formats {
 	u32 buftype;
diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 638ed5cfe05e..8420be6d3991 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -175,6 +175,7 @@ static int wait_session_msg(struct venus_inst *inst)
 int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 {
 	struct venus_core *core = inst->core;
+	int ret;
 
 	if (!ops)
 		return -EINVAL;
@@ -183,12 +184,22 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 	init_completion(&inst->done);
 	inst->ops = ops;
 
-	mutex_lock(&core->lock);
-	list_add_tail(&inst->list, &core->instances);
-	atomic_inc(&core->insts_count);
+	ret = mutex_lock_interruptible(&core->lock);
+	if (ret)
+		return ret;
+
+	ret = atomic_read(&core->insts_count);
+	if (ret + 1 > core->max_sessions_supported) {
+		ret = -EAGAIN;
+	} else {
+		atomic_inc(&core->insts_count);
+		list_add_tail(&inst->list, &core->instances);
+		ret = 0;
+	}
+
 	mutex_unlock(&core->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hfi_session_create);
 
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 363ee2a65453..52898633a8e6 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -276,6 +276,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		words_count--;
 	}
 
+	if (!core->max_sessions_supported)
+		core->max_sessions_supported = MAX_SESSIONS;
+
 	parser_fini(inst, codecs, domain);
 
 	return HFI_ERR_NONE;
-- 
2.17.1

