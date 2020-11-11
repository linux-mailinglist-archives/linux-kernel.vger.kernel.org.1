Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130A2AF3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKKOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKKOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:38:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:38:20 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so2541570wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HCKQOzFPpo+2K5yUahYtUtI8k6qp0+z3GG+IuN0ZApo=;
        b=Gke4ieISLM/XI8kVcqy+0mz4yf0ilnZLu5L14Ham+FjQ7rwpzqo52LbuyxGEB+6d5B
         UDpnhBJ0KU/otCehHd8K7SCm6O/Ehnx9Hkk40ZKbouSOo4fle/NTsagkA8DlNP+01pd0
         DnnJeE2a6YL9Jqu4qUhdAsMV06K3YYxn62/6V1uj6cQhRTBMy4s4Nrp9ms/W0j3wtPoK
         r1rvv/ufdxrricb97N372OISa6T7tESS73k60FsZ/gfyGYLabadPIscSnwADP2leufuT
         fDhlTwPBMSlUzbMYLrc84v1CgetJfn7FUqRzDfloDuPeEyxlirDHoY7dPoS8TfX8Zail
         FEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCKQOzFPpo+2K5yUahYtUtI8k6qp0+z3GG+IuN0ZApo=;
        b=pHNWZkBgb3fmd1aJ/HBPmqDTaxyooZSv7dckpv4R7Tkf31DV8TaP382NY2+c8ynSh7
         vKfGcTD7XNBg1FeMUgiAXsWVg/e/R9kfHRLMk4/lrBKKLRuB9iKHXzDr7PYOKpoamVq8
         e02F/L+tVQmGMhkbNLtg039ZlnsC5qCnu2fo0ZAIY104/tKMEaAGGlPn6Io8IruOnEYN
         bn5lzuR36c6MEYr8g7pKPltbk1oSPMZtbNI75xT/ve6G8C1Om1zS9AnBt5pRpyC/+YH/
         qpwgBtxdSm+4dLI/xRbpwftq80j81brpQY+JjOU8wsp+rldOX/Jsy3qLH/XE5VrOMXGf
         0dYQ==
X-Gm-Message-State: AOAM532oZFtG5w7mQ0nb4NfLJpG6SbszeglqMXTmcoi3Oft6QbDVtuFS
        TF0TX6aVS2jfZr6+Qa1sYiWXRg==
X-Google-Smtp-Source: ABdhPJzvkbMLLwR+nG6rjNxa+zEvikOX1rvi36jAIKrhuJYZt9qibdSW2YAQkwYi11nK78hOMR2Fvw==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr4429807wme.22.1605105499188;
        Wed, 11 Nov 2020 06:38:19 -0800 (PST)
Received: from localhost.localdomain (hst-221-89.medicom.bg. [84.238.221.89])
        by smtp.gmail.com with ESMTPSA id b8sm2991405wrv.57.2020.11.11.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 06:38:18 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/8] Venus stateful encoder compliance
Date:   Wed, 11 Nov 2020 16:37:47 +0200
Message-Id: <20201111143755.24541-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 of the subject patchset. 

The patchset starts with few small preparation and fix patches, 1/8 to 5/8.
6/8 is redesigned Dikshita's patch and 7/8 add Reset encoder state handling.
The last 8/8 just delete not needed helper function.

The major changes are:
 * An attempt to reuse m2m helpers for drain and reset state in 6/8 and 7/8.
 * Use null encoder buffer to signal end-of-stream in 6/8.

Comments are welcome!

regards,
Stan

Dikshita Agarwal (1):
  venus: venc: add handling for VIDIOC_ENCODER_CMD

Stanimir Varbanov (7):
  venus: hfi: Use correct state in unload resources
  venus: helpers: Add a new helper for buffer processing
  venus: hfi_cmds: Allow null buffer address on encoder input
  venus: helpers: Calculate properly compressed buffer size
  venus: pm_helpers: Check instance state when calculate instance
    frequency
  venus: venc: Handle reset encoder state
  venus: helpers: Delete unused stop streaming helper

 drivers/media/platform/qcom/venus/helpers.c   |  65 ++---
 drivers/media/platform/qcom/venus/helpers.h   |   2 +-
 drivers/media/platform/qcom/venus/hfi.c       |   2 +-
 drivers/media/platform/qcom/venus/hfi.h       |   1 -
 drivers/media/platform/qcom/venus/hfi_cmds.c  |   2 +-
 .../media/platform/qcom/venus/pm_helpers.c    |   3 +
 drivers/media/platform/qcom/venus/venc.c      | 232 +++++++++++++++---
 7 files changed, 226 insertions(+), 81 deletions(-)

-- 
2.17.1

