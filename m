Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC22272236
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIULW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgIULW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:22:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5ECA207BC;
        Mon, 21 Sep 2020 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600687345;
        bh=mdsxoXosKoVq0ViD3cc6b897m3OaDXieAFukERQslCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w8irqgGUltRLsDOVIfBSLRPhDioFdT51/BaS6bgRTR2N4uvVojMdJ3AnvlYFWvVfU
         2FUCihMvt6QOSsz1lMsbtIeR90ZnT4qvEvP03kZb6gElSfUoJCfXwgNRZ7/lndztDO
         0CaCteDwHR/pZBgtBbncv9pYO1EmoBzPLw8WgOAY=
Date:   Mon, 21 Sep 2020 12:22:19 +0100
From:   Will Deacon <will@kernel.org>
To:     peterz@infradead.org
Cc:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain
 the old value
Message-ID: <20200921112218.GB2139@willie-the-truck>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
 <20200729111120.GA2638@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:11:20PM +0200, peterz@infradead.org wrote:
> On Tue, Jul 28, 2020 at 11:56:38AM +0100, David Howells wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > Please do not _undo_ the changes; just add the API you need.
> > > 
> > > add_return and sub_return are horrible interface for refcount, which is
> > > the problem.
> > > 
> > > If you meant: refcount_dec(), but want the old value for tracing, you
> > > want a different ordering than if you wanted to do
> > > refcount_dec_and_test(); dec_return can't know this.
> > > 
> > > David, would something like a __refcount_*() API work where there is a
> > > 3rd argument (int *), which, if !NULL, will be assigned the old value?
> > 
> > That would be fine, though the number needs to be something I can interpret
> > easily when looking through the traces.  It would also be okay if there was an
> > interpretation function that I could use in the trace point when setting the
> > variable.
> 
> I'm not entirely sure what you mean with interpret, provided you don't
> trigger a refcount fail, the number will be just what you expect and
> would get from refcount_read(). If you do trigger a fail, you'll get a
> negative value.
> 
> How's the below? I didn't provide __refcount versions for the external
> functions, I suppose that can be done too, but wondered if you really
> needed those.

It looks like this didn't go anywhere, but I'm supportive of the general
idea if it's useful to somebody. The only part I find a bit grotty is that
we end up introducing a bunch of redundancy in some of the new functions,
e.g.:


> @@ -219,9 +235,14 @@ static inline void refcount_add(int i, r
>   *
>   * Return: true if the increment was successful, false otherwise
>   */
> +static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
> +{
> +	return __refcount_add_not_zero(1, r, oldp);
> +}

Where returning both a bool to indicate whether the old value was zero
and also the old value itself is a bit OTT.

Will
