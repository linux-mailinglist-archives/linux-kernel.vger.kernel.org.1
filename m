Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31A26E4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIQS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:57:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27535 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgIQS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:56:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600369017; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DMvIzCf6NdTGdG0zhswNitJ30ULOFunnzOgL2Jm0pTI=; b=GDFiJTEZxhSdaqJfO3rZ9zheuwC2+Kiy6KZmNmJp3f/1yg7u7CarBi+WhYLR8fyQDUtDbTMd
 O8ZsUxBr3mxCU08BULQbSC/TKzx3eGbsy/HyY9KSbNyvrGESifGPSJsueF8veA88HTziUz7Z
 84BirLwcwODRRbKI5YWMvNHEf5w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f63b174ae7ca421d25134ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 18:56:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECFDCC43382; Thu, 17 Sep 2020 18:56:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7A2EC433F0;
        Thu, 17 Sep 2020 18:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7A2EC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v4 0/3] Move recovery/coredump configuration to sysfs
Date:   Thu, 17 Sep 2020 11:56:37 -0700
Message-Id: <1600368999-9461-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Android R onwards Google has restricted access to debugfs in user
and user-debug builds. This restricts access to most of the features
exposed through debugfs. This patch series removes the recovery/coredump
entries from debugfs and moves them to sysfs. 
'Coredump' and 'Recovery' are critical interfaces that are required
for remoteproc to work on Qualcomm Chipsets. Coredump configuration
needs to be set to "inline" in debug/test build and "disabled" in
production builds. Whereas recovery needs to be "disabled" for
debugging purposes and "enabled" on production builds.

Changelog:

v4 -> v3:
- Remove the feature flag to expose recovery/coredump

v3 -> v2:
- Remove the coredump/recovery entries from debugfs
- Expose recovery/coredump from sysfs under a feature flag

v1 -> v2:
- Correct the contact name in the sysfs documentation.
- Remove the redundant write documentation for coredump/recovery sysfs
- Add a feature flag to make this interface switch configurable.

Rishabh Bhatnagar (3):
  remoteproc: Expose remoteproc configuration through sysfs
  remoteproc: Add coredump configuration to sysfs
  remoteproc: Add recovery configuration to sysfs

 Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
 drivers/remoteproc/Kconfig                       |  12 +++
 drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
 drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
 4 files changed, 190 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

