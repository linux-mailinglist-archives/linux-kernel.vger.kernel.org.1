Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05A71AF88E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 09:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 03:58:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSH6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:58:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BA3768BEB; Sun, 19 Apr 2020 09:58:09 +0200 (CEST)
Date:   Sun, 19 Apr 2020 09:58:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200419075809.GA12222@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz> <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 08:40:20AM -0700, Bart Van Assche wrote:
> > This can have a sideeffect not only bdi->dev_name will be truncated to 64
> > chars (which generally doesn't matter) but possibly also kobject name will
> > be truncated in the same way.  Which may have user visible effects. E.g.
> > for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
> > other way around - i.e., let device_create_vargs() create the device name
> > and then copy to bdi->dev_name whatever fits?
> 
> How about using kvasprintf() instead of vsnprintf()?

That is what v1 did, see the thread in response to that on why it isn't
a good idea.
