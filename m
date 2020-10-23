Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1A296FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464181AbgJWM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464126AbgJWM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:57:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:57:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v5so1356494wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6MrggB0Obs1H04N41aSmGHcG+3VEtp3I3jrGd1sX7s=;
        b=WDPqCpqYtdLl5HzEhfzTRo048t+1HiWYtcoArblp2lCFQ8qTX+N12yUTonYt0fQ/08
         rlPwUTh9AFEXdOybZ0j4ccVA3VZJGpH6MW/3Lr3YTmAsRCqN/l+xayh9wj/+FkYd1S2G
         pgn1gvtA8A8zF/iRxFjGeUf9QZOBubeSNiiY4jLt/eovO9lw4dkmnsWqcbaifDyvJwjK
         JrS4A5FU+L+657HVqdf/nE1DmTXvIFKy/4HhUgk39wNM39LH/tWUiWQTIk7QvqUvjr18
         nrrvN1mfFwhQyTi9xE8wimHfsCwJvhwpL2VVguH0MmFLM34Y+a/LkibITahVWNMcvau1
         CHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6MrggB0Obs1H04N41aSmGHcG+3VEtp3I3jrGd1sX7s=;
        b=VXPl2OMuNjGxJ6p48+WZSeF7wKfBNjzQ7UZscPuIwwJIu3Dp/aE31mzLt7B9qn3kiU
         kc0rXJ60HnmcMeQM8hvwXitiqt8G87q3LY3+F3jzB4MhOntKH7HsehROU5qvij2U/Bqd
         nPaFU1TdYzKm2gGY5zKI+hJ4oZiIEzVMfdpm/uAEXO9LOA+bdzbj2gs0AvhTtShLfTTL
         5rsSyXnSJ0mwpc4UZIlzx833BkKWsJC7a+GmH+a6hxbyqFMU/2AZB9q5+o1ZGNGD2/sp
         8IRCQVf86akn0Y/zEYduAXldJ2kr2DFyFU1ogsGhOwxuFyde8Puxcukr5u5QS3dw6sFg
         4XDA==
X-Gm-Message-State: AOAM533AVRiHlNehujOKy/wbTvBmH6n6synsUntZKF+QLyRa0DIj85gH
        KovF/5w18nSluVzut6nJU5/Icw==
X-Google-Smtp-Source: ABdhPJzIX1wH2yyINNscu6kMfYr8TjsWeoOPLFENzOLAo1bgjsKLNPdEgtdPDNcPqjpYaKS3hbQIUQ==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr2316469wmb.129.1603457839699;
        Fri, 23 Oct 2020 05:57:19 -0700 (PDT)
Received: from localhost.localdomain (hst-221-77.medicom.bg. [84.238.221.77])
        by smtp.gmail.com with ESMTPSA id s19sm3475873wmc.0.2020.10.23.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:57:19 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/4] Venus stateful encoder compliance
Date:   Fri, 23 Oct 2020 15:57:00 +0300
Message-Id: <20201023125704.4984-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Тhis patchset is an attempt to make Venus encoder driver compliant with
stateful encoder spec. There are still few details which need to be
cleaned up so this can be treated as WIP. For example the usage of m2m
helpers to update the states and handing of the LAST capture buffer for
Drain state. Here mainly I re-designed the driver to able to handle
capture/output queues independently and properly go in and out of Reset
state.

These patches depend on [1].  

Comments are welcome!

regards,
Stan

[1] https://lkml.org/lkml/2020/10/19/432

Stanimir Varbanov (4):
  venus: hfi: Use correct state in unload resources
  venus: helpers: Add a new helper for buffer processing
  venus: venc: Handle reset encoder state
  venus: helpers: Delete unused stop streaming helper

 drivers/media/platform/qcom/venus/core.h    |  10 +-
 drivers/media/platform/qcom/venus/helpers.c |  63 ++---
 drivers/media/platform/qcom/venus/helpers.h |   2 +-
 drivers/media/platform/qcom/venus/hfi.c     |   2 +-
 drivers/media/platform/qcom/venus/hfi.h     |   1 -
 drivers/media/platform/qcom/venus/venc.c    | 242 ++++++++++++++++----
 6 files changed, 219 insertions(+), 101 deletions(-)

-- 
2.17.1

