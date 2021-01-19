Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9662FB85F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbhASMYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392614AbhASMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:17:32 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2841C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g12so28187424ejf.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmKZ1MO1cX5zg3/v5PkyOvJvBq0WKc/gh9CZTFuOugE=;
        b=hZzooO9PsSn1Aw+KSBh0wb8S8fs60fHhKRHYUVDASQ8wmxJn8781mCzNdP4NULkxfC
         cQNYecvaSdxpiacDL//Ujz6Fkwp9sU+uyA/N6YmNaOlxEJoU5DBqFY1jWXJFriLl0cCa
         PARo/eEdCNzMJu5I5etYx3CyC43lmmdHw6Lw60w9TOKAdmXJyXct6EUHcr2V5vBC365B
         6grF17TwK5G8yPvf7jEkP+cG/ytoWSad49S2r7w4KlUIklgzu8VMr2b9AwHSMFm7s/D/
         wKMneXCQ9LIHOx74/kYsQYdkKLt1GUALwKtUJV2eP65tO7qxAaBjIx/4kpS6dZQEhZNS
         IX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmKZ1MO1cX5zg3/v5PkyOvJvBq0WKc/gh9CZTFuOugE=;
        b=ul5kh6S8IC54SdNH4YUfc0sJDXEBEuL3PSCckQuTOKXcdwmWGjXhkuVvfhQxma3fvI
         5SSpI8fEnZCaLA0IiZMBYOhiuSwfJGT3XJBmrQ3fOHpm1bM7p0E3TN16GFzc+jXDn8wm
         d4/2XfwJZZX+1GMVm+kjTRlTdxXv9vUs/7sb1QUPGljyEGKr4Unkr37rrRzCGmuXQTkc
         q/Er6LwtS3FUiG6cL9mJzOe+BtNSUdHigdZgusQ/muKijHjwn3a65RdgH7kqYqua5ADj
         rVZ4urt6JUujTFdj9W0awZQeR2dgWxYWpJzk35R6taJne62xz26zN2ArvG40LeDwa2yL
         bXaw==
X-Gm-Message-State: AOAM532iwqOk14qWgmGStuSb9KrEbdUr8Tfx2uWHiLhB95RWeNsCko7C
        649Mv+oDLA/wn/j8pSnCgUCpsA==
X-Google-Smtp-Source: ABdhPJx2wFjuRdWe0WtjmTN0GBT3Q1NJklASkcSxTYydv9xWzId0/aVfW5d1qrA0qMdjqawpTS4p4A==
X-Received: by 2002:a17:906:70d4:: with SMTP id g20mr2895018ejk.361.1611058609381;
        Tue, 19 Jan 2021 04:16:49 -0800 (PST)
Received: from localhost.localdomain (hst-221-116.medicom.bg. [84.238.221.116])
        by smtp.gmail.com with ESMTPSA id hb19sm180819ejc.16.2021.01.19.04.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:16:48 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 0/2] AUD encoder control
Date:   Tue, 19 Jan 2021 14:16:23 +0200
Message-Id: <20210119121625.2397824-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patchset adds new AUD encoder v4l2 control and the relevant
support in Venus driver. The previous v2 was part of [1] series
but now it is detached.

Changes since v2:
 * rebased on top of media_tree master branch.

regards,
Stan

[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=4083

Stanimir Varbanov (2):
  media: v4l2-ctrls: Add control for AUD generation
  venus: venc: Add support for AUD NALU control

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |  5 +++++
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/venc.c           | 14 ++++++++++++++
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  8 +++++++-
 drivers/media/v4l2-core/v4l2-ctrls.c               |  2 ++
 include/uapi/linux/v4l2-controls.h                 |  1 +
 6 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.25.1

