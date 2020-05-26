Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996AA1C7307
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgEFOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgEFOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:40:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9AC061A0F;
        Wed,  6 May 2020 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnYKovQQh+r4DAzMjzqORJewlrdpqJX+DVWHWQY+cb8=; b=W6vSSifCrciNYazwbnNzBnzC3E
        ch7nEwPMDVzXwTnLWrdybTGHFzvboaQu3fxcOXYMNYWlVJg1NKqo62H9dT/6nu9KNW8iAcMPJTepA
        sYLhgtLwbVvj+nEn6bjMb9eKLIAiPl6Dqw5P3IQY6Gidaw5Wj88FSGlVHLhtQegVEInL1FNrodwRc
        PrOCzZTMmk0og/sPg23BIqAChOEvp74oKF8yEVtupAjVRdxDdwFScvglGLulCwvJA4HULFW483prG
        ONVKgaYS5wwK7s8Z7WZnLqWRMVxTInuxTD3lfdDrT6xb2DE+gly8/Zq2lB1+39M1p4w7oJZ3CY6bG
        qeHespng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWLDW-0001JC-4f; Wed, 06 May 2020 14:40:10 +0000
Date:   Wed, 6 May 2020 07:40:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 1/2] fs/iomap/direct-io: pass NOWAIT to bio flags
Message-ID: <20200506144010.GA27643@infradead.org>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
 <20200504160052.GA8625@infradead.org>
 <94ec1b65-5f4c-6b56-5a47-ca186615d978@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ec1b65-5f4c-6b56-5a47-ca186615d978@yandex-team.ru>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 07:23:50PM +0300, Konstantin Khlebnikov wrote:
> On 04/05/2020 19.00, Christoph Hellwig wrote:
> > On Mon, May 04, 2020 at 06:54:53PM +0300, Konstantin Khlebnikov wrote:
> > > This is required to avoid waiting in lower layers.
> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > 
> > This looks sensible.  Did you run this through xfstests?
> > 
> 
> Nope. It seems xfstests has one trivial test for NOWAIT - generic/471
> It tests only write with/without extent, nothing about contention.
> 
> I've added nowait into fio and played with it a little.
> https://github.com/axboe/fio/pull/972
> 
> With these patches I see EAGAINs when queue is flooded.

Once the fio changes land, can you add a simple fio based test
to xfstests?
