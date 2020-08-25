Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335A251A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:53:25 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49846 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHYNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:53:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6qdjpd_1598363589;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U6qdjpd_1598363589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 21:53:09 +0800
Date:   Tue, 25 Aug 2020 21:53:09 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Some clean-ups for bio merge
Message-ID: <20200825135309.GA57246@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 18, 2020 at 01:45:27PM +0800, Baolin Wang wrote:
> Hi,
> 
> There are some duplicated code when trying to merge bio from pluged list
> and software queue, thus this patch set did some clean-ups when merging
> a bio. Any comments are welcome. Thanks.
> 
> Changes from v1:
>  - Drop patch 2 and patch 5 in v1 patch set.
>  - Add reviewed-by tag from Christoph.
>  - Move blk_mq_bio_list_merge() into blk-merge.c and rename it.
>  - Some coding style improvements.

Any comments for this patch set? Thanks.

> 
> Baolin Wang (3):
>   block: Move bio merge related functions into blk-merge.c
>   block: Add a new helper to attempt to merge a bio
>   block: Remove blk_mq_attempt_merge() function
> 
>  block/blk-core.c       | 156 --------------------------------------
>  block/blk-merge.c      | 202 +++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sched.c   |  94 +++++------------------
>  block/blk.h            |  23 ++++--
>  block/kyber-iosched.c  |   2 +-
>  include/linux/blk-mq.h |   2 -
>  6 files changed, 239 insertions(+), 240 deletions(-)
> 
> -- 
> 1.8.3.1
