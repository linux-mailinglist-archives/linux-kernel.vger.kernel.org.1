Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0104297A43
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758855AbgJXCAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:00:52 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42199 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755869AbgJXCAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:00:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603504851; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0uDaYOZPoU8fD/BmOOa/brvrk/cBkXCfDoj5KQ20XgU=; b=TMMT9gVNUQaqaZRmNKDsmkVT75S1VcFJ24Z8mjRnmJzdDdyyX81aYlZpSMjqcQMIW1eNnyyC
 2XvHTb5HL8m+khkmpphCfALtPHukB6dVNFnWZeQgMVlOgTPPH3YNCJh0vv2h55/mx3c0LIbY
 fC91e5FIXcjAQZqyHI1UGnIF0qQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f938ad3abdbaddfebe70366 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 24 Oct 2020 02:00:51
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCF26C433F0; Sat, 24 Oct 2020 02:00:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 108E3C433C9;
        Sat, 24 Oct 2020 02:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 108E3C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 0/2] Check for device supported event rings and channels
Date:   Fri, 23 Oct 2020 19:00:41 -0700
Message-Id: <1603504843-38557-1-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is introduced to make sure device supported hardware event ring,
hardware channels, total number of event rings and total number of channels
match with MHI host controller. In case of a mismatch, driver bails out and
does not move MHI device to M0 from Ready state.

Hemant Kumar (2):
  bus: mhi: core: Count number of HW channels supported by controller
  bus: mhi: core: Check for device supported event rings and channels

 drivers/bus/mhi/core/init.c     | 33 +++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/internal.h |  5 +++++
 include/linux/mhi.h             |  1 +
 3 files changed, 39 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

