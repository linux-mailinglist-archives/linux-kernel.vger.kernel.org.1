Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC072B98D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgKSRDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgKSRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:03:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FCFC0613CF;
        Thu, 19 Nov 2020 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q3JjqbRd48LNj800JFPvs1d5D002k9sDxOXNuujNm60=; b=F4P0jttwBRfF2JEdJB1WcdvUYA
        j/H/VVCn0x7Mc6hFOFeUEHGIQkU/R4EKO41zsb55h/Wt8mRkH7cFZKat3f6FeGwm+PhkZIb51VDQs
        tpKFvqWkjXXpjiG/0n5c4l9q9C/zmytnpCn7Setkkbw2f3O3dVkTLzfnNjfBfGTZAsOldTCQdiK0T
        I7LQ2a3UAYPy8MzCu+Fhq0dDYw6P29iuFw2ghSGpuRz+803EndC2Qy+uQZhE+pd1vU6909ChUHlZS
        FKYqYPExU1nRYa72R/oaiEJQnd6rOZp4xM9DyRgpx6n50S/H5fdp1pqa6Mih567m44pNgHAfxEJ+4
        BD6N8w6w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfnLR-00025i-14; Thu, 19 Nov 2020 17:03:41 +0000
Date:   Thu, 19 Nov 2020 17:03:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: optimise iter type checking
Message-ID: <20201119170340.GA6179@infradead.org>
References: <cover.1605799583.git.asml.silence@gmail.com>
 <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:29:43PM +0000, Pavel Begunkov wrote:
> The problem here is that iov_iter_is_*() helpers check types for
> equality, but all iterate_* helpers do bitwise ands. This confuses
> a compiler, so even if some cases were handled separately with
> iov_iter_is_*(), it can't eliminate and skip unreachable branches in
> following iterate*().

I think we need to kill the iov_iter_is_* helpers, renumber to not do
the pointless bitmask and just check for equality (might turn into a
bunch of nice switch statements actually).
