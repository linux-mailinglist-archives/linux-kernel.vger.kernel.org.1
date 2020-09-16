Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13626C4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgIPP4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIPPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5AC02C2AD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o5so7347994wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/O4Z+E6Lm40GO/xNzCmRRf/TExfeeNhj/Pi79dfsiM=;
        b=cgKuJgB5a5Kfj4NMjhkMYKWh3kJysaDVQb3CeziIplZO8Lz5UAI3nxgaWnQCYRB0Xq
         NLFBQ4sxj13YSgWhcSHhtmbFoX07/B9N+b/LQqv7aF7MN25ySr+cSsgoWWmkzF7EMhhP
         Y8b8Df/ylshwEpAiNJgYv60/xL4mm7qTY8BSYTohmlCva8P3G9GQn8kIM0OX13h2UnAY
         2EU6uh5Do8dOhIPMd/rnLvSFMM57C4BGdMi4jfApv4NHpZhjWOENes6erFYpU+rcEZhj
         9gBhMQUpBihm9tPMe5GzxWoQkV581r2UojfJHM2orTKG7UUkv6BdCuJSbnHEcySY6ici
         Dzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/O4Z+E6Lm40GO/xNzCmRRf/TExfeeNhj/Pi79dfsiM=;
        b=l7uyuo2Rp1Z0KouSGHzvVijdnw5/9KaSaBIC+fSDFDci4pqudu/Sx1jw8Unwkl1rV2
         DFiZ6fmPS3i0wTOdaHV2IXD1w/ZDtlfXxuacYSMCHqHUF2b1NwUqvlh+V2x/VeKIu2aQ
         0TkNOJe8VG3iSqwwoWJlG7FvxuGnFLv64kQLGJQpMOPvx3v6rOvIS0H3YGLbXMWFXtZC
         pLqKreyusM57QnFVlgX9WI37wRMSjOt7EarSuNI5q5Mo33bKnrV3wnchxDondB+kZcZJ
         mGBWddxJQ7qSgrVUKg9bGq+r7FjFPAuQPenQseG5gLOGggMigU0YgSzkg0adJIDexAtv
         pDTw==
X-Gm-Message-State: AOAM532NKnf08pzc/EGh3TsPblW2ikoGqT2kcjSK6MKA8BmPwOEV0364
        oSiukNtja7ITaENZRiVEojXNXw==
X-Google-Smtp-Source: ABdhPJzFZVfyPEZx2r/fXGi8f+A9dvy8v/OxozCYuNKctqtMpJWG323EYpq2cg0o0ERzS8YpHoDa0A==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr28296845wrp.338.1600270867726;
        Wed, 16 Sep 2020 08:41:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:41:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] soundwire: qcom: fix IP version v1.5.1 support
Date:   Wed, 16 Sep 2020 16:40:58 +0100
Message-Id: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing Qualcomm soundwire controller version 1.5.1, found two issue,
Firstly the frame shape information configured vs the bus parameters
are out of sync. secondly some ports on this ip version require
block packing mode support.

With this patchset I was able to test 2 WSA speakers!

Also I found a regression due to move to REG_FIELD, which patch 1 fixes it!

thanks,
srini

Changes since v2:
- updated to use u32_replace_bits().
- wrapped up in single lines as suggested by vkoul.

Srinivas Kandagatla (3):
  soundwire: qcom: clear BIT FIELDs before value set.
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 70 +++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

-- 
2.21.0

