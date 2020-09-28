Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE627B788
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgI1XNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:13:07 -0400
Received: from z5.mailgun.us ([104.130.96.5]:61065 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgI1XNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601334786; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8CJA6J29Cn+bufk0vCjsxrbKFbanr4AB9WIlRG9X7Uc=; b=K7lfzv2h9zYCQBss5doSaRdpNGiS6gqK6k2lVkMecYeUU0IiiHy9whpbCegtgMfWQfWFEjvZ
 Ljtz7Wk73++w+hIdi4TuuUMA7vNH+gsvMKX4aEQC4qNcbE0ZI4xhbukyAukf9VsosMdVFsFR
 s6BXJgWdTihfxgquviUnUbpi9rw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f7261102892e2043e87aafb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 22:17:52
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25BADC433CB; Mon, 28 Sep 2020 22:17:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28728C433CB;
        Mon, 28 Sep 2020 22:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28728C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v6 0/3] Move recovery/coredump configuration to sysfs
Date:   Mon, 28 Sep 2020 15:17:33 -0700
Message-Id: <1601331456-20432-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Android R onwards Google has restricted access to debugfs in user
and user-debug builds. This restricts access to most of the features
exposed through debugfs. 'Coredump' and 'Recovery' are critical
interfaces that are required for remoteproc to work on Qualcomm Chipsets. 
Coredump configuration needs to be set to "inline" in debug/test builds
and "disabled" in production builds. Whereas recovery needs to be
"disabled" for debugging purposes and "enabled" on production builds.
This patch series removes the recovery/coredump entries from debugfs
and moves them to sysfs. Also, this disables the coredump collection
by default as this is a requirement for production devices.

Changelog:

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
  remoteproc: Move coredump configuration to sysfs
  remoteproc: Move recovery configuration to sysfs
  remoteproc: Change default dump configuration to "disabled"

 Documentation/ABI/testing/sysfs-class-remoteproc |  46 +++++++
 drivers/remoteproc/remoteproc_coredump.c         |   6 +-
 drivers/remoteproc/remoteproc_debugfs.c          | 168 -----------------------
 drivers/remoteproc/remoteproc_sysfs.c            | 120 ++++++++++++++++
 include/linux/remoteproc.h                       |   8 +-
 5 files changed, 173 insertions(+), 175 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

