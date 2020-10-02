Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22804281A98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbgJBSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:09:33 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:40609 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbgJBSJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:09:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601662172; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=od5LaKRmM42JWD19DdHvMTEP5SzyF0vvOZwnJgv40vI=; b=WyH9D0l0J9loxSc7uwdt1POOTujHiUsTNuuo5g2RCPhUxXxxFYvF5drfLiNuF6rP0tUKAcIS
 MEbVq5BMLN0LA1Ws6zcl88+3Klxfwkq5v/byev1E5gpmcI5qzS31olQnI77NNtJcZxlEx6Xt
 ETGD0/VtCGU96QFgtA1harwt8wM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f776cd9f9168450eaa7a953 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 18:09:29
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58579C433FF; Fri,  2 Oct 2020 18:09:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78C8DC433C8;
        Fri,  2 Oct 2020 18:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78C8DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v7 0/3] Move recovery/coredump configuration to sysfs
Date:   Fri,  2 Oct 2020 11:09:01 -0700
Message-Id: <1601662144-5964-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Android R onwards Google has restricted access to debugfs in user
and user-debug builds. This restricts access to most of the features
exposed through debugfs. 'Coredump' and 'Recovery' are critical
interfaces that are required for remoteproc to work on Qualcomm Chipsets.
This patch series adds recovery/coredump configuration to sysfs interface
and disables coredump collection by default. Having coredump disabled by
default on production devices makes sense.

Changelog:

v7 -> v6:
- Keep the debugfs entries intact for now.
- Reorder the patches to have a consistent sysfs interface.

v6 -> v5:
- Disable coredump collection by default
- Rename the "default" configuration to "enabled" to avoid confusion

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

Rishabh Bhatnagar (3):
  remoteproc: Change default dump configuration to "disabled"
  remoteproc: Add coredump as part of sysfs interface
  remoteproc: Add recovery configuration to the sysfs interface

 Documentation/ABI/testing/sysfs-class-remoteproc |  44 +++++++++
 drivers/remoteproc/remoteproc_coredump.c         |   6 +-
 drivers/remoteproc/remoteproc_debugfs.c          |  23 +++--
 drivers/remoteproc/remoteproc_sysfs.c            | 119 +++++++++++++++++++++++
 include/linux/remoteproc.h                       |   8 +-
 5 files changed, 181 insertions(+), 19 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

