Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C257B27ACFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1Lhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:37:32 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:51241 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1Lhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:37:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601293051; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=IFRBRVnPylz4ax0kAn3HE4EqTe1MomSFW49DaD0CJN0=; b=jvnLNFOhp5yYXnuK5Z7+UcXnZRxxJ4LleQGPiWSPO345QeHnxU1wz1ELR04OfssWwwVHbjPR
 wBrYWJjBkt2ICbn81Qb/kaPXHkW2u9TIYuOGWxr/vaGrmxfvmrDT9hQvjV1fJLJqLpSFcHwt
 ovb32gNiOgZLDrbrfYHNc7UUz7Q=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f71caf6c00ccaf028e90bf6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 11:37:26
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 348F5C43395; Mon, 28 Sep 2020 11:37:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15252C433CA;
        Mon, 28 Sep 2020 11:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15252C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv2 0/2] Coresight ETF perf NULL pointer dereference and ETM save/restore fixes
Date:   Mon, 28 Sep 2020 17:07:07 +0530
Message-Id: <cover.1601292571.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 2 patch series provides fixes to ETF null pointer dereference crash
and TRCVMIDCCTLR1 register save and restore fix.

Patch 1 is an RFC since I am not sure of the fix provided since it looks
more like a band-aid than the actual fix.

Changes in v2:
 * Remove extra fixes tag (Suzuki)

Sai Prakash Ranjan (2):
  coresight: tmc-etf: Fix NULL pointer dereference in
    tmc_enable_etf_sink_perf()
  coresight: etm4x: Fix save and restore of TRCVMIDCCTLR1 register

 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: e209e73bee253afe969410150248f0c300c13d84
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

