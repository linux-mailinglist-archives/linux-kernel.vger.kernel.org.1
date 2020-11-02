Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5502A2D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKBOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:40:40 -0500
Received: from z5.mailgun.us ([104.130.96.5]:42110 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgKBOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:40:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604328039; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0A7SV27oT9X2OLjiEXNiar9HJuar9z66aG37SwSDow0=; b=ET19JFlyLJr7n0h9yDNZgFn7mIuK0NlsQLe5JB/vlTTvdLFTkVIbCNJUpOWduVoHDqC6NCe6
 i7hsXD+Xf1L16X1+NhNVwv10AUuSScL+QqhnPKSQ5RRgZlhgKhTcXdFYJRSeW1sgyLr1awN5
 C/Y5pxekigLUo7175/nNzI+fB/8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fa01a4f893bc9231d7075e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 14:40:15
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20386C433FE; Mon,  2 Nov 2020 14:40:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A683C433C8;
        Mon,  2 Nov 2020 14:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A683C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH 0/2] Increasing CMA Utilization with a GFP Flag
Date:   Mon,  2 Nov 2020 06:39:20 -0800
Message-Id: <cover.1604282969.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current approach to increasing CMA utilization introduced in
commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma
pageblocks for movable allocations") increases CMA utilization by
redirecting MIGRATE_MOVABLE allocations to a CMA region, when
greater than half of the free pages in a given zone are CMA pages.
The issue in this approach is that allocations with type
MIGRATE_MOVABLE can still succumb to pinning. To get around
this, one approach is to re-direct allocations to the CMA areas, that
are known not to be victims of pinning.

To this end, this series brings in __GFP_CMA, which we mark with
allocations that we know are safe to be redirected to a CMA area.

Heesub Shin (1):
  cma: redirect page allocation to CMA

Vinayak Menon (1):
  zram: allow zram to allocate CMA pages

 drivers/block/zram/zram_drv.c |  5 +--
 include/linux/gfp.h           | 15 ++++++++
 include/linux/highmem.h       |  4 ++-
 include/linux/mmzone.h        |  4 +++
 mm/page_alloc.c               | 83 +++++++++++++++++++++++++++----------------
 mm/zsmalloc.c                 |  4 +--
 6 files changed, 79 insertions(+), 36 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

