Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1192AF8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKKTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:21:35 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:33184 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbgKKTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:21:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605122483; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=57kvVF2ThDFDHaXRqrUE7yn622CwYm6PBAuR+h72F0Q=; b=cfON35yjfpzh3RqUydwTZvLY9YMpnLouOp7cyKsx8PPwxSi+KpTxsGbNVQ3NtzmWZShqwrr+
 R7yygMs0SUx4fbup53bgUIVqbPLYz19gjBRuaWNu/0xWNkL7z3QofPDe0hgz0/+Rm0rqMNhb
 HnH8Vl8KqK5YykTE4aHcggr0Og0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fac39b0b8c6a84a5c9130f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 19:21:20
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C21DFC433FE; Wed, 11 Nov 2020 19:21:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4825C433C6;
        Wed, 11 Nov 2020 19:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4825C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 0/6] Updates to MHI channel handling
Date:   Wed, 11 Nov 2020 11:21:07 -0800
Message-Id: <1605122473-12179-1-git-send-email-bbhatt@codeaurora.org>
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

v2:
-Renamed the newly introduced APIs to mhi_start_transfer() / mhi_stop_transfer()
-Added improved documentation to avoid confusion with the new APIs
-Removed the __ prefix from mhi_unprepare_channel() API for consistency.

Bhaumik Bhatt (6):
  bus: mhi: core: Allow receiving a STOP channel command response
  bus: mhi: core: Improvements to the channel handling state machine
  bus: mhi: core: Add support to stop or start channel data transfers
  bus: mhi: core: Check execution environment for channel before issuing
    reset
  bus: mhi: core: Remove __ prefix for MHI channel unprepare function
  bus: mhi: Improve documentation on channel transfer setup APIs

 drivers/bus/mhi/core/init.c     |  11 +-
 drivers/bus/mhi/core/internal.h |  12 +++
 drivers/bus/mhi/core/main.c     | 226 ++++++++++++++++++++++++++++------------
 include/linux/mhi.h             |  37 ++++++-
 4 files changed, 215 insertions(+), 71 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

