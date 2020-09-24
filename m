Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C305D276829
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 07:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIXFRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 01:17:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:24597 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgIXFRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 01:17:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600924658; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9c5kRk1iRWNGCAyOwHL9JZ77Jetg7PxW6V4Qija+Jw4=; b=Kxkx1iC2mx/66nJUuf36KGVwp5MPBykXY5MyB5uPzZaTvM124Bugev8ylxqvCbP1KVORP53h
 ibXDWViCWABruQzi0d02Ji+8ogN4dTzhGpPlBPL56OV+3LX/F1Nvrz3fGzWXs7DD95G/Xngz
 NWKQ88jWBj6U1W/4mVnCfzBx/vo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f6c2bde48c378a4cbeb6dc1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 05:17:18
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 652AAC433F1; Thu, 24 Sep 2020 05:17:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3079CC433C8;
        Thu, 24 Sep 2020 05:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3079CC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        sudaraja@codeaurora.org, iamjoonsoo.kim@lge.com, david@redhat.com
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v3] mm: cma: indefinitely retry allocations in cma_alloc
Date:   Wed, 23 Sep 2020 22:16:24 -0700
Message-Id: <cover.1600922611.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1: Introduces a retry loop that attempts a CMA allocation a finite
number of times before giving up:
 
https://lkml.org/lkml/2020/8/5/1097
https://lkml.org/lkml/2020/8/11/893

V2: Introduces an indefinite retry for CMA allocations.  David Hildenbrand
raised a page pinning example which precludes doing this infite-retrying
for all CMA users:

https://lkml.org/lkml/2020/9/17/984

V3: Re-introduce a GFP mask argument for cma_alloc(), that can take in
__GFP_NOFAIL as an argument to indicate that a CMA allocation should be
retried indefinitely. This lets callers of cma_alloc() decide if they want
to perform indefinite retires. Also introduces a config option for
controlling the duration of the sleep between retries.

Chris Goldsworthy (1):
  mm: cma: indefinitely retry allocations in cma_alloc

 arch/powerpc/kvm/book3s_hv_builtin.c       |  2 +-
 drivers/dma-buf/heaps/cma_heap.c           |  2 +-
 drivers/s390/char/vmcp.c                   |  2 +-
 drivers/staging/android/ion/ion_cma_heap.c |  2 +-
 include/linux/cma.h                        |  2 +-
 kernel/dma/contiguous.c                    |  4 ++--
 mm/Kconfig                                 | 11 ++++++++++
 mm/cma.c                                   | 35 +++++++++++++++++++++++++-----
 mm/cma_debug.c                             |  2 +-
 mm/hugetlb.c                               |  4 ++--
 10 files changed, 50 insertions(+), 16 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

