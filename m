Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA306280850
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgJAUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:18:27 -0400
Received: from z5.mailgun.us ([104.130.96.5]:17036 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733010AbgJAUS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:18:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601583506; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4ote06KXhTaBX+Q+M3N8szhr5Eu8Upx3lVbkME0j8Tk=; b=P5AnGqgJ9x7QWQXbLNwOEIFrwCMNFGxbyPjK7Mm6xXSOCX1fTf9QW856tjLu4GC7jOsqltCD
 JXFlbd6+R5vBqES1oUCSFUbilMCht7Sp7zBd+hRkXtmVJICao868t2ZQuEe+tlM6Bm/HsiBH
 7qMzF898Ch9b1lS5jxX0w8SogZY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f76394a7671600ec813f79c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 20:17:14
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5844EC433F1; Thu,  1 Oct 2020 20:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD78BC433CA;
        Thu,  1 Oct 2020 20:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD78BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH v3] arm64/mm: add fallback option to allocate virtually
Date:   Thu,  1 Oct 2020 13:16:45 -0700
Message-Id: <cover.1601582954.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1: The initial patch used the approach to abort at the first instance of PMD_SIZE
allocation failure, unmaps all previously mapped sections using vmemmap_free
and maps the entire request with vmemmap_populate_basepages to allocate
virtually contiguous memory.
https://lkml.org/lkml/2020/9/10/66

V2: Allocates virtually contiguous memory only for sections that failed
PMD_SIZE allocation, and continues to allocate physically contiguous
memory for other sections.
https://lkml.org/lkml/2020/9/30/1489

V3: Addresses Anshuman's comment to allow fallback to altmap base pages
as well if and when required.

Sudarshan Rajagopalan (1):
  arm64/mm: add fallback option to allocate virtually contiguous memory

 arch/arm64/mm/mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

