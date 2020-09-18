Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD827042F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 14:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRSjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:39:03 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2170421534;
        Fri, 18 Sep 2020 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600454342;
        bh=eQ/mXtuCe+QeGTc/RHYTchYYCdqA6wa/fyMARmJkKYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRQhO426pkSn/S1aW1IFu5mAljw7OTAJ7e2YYg4sKk/I02XDBTab9dLY4Dl/AaUU3
         sL1kHZ3tuieW5XOvQQiX5uXyXVB4WsTKsViE6yn6MisLANKeeDXlx/8ndAVd91Eqtm
         lZ2s979pBBxWqn4eD7/EnsoEVjPFKsIUE8wFPYiM=
Date:   Fri, 18 Sep 2020 11:38:59 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200918183859.GA4030639@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
 <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
 <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:32:12PM -0400, Tong Zhang wrote:
> Please correct me if I am wrong.
> After a bit more digging I found out that it is indeed command_id got
> corrupted is causing this problem. Although the tag and command_id
> range is checked like you said, the elements in rqs cannot be
> guaranteed to be not NULL. thus although the range check is passed,
> blk_mq_tag_to_rq() can still return NULL. 

I think your describing a sequence problem in initialization. We
shouldn't have interrupts wired up to uninitialized tagsets.

A more appropriate sequence would setup request_irq() after the tagset
is ready. It makes handling a failed irq setup a bit weird for io
queues, though.

> It is clear that the current sanitization is not enough and there's
> more implication about this -- when all rqs got populated, a corrupted
> command_id may silently corrupt other data not belonging to the
> current command.

The block layer doesn't do anything with requests that haven't been
started, so if your controller completes non-existent commands, then
nothing particular will happen with the rqs.

If the request had been started and the controller provides a corrupted
completion, then the fault lies entirely with the controller and you
should raise that issue with your vendor. There's no way the driver can
distinguish a genuine completion from a corrupted one.
