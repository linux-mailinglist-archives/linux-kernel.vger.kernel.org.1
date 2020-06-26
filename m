Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594EE20B7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFZSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 14:12:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgFZSL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:11:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593195118; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ulJKfi5lN2v1zpPbbJV+leSuXmEAIHWHEqi7KXrscX4=; b=nHf3f/mv+UaGCH1wm0qrnpMLkNJ8M4u2mc2WzELDF43XMZCvjUc/DYbFw6Qz44iQKQ37nzxk
 QIDuhZ60W9pR5U1C1iygr+ZzpVKZKnNIwdg8HDIxVBH1BDbksigOvEK28pJ33HowvlXagXjQ
 FHaP8z3jsPZDXsGVQkHU6TvX65k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5ef63a68ad153efa346ff9b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:11:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11B76C433C6; Fri, 26 Jun 2020 18:11:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55522C433C8;
        Fri, 26 Jun 2020 18:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55522C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 0/2] ath10k: Fixes during subsystem recovery
Date:   Fri, 26 Jun 2020 23:41:38 +0530
Message-Id: <1593195100-24654-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes some fixes when the device
is in recovery mode, i.e. when the firmware goes down.

- Pausing TX queues when FW goes down
- Removed unwanted/extra error logging in pkt TX path
- Skipping wait for FW response for delete cmds
- Handling the -ESHUTDOWN error code in case of SSR.

Rakesh Pillai (2):
  ath10k: Pause the tx queues when firmware is down
  ath10k: Skip wait for delete response if firmware is down

 drivers/net/wireless/ath/ath10k/core.h |  1 +
 drivers/net/wireless/ath/ath10k/mac.c  | 36 ++++++++++++++++++++++------------
 drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.7.4

