Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB05270328
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIRRXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:23:08 -0400
Received: from so254-54.mailgun.net ([198.61.254.54]:61532 "EHLO
        so254-54.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgIRRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:23:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600449787; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AiQ59+FN+VsaIY7kf+vi02m9Rno/NPAzef2bQvLr7hM=; b=oQWbt01tLCuci1+28BMhAMjyarIjSUmrCD/BUOialEaRDopfwWrN4Zepm+ejUfuelf1/fZQ2
 cDRqv8NV5Mk2zOqoa/ndniAaxyuUDYOfOp5dVRuuj2hHIH+zscJMKIk3sdNfwa9VE0EWWUY+
 S+61YJzYrqJ86ygmLRcQCSgV6aA=
X-Mailgun-Sending-Ip: 198.61.254.54
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f64eccc36c8ce93e8d94efa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 17:22:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2C63C43382; Fri, 18 Sep 2020 17:22:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3EEAC433C8;
        Fri, 18 Sep 2020 17:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3EEAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v5 0/2] Move recovery/coredump configuration to sysfs
Date:   Fri, 18 Sep 2020 10:22:09 -0700
Message-Id: <1600449731-3056-1-git-send-email-rishabhb@codeaurora.org>
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

v5 -> v4:
- Fix the cover-letter of tha patch series.

v4 -> v3:
- Remove the feature flag to expose recovery/coredump

v3 -> v2:
- Remove the coredump/recovery entries from debugfs
- Expose recovery/coredump from sysfs under a feature flag

v1 -> v2:
- Correct the contact name in the sysfs documentation.
- Remove the redundant write documentation for coredump/recovery sysfs
- Add a feature flag to make this interface switch configurable.

Rishabh Bhatnagar (2):
  remoteproc: Move coredump configuration to sysfs
  remoteproc: Move recovery configuration to sysfs

 Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++
 drivers/remoteproc/remoteproc_debugfs.c          | 168 -----------------------
 drivers/remoteproc/remoteproc_sysfs.c            | 120 ++++++++++++++++
 3 files changed, 164 insertions(+), 168 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

