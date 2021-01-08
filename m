Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4972EFB9E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbhAHXRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:17:15 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:43387 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:17:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610147815; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8k9WBpeIGAP0mLspkxyR4XM/TtoK/2Q8inGNLk6er9g=; b=P9x/Xe0jHwUcu3ni85S+HFO38hYth6byvdZ/EGo7p/wwjNLqA9FVWxb3vuxF6z4u6/L256ps
 9x8lN1kupnpmCrb9zPJ+Y2LK6EMFodSzHzoPSAnBgU2N5cikLIRG1aVlHv/FtBo0R45eoF1j
 p3Gh1a22S37GO8T06/ZlcxfXiwA=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ff8e7c246a6c7cde75592b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 23:16:18
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38631C43463; Fri,  8 Jan 2021 23:16:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4704CC433C6;
        Fri,  8 Jan 2021 23:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4704CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, anshuman.khandual@arm.com, david@redhat.com
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH 0/1] arm64: reduce section size for sparsemem
Date:   Fri,  8 Jan 2021 15:15:59 -0800
Message-Id: <cover.1610146597.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the follow-up from the discussions in the thread [1].
Reducing the section size has the merit of reducing wastage of reserved memory
for huge memory holes in sparsemem model. Also with smaller section size gives
more grunularity and agility for memory hot(un)plugging.

This patch tends to use the suggestion from David Hildenbrand in thread [1]
to set the least possible SECTION_SIZE_BITS for 4K, 16K and 64K page granule.
That is 27 (128MB) for 4K/16K and 29 (512MB) for 64K page granule.

[1] https://lore.kernel.org/lkml/cover.1609895500.git.sudaraja@codeaurora.org/T/#m8ee60ae69db5e9eb06ca7999c43828d49ccb9626

Sudarshan Rajagopalan (1):
  arm64: reduce section size for sparsemem

 arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

