Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A24290BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408651AbgJPS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:57:11 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:26229 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390142AbgJPS5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:57:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602874630; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=eW+n4+9SRtKr+LHkLVfSdlI5KH+gY8ORIWyfOxqj1E0=; b=CJxH+B0DFJ2Sevp9wLt4I/DzZN3RlvmNUeuShEaMwew2MW6rrqrONEu/VyDNNscJvaErux0Q
 osiZZO6gr/GFvR7AvAX1anicFpE8DWR4RGkiL6zb5ht4wal3BoWScNIrc9LdKeTOwKPXbLkF
 L25qBi7s8bOmr1leQqVoboErkXE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f89ed03856d9308b55267c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 18:57:07
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5395DC433F1; Fri, 16 Oct 2020 18:57:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E90AC433CB;
        Fri, 16 Oct 2020 18:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E90AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH v4] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Fri, 16 Oct 2020 11:56:55 -0700
Message-Id: <cover.1602722808.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1: The initial patch used the approach to abort at the first instance of PMD_SIZE
allocation failure, unmaps all previously mapped sections using vmemmap_free
and maps the entire request with vmemmap_populate_basepages to allocate 
virtually contiguous memory.
https://lkml.org/lkml/2020/9/10/66

V2: Allocates virtually contiguous memory only for sections that failed
PMD_SIZE allocation, and continous to allocate physically contiguous
memory for other sections.
https://lkml.org/lkml/2020/9/30/1489

V3: Addressed trivial review comments. Pass in altmap to vmemmap_populate_basepages.
https://lkml.org/lkml/2020/10/12/1681

V4: Fixes checkpatch warning.

Sudarshan Rajagopalan (1):
  arm64/mm: add fallback option to allocate virtually contiguous memory

 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

