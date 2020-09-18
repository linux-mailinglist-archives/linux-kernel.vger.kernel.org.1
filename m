Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDD27057F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRT1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:27:02 -0400
Received: from so254-54.mailgun.net ([198.61.254.54]:51937 "EHLO
        so254-54.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIRT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:27:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600457221; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=eD4kNKjZz2eCtHGP6cX6JAt0uRdVafNe797JPure7z4=; b=OvD2zSZpeRxJK3rI01AUPo8+Xccruq0CYQRxvklatQOmr96myOLsOMyGjwMYrzVWdRvQRtp6
 dcGVSr3CN4i6pdYutaxL933A/caJnEvvZ91P0Wn0+kevTbJLPfvK4EjONT+3JBWaTomxy+2o
 H6QMbskEQzaEd4s9YZvwHnbbEgM=
X-Mailgun-Sending-Ip: 198.61.254.54
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f650a05ea858627d59df42e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 19:27:01
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 198BDC433FF; Fri, 18 Sep 2020 19:27:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 737C7C433F1;
        Fri, 18 Sep 2020 19:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 737C7C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 0/3] Debugfs and Sysfs entries for MHI
Date:   Fri, 18 Sep 2020 12:26:50 -0700
Message-Id: <1600457213-11587-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce debugfs and sysfs entries for MHI.
Fixes to allow building MHI as a module without warnings/errors.

This set of patches was tested on arm64 and x86_64 architectures.

v2:
-Remove the patch for removal of MODULE_LICENSE() warnings
-Add fixes to adhere to the Kconfig coding style

Bhaumik Bhatt (3):
  bus: mhi: Fix entries based on Kconfig conding style
  bus: mhi: core: Introduce debugfs entries for MHI
  bus: mhi: core: Introduce sysfs entries for MHI

 Documentation/ABI/stable/sysfs-bus-mhi |  21 ++
 MAINTAINERS                            |   1 +
 drivers/bus/mhi/Kconfig                |  20 +-
 drivers/bus/mhi/core/Makefile          |   1 +
 drivers/bus/mhi/core/debugfs.c         | 410 +++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/init.c            |  60 +++++
 drivers/bus/mhi/core/internal.h        |  24 ++
 include/linux/mhi.h                    |   2 +
 8 files changed, 533 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
 create mode 100644 drivers/bus/mhi/core/debugfs.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

