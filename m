Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81D241A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgHKLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 07:49:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34394 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728326AbgHKLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:49:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U5TLSaN_1597146559;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5TLSaN_1597146559)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Aug 2020 19:49:19 +0800
Date:   Tue, 11 Aug 2020 19:49:19 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Some clean-ups for bio merge
Message-ID: <20200811114919.GA84227@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 29, 2020 at 11:28:32AM +0800, Baolin Wang wrote:
> Hi,
> 
> There are some duplicated code when trying to merge bio from pluged list
> and software queue, thus this patch set did some clean-ups when merging
> a bio. Any comments are welcome. Thanks.

Any comments for this patch set? Thanks.

> 
> Baolin Wang (5):
>   block: Move bio merge related functions into blk-merge.c
>   block: Remove redundant blk_mq_sched_allow_merge() validation
>   block: Add a new helper to attempt to merge a bio
>   block: Remove blk_mq_attempt_merge() function
>   block: Remove __blk_mq_sched_bio_merge() helper
> 
>  block/blk-core.c     | 156 -----------------------------------------------
>  block/blk-merge.c    | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sched.c |  64 ++++++--------------
>  block/blk-mq-sched.h |  13 +---
>  block/blk.h          |   9 +++
>  5 files changed, 197 insertions(+), 213 deletions(-)
> 
> -- 
> 1.8.3.1
