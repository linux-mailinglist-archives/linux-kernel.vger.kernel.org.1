Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775A2FE1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAUFbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:31:00 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:14032 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbhAUFar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:30:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611207008; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=hfAxKpHRFM9Y26tV/QvUdyavnpRphrMju5aLp3NQ+4Y=; b=lZ5qIGYqRgP6urTtbdy3jJrIdj0tEsniLd0HB3forAJJfTrr1OIhp918KxUIp9UY9plEzZmZ
 bk++7GQGmB9BsgcLahSxCwFJCIdQbNJgnzfFOEVSvEjm9nu+33LcvLX1/lW8mL6pn2HqBHwb
 89W8koEx2VjnJJrWLx86csY8pRQ=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 600911365677aca7bd782bbd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 05:29:26
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D77BC43461; Thu, 21 Jan 2021 05:29:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BDA1C433C6;
        Thu, 21 Jan 2021 05:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BDA1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH 0/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Date:   Wed, 20 Jan 2021 21:29:12 -0800
Message-Id: <cover.1611206601.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the follow-up from the discussions in the thread [1].
Reducing the section size has the merit of reducing wastage of reserved memory
for vmmemmap mappings for sections with large memory holes. Also with smaller 
section size gives more grunularity and agility for memory hot(un)plugging.

But there are also constraints in reducing SECTION_SIZE_BIT:

- Should accommodate highest order page for a given config
- Should not break PMD mapping in vmemmap for 4K pages
- Should not consume too many page->flags bits reducing space for other info

This patch uses the suggestions from Anshuman Khandual and David Hildenbrand
in thread [1] to set the least possible section size to 128MB for 4K and 16K
base page size configs for simplicity, and to 512MB for 64K base page size config.

[1] https://lore.kernel.org/lkml/cover.1609895500.git.sudaraja@codeaurora.org/T/#m8ee60ae69db5e9eb06ca7999c43828d49ccb9626


Sudarshan Rajagopalan (1):
  arm64/sparsemem: reduce SECTION_SIZE_BITS

 arch/arm64/include/asm/sparsemem.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

