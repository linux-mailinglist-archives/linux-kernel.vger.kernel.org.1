Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3602A8B78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgKFAgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:36:06 -0500
Received: from z5.mailgun.us ([104.130.96.5]:32973 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732858AbgKFAgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:36:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604622964; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5fSP9DGFmy4a1RHdL6fQ6JMKD/ca1zSQadjTIA+5pME=; b=O6V/poYBJzf2KGbnM2sa/2e7N//kXkOlcv5PaJ8EHuyWx/Mp1GRQSdV+izE69Eh8HwhFbgfH
 WHRq8vXuBzucglxysRyMnyHamKhbMlLQ2lLtpsI53gav3LNhwFhgv5m884ucQmKY9AqC8dH1
 hkz2o7xbW8j7BD2XMGi0boyx3rk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa49a1e903b44cb0e87b5ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 00:34:38
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67787C433C9; Fri,  6 Nov 2020 00:34:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ECE9C433C6;
        Fri,  6 Nov 2020 00:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ECE9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 0/6] Minor bug fixes and clean-up for MHI host driver
Date:   Thu,  5 Nov 2020 16:34:23 -0800
Message-Id: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series serves to clean up the MHI host driver by removing an
unnecessary counter and an unused function. It also renames a function to make
it clearly worded. There is currently no user of this exported function which
makes it is safe to do so now.

Bug fixes include adding a missing EXPORT_SYMBOL_GPL to a function, and adding
a return value check to bail out of RDDM download in kernel panic path.

An outlier among the group exports the mhi_get_exec_env() API for use by
controller drivers, in case they need to determine behavior on the basis of the
current execution environment.

This set of patches was tested on arm64.

Bhaumik Bhatt (6):
  bus: mhi: core: Remove unnecessary counter from mhi_firmware_copy()
  bus: mhi: core: Add missing EXPORT_SYMBOL for mhi_get_mhi_state()
  bus: mhi: core: Expose mhi_get_exec_env() API for controllers
  bus: mhi: core: Remove unused mhi_fw_load_worker() declaration
  bus: mhi: core: Rename RDDM download function to use proper words
  bus: mhi: core: Skip RDDM download for unknown execution environment

 drivers/bus/mhi/core/boot.c     | 13 ++++++++-----
 drivers/bus/mhi/core/internal.h |  1 -
 drivers/bus/mhi/core/main.c     |  2 ++
 include/linux/mhi.h             | 12 +++++++++---
 4 files changed, 19 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

