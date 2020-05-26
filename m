Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979FF1E19D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbgEZDWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 23:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbgEZDWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:22:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3214C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so9264653qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irxvBr3fhjh3o4PcQX5WrXrjZ+soB6XClWrdckT/PEg=;
        b=wmMfYz4Q49KJhfEacTGOCEZGd7yE3D0nE8Xn5qM/BcmKBnqiZ6B7luz3x8cSBRfwTC
         3/UZNtYoswmTXLHvaHCPwGjCMMI/nfBNbClpHanLQhJ6coFId0GsNjsICZAyGj6Ca7hY
         0aQ9bcBvpbtTHKFmKmHY6lkFfbQT8C+DVZNLH7skIdJysABoMm84FnF6WUs+yYJjlBF6
         5OoMApXdGII3qUGOhb6uIvuiifELzRRIun4gCUSA5CqkgUu2yiRCnb6dkPc2f6U7ZiyR
         T3W7w3AdU5w406o6jibD13vYtURGesBheFcXiu9WWa7YzsAB8hEJ8ZlswFmN9E2eUJe7
         nDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irxvBr3fhjh3o4PcQX5WrXrjZ+soB6XClWrdckT/PEg=;
        b=Wafw+J+6rC42gb885ru7kyLMyVUlz1/Dpb0w+x169vwhqhU+6lr5agHNCEGd26jI77
         TnDTjAisjOegraAwMvP6GgdYel66jwC+GHSitC0OBZ+UqyfUPjpjVmXAWwwS7Dha3dmi
         mylnZJrE3D7BVvVU+dfBz+dMvZ45T5t2GXD/HRso+w+9ahjq+3P0CzFkxU+2Xqd5iooA
         F6mYliBUar0VOYP2m5OQaYwfaXWr5GuSScxX4oRiWtmic49N7y31VTFPIJDMeSq7H33H
         j9oQxN9I04TkfaXDwcbrct6biwV42UNdaxc/H/1jzHyMdb9S7E7UuKpU7ISbfe3VjO8a
         o4PQ==
X-Gm-Message-State: AOAM533/TVMADsRfQ5nuGPWOoLe4lVOfFu+05tgzQFmsQdPo4NDTZFdQ
        Qfc6CNzTUQZjsEMoM8sO/oPR6g==
X-Google-Smtp-Source: ABdhPJwcJbeZ44TzgeR1njybd+DRRmfS48J8wtcs0R4IFp7dHY9QeqGiP5i6eANoJ24H0JQXZ7BQZg==
X-Received: by 2002:a37:db11:: with SMTP id e17mr28833862qki.336.1590463360740;
        Mon, 25 May 2020 20:22:40 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k20sm2530796qtu.16.2020.05.25.20.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:22:40 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Brian Masney <masneyb@onstation.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jayant Shekhar <jshekhar@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Raviteja Tamatam <travitej@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 0/8] Initial SM8150 and SM8250 DPU bringup
Date:   Mon, 25 May 2020 23:22:07 -0400
Message-Id: <20200526032235.21930-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches bring up SM8150 and SM8250 with basic functionality.

Tested with displayport output (single mixer, video mode case).

I will send patches later to add support for merge3d and dual DSI
configurations, and possibly also patches to fix command mode on
these SoCs (note it is also currently broken for SC7180).

Jonathan Marek (8):
  drm/msm/dpu: use right setup_blend_config for sm8150 and sm8250
  drm/msm/dpu: update UBWC config for sm8150 and sm8250
  drm/msm/dpu: move some sspp caps to dpu_caps
  drm/msm/dpu: don't use INTF_INPUT_CTRL feature on sdm845
  drm/msm/dpu: set missing flush bits for INTF_2 and INTF_3
  drm/msm/dpu: intf timing path for displayport
  drm/msm/dpu: add SM8150 to hw catalog
  drm/msm/dpu: add SM8250 to hw catalog

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   6 -
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 287 +++++++++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  48 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c    |  20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |  29 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c     |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |  16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    |  18 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h    |   7 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c      |  75 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |   6 +-
 12 files changed, 363 insertions(+), 156 deletions(-)

-- 
2.26.1

