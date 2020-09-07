Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716FE25F31B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgIGGUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 02:20:30 -0400
Received: from verein.lst.de ([213.95.11.211]:47767 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgIGGU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:20:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE1C56736F; Mon,  7 Sep 2020 08:20:26 +0200 (CEST)
Date:   Mon, 7 Sep 2020 08:20:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200907062026.GA19076@lst.de>
References: <20200903155922.1111551-1-hch@lst.de> <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:34:37AM +0200, Rasmus Villemoes wrote:
> On 03/09/2020 17.59, Christoph Hellwig wrote:
> > Christophe reported a major speedup due to avoiding the iov_iter
> > overhead, so just add this trivial function.  Note that /dev/zero
> > already implements both an iter and non-iter writes so this just
> > makes it more symmetric.
> > 
> > Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> ?-by ?

Suggested-by,

> > +static ssize_t read_zero(struct file *file, char __user *buf,
> > +			 size_t count, loff_t *ppos)
> > +{
> > +	size_t cleared = 0;
> > +
> > +	while (count) {
> > +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
> > +
> > +		if (clear_user(buf + cleared, chunk))
> > +			return cleared ? cleared : -EFAULT;
> 
> Probably nobody really cares, but currently doing
> 
> read(fd, &unmapped_page - 5, 123);
> 
> returns 5, and those five bytes do get cleared; if I'm reading the above
> right you'd return -EFAULT for that case.
> 
> 
> > +		cleared += chunk;
> > +		count -= chunk;
> > +
> > +		if (signal_pending(current))
> > +			return cleared ? cleared : -ERESTARTSYS;
> 
> I can't see how we can get here without 'cleared' being positive, so
> this can just be 'return cleared' (and if you fix the above EFAULT case
> to more accurately track how much got cleared, there's probably no
> longer any code to be symmetric with anyway).

Yeah, I'll fix these up and resend.
