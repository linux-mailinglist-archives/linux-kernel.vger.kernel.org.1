Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23291251DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHYRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHYRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:01:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so3227717wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpKO1n0QanBgjBcMclGlpuxhhM/1GVFlZi03A2YqmvY=;
        b=M+RkbNAFYMBm5BznXBwWgdcU8fHg3/Plxeo7geh65W6uhfjeWskcp1RMI0yxk6ANgp
         lTWk7LNPF8ElsHi2hCy+w/nyedqZxLdq1usGzYOtKvq9yBs9AfGtnxAqs/YF/yVOO74S
         A2WeolrcChlt6ckXcvUDGkF5xuWZPKpcWFNkiwnFVoEd3LUyFs9nuZS2HdgVYsKGnMcG
         7zej4HWNccEQw0C8UWiH76pTZhB1ioRXPCHJcczW2TmdNAYFuTf04VH+7EFFZ0D5vKSQ
         /hna1rSAi1Dqxj1P7ocxPHqaYBxko4jimqNRV+suoPuyqBaenyEIc/NyxwxuLg/uWvTU
         Y72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpKO1n0QanBgjBcMclGlpuxhhM/1GVFlZi03A2YqmvY=;
        b=HLUmY62TyYi93J8nIZZLnrUwFY5W7REIxyL2pPJ1q95cBsF+Bu8Eg8jfsMAO+qgKmY
         KiDKGY7OxBUSFlohAeDllpJm6kZSWj/uHbmtFB2g9qaWjuvAi4Ln4TYz6W82wUl/TfXb
         l+hfQGk/CNsQlmCYbWFWI/FJrNzf9ghJO5v8RQgl31sZuY9R+5dCk3ZXOaLkeRIh70hQ
         zO3mfkEB30+TpBqBvhHGfZd+sw4lEHpScT0uKGm587LjFrLOthahFpOEqo4BagCOs9oc
         AYAAlFCizHp8CXZZcDkf1EhO7mVB+49QGlhzI1Q8Wf8iWD7m9L8ej13z7R5S4xk3Su/w
         5pTw==
X-Gm-Message-State: AOAM530+v2w6eywouCKLSkBPmnQUhs65mjoWDH8PaVNclYrqkkyH3MsM
        3+tXZWwbl3FHIY2NZ8WVhSXkfg==
X-Google-Smtp-Source: ABdhPJzgcQ9N/3zFlxhqBdnwDCEAiD1zyiBMaMhORxfxzm5UhZrj6CQJOQMsYYBg/61mRxEadCr6rA==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr2821188wmt.94.1598374913846;
        Tue, 25 Aug 2020 10:01:53 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:53 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add interconnect sync state support
Date:   Tue, 25 Aug 2020 20:01:49 +0300
Message-Id: <20200825170152.6434-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bootloaders often leave some system resources enabled such as clocks,
regulators, interconnects etc. We want to keep these resources enabled
until all their consumers are probed. These resources are often shared,
so we must wait for all the consumers to come up, before deciding
whether to turn them off or change the configuration. This patchset is
trying to solve the above problem just for the on-chip interconnects.

The problem is solved by allowing the providers to implement the get_bw()
function which should return the current average/peak bandwidth. These are
used as floor values, that are enforced during boot while the requests from
all consumers are being collected. Then the sync_state() callback is used
to signal that all consumers have been probed, meaning that the floor
bandwidth is not needed anymore and the framework is ready to re-aggregate
and process all requests. If get_bw() is not implemented, the framework
will use INT_MAX as default bandwidth value.

v3:
* Go back to introducing the get_bw() function as in v1. (Saravana)
* If querying the current bandwidth is not supported, max out the
  bandwidth. (Saravana)
* Use icc_sync_state also for sc7180.

v2: https://lore.kernel.org/r/20200722110139.24778-1-georgi.djakov@linaro.org/
* Support initial values for both average and peak bandwidth (Mike)
* Skip aggregating/setting for nodes that don't specify initial bw (Mike)
* Drop patch 2/4: Add get_bw() callback (Mike)
* Squash patches 3 and 4.

v1: https://lore.kernel.org/lkml/20200709110705.30359-1-georgi.djakov@linaro.org/

Georgi Djakov (3):
  interconnect: Add get_bw() callback
  interconnect: Add sync state support
  interconnect: qcom: Use icc_sync_state

 drivers/interconnect/core.c           | 67 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c    |  1 +
 drivers/interconnect/qcom/sc7180.c    |  1 +
 drivers/interconnect/qcom/sdm845.c    |  1 +
 include/linux/interconnect-provider.h |  7 +++
 5 files changed, 77 insertions(+)

