Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05B29FACA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgJ3BwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:52:13 -0400
Received: from z5.mailgun.us ([104.130.96.5]:59408 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3BwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:52:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604022731; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AiiVdcj6bYFwhyVGIXgAGlkRkHLNXBDjK0b11X3URuQ=; b=er063QoJeSea4UAjwxx/KRNCEAF2uVmmJ1azvR0GZDxRPQWrQpAQjoaiSUFTIKAfT5wJ4Q/J
 G+MUq1EwHcTOa1lxBdaDfK+g20QjuQVCYZT3YJrox+eBZkiWRNA8YW6O7jTYVowVy7obWRuZ
 pJU8Khypvn3narBgQFphWtUVxpU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f9b71cbfc3d7f56d0d0841a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Oct 2020 01:52:11
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D09DBC433C6; Fri, 30 Oct 2020 01:52:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFC22C433C8;
        Fri, 30 Oct 2020 01:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFC22C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 00/12] Bug fixes and improvements for MHI power operations
Date:   Thu, 29 Oct 2020 18:51:51 -0700
Message-Id: <1604022723-34578-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
-Addressed patches based on review comments and made improvements
-Added bus: mhi: core: Check for IRQ availability during registration
-Dropped bus: mhi: core: Use the IRQF_ONESHOT flag for the BHI interrupt line
-Split bus: mhi: core: Move to an error state on any firmware load failure
-Modified the following patches:
-bus: mhi: core: Disable IRQs when powering down
-bus: mhi: core: Improve shutdown handling after link down detection
-bus: mhi: core: Mark device inactive soon after host issues a shutdown
-bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
-Addressed the above as follow-up patches with improvements:
-bus: mhi: core: Prevent sending multiple RDDM entry callbacks
-bus: mhi: core: Separate system error and power down handling
-bus: mhi: core: Remove MHI event ring IRQ handlers when powering down

Bug fixes and improvements for MHI powerup and shutdown handling.
Firmware load function names are updated to accurately reflect their purpose.
Closed certain design gaps where the host (MHI bus) would allow clients to
operate after a power down or error detection.
Move to an error state sooner based on different scenarios.

These patches were tested on arm64 and X86_64 architectures.

Bhaumik Bhatt (12):
  bus: mhi: core: Use appropriate names for firmware load functions
  bus: mhi: core: Move to using high priority workqueue
  bus: mhi: core: Skip device wake in error or shutdown states
  bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
  bus: mhi: core: Prevent sending multiple RDDM entry callbacks
  bus: mhi: core: Move to an error state on any firmware load failure
  bus: mhi: core: Use appropriate label in firmware load handler API
  bus: mhi: core: Move to an error state on mission mode failure
  bus: mhi: core: Check for IRQ availability during registration
  bus: mhi: core: Separate system error and power down handling
  bus: mhi: core: Mark and maintain device states early on after power
    down
  bus: mhi: core: Remove MHI event ring IRQ handlers when powering down

 drivers/bus/mhi/core/boot.c |  60 ++++++-----
 drivers/bus/mhi/core/init.c |  10 +-
 drivers/bus/mhi/core/main.c |  16 +--
 drivers/bus/mhi/core/pm.c   | 236 ++++++++++++++++++++++++++++++++------------
 include/linux/mhi.h         |   2 +
 5 files changed, 225 insertions(+), 99 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

