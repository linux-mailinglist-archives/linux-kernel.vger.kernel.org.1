Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AB28C518
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbgJLXGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:06:18 -0400
Received: from z5.mailgun.us ([104.130.96.5]:18557 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731023AbgJLXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:06:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602543977; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=z6t7HV4bH2v0mmuzaitSoFrMCe6hQz3tk9NSin7efdk=; b=b5uPDGsllsijZG1b8QZ++VN7iAIiw+iBHus1EACmqQ9MfrE3v/SoOMXB16sc4P8cS4DUl2gx
 dDqBKS9lBs9vYYPdQrkW2pVfR+2wQNjJ7B1xVlXRLv2jXjAOV0QB6lSQ897d8uw60gfaCiVF
 KTt55YcHGQoeo+Ud7EqPKeSd4Bg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f84e168319d4e9cb5f3e948 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 23:06:16
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3FB9C433CB; Mon, 12 Oct 2020 23:06:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F5BBC433C9;
        Mon, 12 Oct 2020 23:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F5BBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH v3] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Mon, 12 Oct 2020 16:05:57 -0700
Message-Id: <cover.1602542734.git.sudaraja@codeaurora.org>
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

Sudarshan Rajagopalan (1):
  arm64/mm: add fallback option to allocate virtually contiguous memory

 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

