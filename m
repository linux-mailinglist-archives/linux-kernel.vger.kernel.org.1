Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6246B20B7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 20:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFZSCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 14:02:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46609 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgFZSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:01:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593194518; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3jBIQeSeWIXTNigOUBSApAntBRRgxn7gCDEW1Xz+o8A=; b=Lce75GwOR7RPn0vdBe6THjUw7+1TD19FptCyvrwetMihx91ze9CmHok/Xe+A4y23WU9FAMZP
 B5XqJ1uzkVknHW0h0f5G76jxfxxWBYXFgqAII0u8lCAZNokXngyrsMtgLx2Qc5gswJjzf6Ft
 1/FIxyRxOvjIPOO3PaJxpWfVGQM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ef6380e4c9690533a604e25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:01:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 015E2C433CA; Fri, 26 Jun 2020 18:01:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09E3BC433C8;
        Fri, 26 Jun 2020 18:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09E3BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 0/2] ath10k: Add chain-1 voltage regulator voting
Date:   Fri, 26 Jun 2020 23:31:40 +0530
Message-Id: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support to vote for the chain-1
voltage regulator for WCN3990. This is
added as an optional property.

Rakesh Pillai (2):
  dt: bindings: Add new regulator as optional property for WCN3990
  ath10k: Add support for chain1 regulator supply voting

 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
 drivers/net/wireless/ath/ath10k/snoc.c                         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4

