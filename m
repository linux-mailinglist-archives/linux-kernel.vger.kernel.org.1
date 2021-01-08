Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC222EF9B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbhAHU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:56:37 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:17152 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbhAHUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:55:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610139336; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=X2w150Vpf9IlkyYn7sgO3StsBElUXz/GmcFMCSpVlRc=; b=ef4u7fSSZZ/bRe067b8NSUEd0RiP/cCYcdn8cQQxPpneJATzdyBEraDimkXS7rorNINygoAN
 ORMfiEi2DSKsJW1WVVRLAop0J3Xo9femIeJhrnZ8f+mSIXCUwKwvTawWfHO0MAOC5GcIgwqA
 UL5axEdIxK2kpiv1Qk5oLhADIn4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ff8c6a9d84bad35476d8583 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 20:55:05
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9421C43463; Fri,  8 Jan 2021 20:55:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C27BEC433CA;
        Fri,  8 Jan 2021 20:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C27BEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 0/9] Updates to MHI channel handling
Date:   Fri,  8 Jan 2021 12:54:48 -0800
Message-Id: <1610139297-36435-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI specification shows a state machine with support for STOP channel command
and the validity of certain state transitions. MHI host currently does not
provide any mechanism to stop a channel and restart it without resetting it.
There are also times when the device moves on to a different execution
environment while client drivers on the host are unaware of it and still
attempt to reset the channels facing unnecessary timeouts.

This series addresses the above areas to provide support for stopping an MHI
channel, resuming it back, improved documentation and improving upon channel
state machine handling in general.

This set of patches was tested on arm64 architecture.

v5:
-Added reviewed-by tags from Hemant I missed earlier
-Added patch to prevent kernel warnings on clearing channel context twice

v4:
-Updated commit text/descriptions and addressed checkpatch checks
-Added context validity check before starting/stopping channels from new API
-Added patch to clear channel context configuration after reset/unprepare

v3:
-Updated documentation for channel transfer APIs to highlight differences
-Create separate patch for "allowing channel to be disabled from stopped state"

v2:
-Renamed the newly introduced APIs to mhi_start_transfer() / mhi_stop_transfer()
-Added improved documentation to avoid confusion with the new APIs
-Removed the __ prefix from mhi_unprepare_channel() API for consistency.

Bhaumik Bhatt (9):
  bus: mhi: core: Allow sending the STOP channel command
  bus: mhi: core: Allow channel to be disabled from stopped state
  bus: mhi: core: Improvements to the channel handling state machine
  bus: mhi: core: Clear configuration from channel context during reset
  bus: mhi: core: Add support to stop or start channel data transfers
  bus: mhi: core: Check channel execution environment before issuing
    reset
  bus: mhi: core: Remove __ prefix for MHI channel unprepare function
  bus: mhi: Improve documentation on channel transfer setup APIs
  bus: mhi: core: Do not clear channel context more than once

 drivers/bus/mhi/core/init.c     |  23 +++-
 drivers/bus/mhi/core/internal.h |  12 ++
 drivers/bus/mhi/core/main.c     | 238 ++++++++++++++++++++++++++++------------
 include/linux/mhi.h             |  45 +++++++-
 4 files changed, 243 insertions(+), 75 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

