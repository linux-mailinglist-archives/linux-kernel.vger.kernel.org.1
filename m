Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85EF1B0356
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 03:48:06 -0400
Received: from verein.lst.de ([213.95.11.211]:39146 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDTHsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:48:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6582968C4E; Mon, 20 Apr 2020 09:48:01 +0200 (CEST)
Date:   Mon, 20 Apr 2020 09:48:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200420074801.GA30795@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz> <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org> <20200419075809.GA12222@lst.de> <a37e947d-c49a-837e-e97d-647ca9d378c3@acm.org> <20200419160651.GA18308@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419160651.GA18308@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 06:06:51PM +0200, Christoph Hellwig wrote:
> > (https://lore.kernel.org/linux-block/20200416071519.807660-4-hch@lst.de/) 
> > and also to the replies to that patch? This is what I found in the replies: 
> > "When driver try to to re-register bdi but without release_bdi(), the old 
> > dev_name will be cover directly by the newer in bdi_register_va(). So, I am 
> > not sure whether it can cause memory leak for bdi->dev_name."
> >
> > Has it been considered to avoid that leak by freeing bdi->dev_name from 
> > unregister_bdi(), e.g. as follows?
> 
> We'd need some protection against concurrent accesses as unregister_bdi
> can race with them.  But with RCU that could be handled, so let me try
> that.

I looked into it, and while it seems doable I think this goes in the
wrong direction as it pushed the RCU knowledge into the callers.  I'd
rather get something like this series in ASAP, and then for 5.8 or 5.9
move the bdi pointer to the gendisk and stop re-registering it and thus
solve the problems root cause for real.
