Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F02D2DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgLHPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgLHPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:00:42 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 07:00:02 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so24955341ejj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hAkKwwGOdA7KlJEBTy1sTvd+If5skD+lsR9vtJWMUkM=;
        b=FZ+bGhvKxJjszDd0ZcFBXcHU/1bpV+elYmBf2Mv2lBa1S23XRI6V6wrt/SPghOUxsO
         P41USkIHiMikORPRY1yaT4oIy1AWTf4dHGKRGZhHk3RLLAqkOfBFaZOSqBkpjJgLfLmW
         LEKdAYrUk6FKfgesNNVluubOzFF0k4/N5rENouAiL8ynSqSxpiwohzfAgD49gbjhhEwf
         yHNz/f2vtZf7mqDmeX/VproYVdVAnI9NP72mfuiOBKKXRI/nggw4pjyK+ejTUD0UJShg
         hF0TXsUEYvmsPrVjW/iJt3JcTdWFjpRb5kfCsQmoN1C5z0TyiHs5UgGBEU5yHtzcXBRd
         DlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hAkKwwGOdA7KlJEBTy1sTvd+If5skD+lsR9vtJWMUkM=;
        b=U7Fu1E4WaBgyyKJvczQA+tXj80X691leI4PDWKM+owHGmP4Az2MZ3jSoRZFEhKLgCa
         J/xKdjTBIYTW1yb/vsb3V0wgYc7EzpVsEz0o7C3NfxgqbRPcnVdFe7tevm97Gbk2ymyz
         OvbkDhqRVxIg1V8lJxeKoEt9D6mV9Q7ANAiqtMlbayTp3XpSIOLG5A2/X/1LUUIxK7Q0
         GRAE0frRG2imSMx2OhOI7g9Jp8b/qpUmRaxmXSNClnY+PYTRGcLtdYuph/R26g1Bm7+v
         ZEQrowdvOJmO1th9/fahgXnk31+ntYaOjoSmjvnHxxAG0era58q1HWAM13OY+Kq1sCDf
         EWTQ==
X-Gm-Message-State: AOAM530PXAI2B800gPwIvF+yeUND80X2xqkYOVmfrlbaCfpDGNGd6kht
        tXpM//Nxa1gB7fjXl8zxJ589/g==
X-Google-Smtp-Source: ABdhPJxL5zm2AhNskIj3IdbTnu2W+pBXrJxj+BWu8LHYP43XmANx+npvzuQ+c95Q73bsm1XwwC8yKg==
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr23365749ejb.546.1607439600943;
        Tue, 08 Dec 2020 07:00:00 -0800 (PST)
Received: from localhost.localdomain (hst-221-90.medicom.bg. [84.238.221.90])
        by smtp.gmail.com with ESMTPSA id qn4sm4968292ejb.50.2020.12.08.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 07:00:00 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 0/3] HDR10 static metadata
Date:   Tue,  8 Dec 2020 16:59:28 +0200
Message-Id: <20201208145931.6187-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since v2:
 * fixed typos
 * introduce new colorimetry class
 * kept the parameter validation (even though Hans suggested to drop it)
 * rename to max/min_display_mastering_luminance

The previous patchset version can be found at [1]. 

regards,
Stan

[1] https://lore.kernel.org/linux-media/20201123230257.31690-1-stanimir.varbanov@linaro.org/T/#mba512702aab370d4b0aa393dea54095e55d78552

Stanimir Varbanov (3):
  v4l: Add HDR10 static metadata controls
  docs: media: Document CLL and Mastering display
  venus: venc: Add support for CLL and Mastering display controls

 .../userspace-api/media/v4l/common.rst        |  1 +
 .../media/v4l/ext-ctrls-colorimetry.rst       | 88 +++++++++++++++++++
 .../media/videodev2.h.rst.exceptions          |  2 +
 drivers/media/platform/qcom/venus/core.h      |  3 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  |  8 ++
 .../media/platform/qcom/venus/hfi_helper.h    | 20 +++++
 drivers/media/platform/qcom/venus/venc.c      | 29 ++++++
 .../media/platform/qcom/venus/venc_ctrls.c    | 16 +++-
 drivers/media/v4l2-core/v4l2-ctrls.c          | 68 ++++++++++++++
 include/media/v4l2-ctrls.h                    |  4 +
 include/uapi/linux/v4l2-controls.h            | 35 ++++++++
 include/uapi/linux/videodev2.h                |  2 +
 12 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst

-- 
2.17.1

