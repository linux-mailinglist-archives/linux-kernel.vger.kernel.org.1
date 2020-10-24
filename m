Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1759297B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759882AbgJXHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 03:36:25 -0400
Received: from verein.lst.de ([213.95.11.211]:57807 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759874AbgJXHgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 03:36:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A6AAA68AFE; Sat, 24 Oct 2020 09:36:21 +0200 (CEST)
Date:   Sat, 24 Oct 2020 09:36:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org,
        hch@lst.de, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
Message-ID: <20201024073621.GA28151@lst.de>
References: <20201023065910.1358586-1-pizhenwei@bytedance.com> <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 11:01:40AM -0700, Sagi Grimberg wrote:
>>   +	/* received data length checking */
>> +	if (unlikely(wc->byte_len < len)) {
>> +		/* zero bytes message could be ignored */
>> +		if (!wc->byte_len) {
>> +			nvme_rdma_post_recv(queue, qe);
>> +			return;
>> +		}
>
> Nothing in the spec defines zero-length messages, hence we cannot
> support something that is not standard. If your array needs this,
> please submit a TPAR to the NVMe TWG.

We'll still need sanity checking instead of the recount underflow,
I think tearing down the connection here and kicking off error recovery
is probably the best idea.
