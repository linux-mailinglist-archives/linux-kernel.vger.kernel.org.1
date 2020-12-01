Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888052C9673
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgLAEYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgLAEYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:24:22 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC39C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:23:42 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id iq13so441778pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KtanljobDOmUXNipdnFX5BfJFJkLcdabYWHbxo1jjA=;
        b=SzY19wJL0D2x41Fh8R+sqYHMgJBGOBKHS4sppWx7JTrvF0Du2hDDfhsi0NNWBG5xtI
         sj2bFpoyK1JubTZRAgm90MaIWfR2KjiLWAlNsply7cZU1mBfecueT/gAO9kk8dg0x8nQ
         ute22lLDJMXIgjXmmcNqyUvpPJxoVqMJdX338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KtanljobDOmUXNipdnFX5BfJFJkLcdabYWHbxo1jjA=;
        b=CPpYqhQi8GvviR8v3l2XM0LsmkLg++Kzu5iy8fd6BEGbcgJXKBb87xBM6V0NKyU430
         VW64iDdzAzJXe62iqgBqqHcgSag31EHeWdVd645muHPyCuam1TN684/OVTesp3M8RuSk
         5c3hqalVyupkrR299MHmgOnLYIEF8fANpbonhE+xbN1OViwHPK1DV/GWVdDlzwKg0qrE
         nnz/j7PlxdrRiOC1EeMajTkq+ppoQTwhkV9eGsI4kgToxI7KYIsKGEb5UEnZG1nJKJ6G
         90leX99gj9Suq6fnkUGUC00jPTCuBEQBY93CVVzogf1GT0I6zsTkyw/zsE4x0oj3tkPR
         FNCA==
X-Gm-Message-State: AOAM530wy+4KvCM4W3Ce+lQf7YRun2RoBuScYS5MC1tJLdILpT1N1O9i
        NoeejPCoCfeTrawLAZcKrHb5jQ==
X-Google-Smtp-Source: ABdhPJznpX+mxqPLZPrC94NDMpzCAQiGzwADnDTX6mv3+wM4bVj7+0l3tu/5OyMLIGQA7qagTW3EiQ==
X-Received: by 2002:a17:90b:8c1:: with SMTP id ds1mr855792pjb.136.1606796621809;
        Mon, 30 Nov 2020 20:23:41 -0800 (PST)
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with ESMTPSA id i4sm616920pgg.67.2020.11.30.20.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 20:23:41 -0800 (PST)
From:   Fritz Koenig <frkoenig@chromium.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanimir.varbanov@linaro.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org,
        acourbot@chromium.org
Cc:     Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH v2] venus: vdec: Handle DRC after drain
Date:   Tue,  1 Dec 2020 04:23:23 +0000
Message-Id: <20201201042322.3346817-1-frkoenig@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the DRC is near the end of the stream the client
may send a V4L2_DEC_CMD_STOP before the DRC occurs.
V4L2_DEC_CMD_STOP puts the driver into the
VENUS_DEC_STATE_DRAIN state.  DRC must be aware so
that after the DRC event the state can be restored
correctly.

Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
---

v2: remove TODO

 drivers/media/platform/qcom/venus/core.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 2b0899bf5b05f..1680c936c06fb 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -406,6 +406,7 @@ struct venus_inst {
 	unsigned int core_acquired: 1;
 	unsigned int bit_depth;
 	bool next_buf_last;
+	bool drain_active;
 };
 
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 5671cf3458a68..1d551b4d651a8 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -523,8 +523,10 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		ret = hfi_session_process_buf(inst, &fdata);
 
-		if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING)
+		if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING) {
 			inst->codec_state = VENUS_DEC_STATE_DRAIN;
+			inst->drain_active = true;
+		}
 	}
 
 unlock:
@@ -976,10 +978,14 @@ static int vdec_start_capture(struct venus_inst *inst)
 
 	inst->codec_state = VENUS_DEC_STATE_DECODING;
 
+	if (inst->drain_active)
+		inst->codec_state = VENUS_DEC_STATE_DRAIN;
+
 	inst->streamon_cap = 1;
 	inst->sequence_cap = 0;
 	inst->reconfig = false;
 	inst->next_buf_last = false;
+	inst->drain_active = false;
 
 	return 0;
 
@@ -1105,6 +1111,7 @@ static int vdec_stop_capture(struct venus_inst *inst)
 		/* fallthrough */
 	case VENUS_DEC_STATE_DRAIN:
 		inst->codec_state = VENUS_DEC_STATE_STOPPED;
+		inst->drain_active = false;
 		/* fallthrough */
 	case VENUS_DEC_STATE_SEEK:
 		vdec_cancel_dst_buffers(inst);
@@ -1304,8 +1311,10 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 
 			v4l2_event_queue_fh(&inst->fh, &ev);
 
-			if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
+			if (inst->codec_state == VENUS_DEC_STATE_DRAIN) {
+				inst->drain_active = false;
 				inst->codec_state = VENUS_DEC_STATE_STOPPED;
+			}
 		}
 
 		if (!bytesused)
@@ -1429,9 +1438,13 @@ static void vdec_event_notify(struct venus_inst *inst, u32 event,
 	case EVT_SYS_EVENT_CHANGE:
 		switch (data->event_type) {
 		case HFI_EVENT_DATA_SEQUENCE_CHANGED_SUFFICIENT_BUF_RESOURCES:
+			if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
+				inst->codec_state = VENUS_DEC_STATE_DECODING;
 			vdec_event_change(inst, data, true);
 			break;
 		case HFI_EVENT_DATA_SEQUENCE_CHANGED_INSUFFICIENT_BUF_RESOURCES:
+			if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
+				inst->codec_state = VENUS_DEC_STATE_DECODING;
 			vdec_event_change(inst, data, false);
 			break;
 		case HFI_EVENT_RELEASE_BUFFER_REFERENCE:
-- 
2.29.2.454.gaff20da3a2-goog

