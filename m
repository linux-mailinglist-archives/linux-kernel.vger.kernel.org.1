Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA963296D51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462676AbgJWLFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462559AbgJWLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F496C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jnp658t1DDD6IIk2CsnZ4VQrdRxNgCykA+b+Xqnrt0c=; b=XXB/jxGXnn0cDQqUhob5WBh7gk
        aGisOUGNcBAO0YStP4+VoVuzzKRLOnHKNmtO7lTcto+p1IyIOMRrSZJKeNzfUPMlv4rODQpxsGzQ4
        QFaKTqe/dkibNDCO8pzihdHNI0ZiNao7Ozny4Woggre19RHl6seKoKtfMjAcAGYkrmFmBl/NckjdA
        4ONTCM3ZjjmbUn17MmbrH/4xNGD04cuQOMd8YqSK0fRs6iifkuaNklK8+V75beXEOHp4gbnhNiydW
        Gb4t1Ah7rTbN+w92RKm5aOUBtLu8+rptWoJQjUbfMAT6OuTIOJbL7ygpFDc+clCWRbxgjSZ7wRKa+
        PdyerfiA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVusw-0005Tp-2U; Fri, 23 Oct 2020 11:05:26 +0000
Date:   Fri, 23 Oct 2020 12:05:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] workqueue: export apply_workqueue_attrs()
Message-ID: <20201023110526.GB20293@infradead.org>
References: <87blgzf5xy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blgzf5xy.fsf@notabene.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:52:09AM +1100, NeilBrown wrote:
> 
> Lustre is a widely used cluster filesystem which is currently
> out-of-tree, but work is underway to make it ready for upstream
> submission.
> 
> Lustre needs apply_workqueue_attrs(), and for this reason that function
> was exported in Commit 6106c0f82481 ("staging: lustre: lnet: convert
> selftest to use workqueues").

None of this matters.  We don't export unused symbols, period.
