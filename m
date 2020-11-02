Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA02A327A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgKBSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:02:43 -0500
Received: from verein.lst.de ([213.95.11.211]:34202 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgKBSCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:02:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DB4368B05; Mon,  2 Nov 2020 19:02:40 +0100 (CET)
Date:   Mon, 2 Nov 2020 19:02:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Simplify the nvme_req_qid()
Message-ID: <20201102180240.GA20182@lst.de>
References: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com> <2735ac5c-3d7a-0829-368a-2066e75fe635@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2735ac5c-3d7a-0829-368a-2066e75fe635@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 07:44:21PM +0800, Baolin Wang wrote:
> Hi,
>
>> Use the request's '->mq_hctx->queue_num' directly to simplify the
>> nvme_req_qid() function.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> Gentle ping?

As this clearly isn't 5.10 material it will have to wait for the 5.11
branch like everyone else.
