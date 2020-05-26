Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFF51BD0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 02:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD2AOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 20:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD2AOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:14:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EB020737;
        Wed, 29 Apr 2020 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588119261;
        bh=ApiAPyhl/EFXtSrNddcCQTYMor9KnWKySFnM/W1KpQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gj633SS5ASO3BAGJRPyDnJc9G0cEPDsMsWpEe4wrBEoe0lF42RQ33mz05tbA8WzlV
         TVNb6T/5oHpRpWlmNZTSZQobZEpyVDLzhXEfds63/1kPcTlJVwuuldLO/hqJVzO31x
         ilUnL2ltMmDqxFt19OElVcqOxQrPHtY6S0Knl4HE=
Date:   Tue, 28 Apr 2020 17:14:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Waiman Long <longman@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Message-Id: <20200428171420.045f0acc9e1bf20044c4560e@linux-foundation.org>
In-Reply-To: <20200428111403.GJ29705@bombadil.infradead.org>
References: <20200428034736.27850-1-weiyongjun1@huawei.com>
        <20200428111403.GJ29705@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 04:14:03 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 28, 2020 at 03:47:36AM +0000, Wei Yongjun wrote:
> > The function ipc_id_alloc() is called from ipc_addid(), in which
> > a spin lock is held, so we should use GFP_ATOMIC instead.
> > 
> > Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> I see why you think that, but it's not true.  Yes, we hold a spinlock, but
> the spinlock is in an object which is not reachable from any other CPU.
> So it's not possible to deadlock.

um, then why are we taking it?

>  This probably confuses all kinds
> of automated checkers,

A big fat code comment would reduce the email traffic?

> and I should probably rewrite the code to not
> acquire the new spinlock until we're already holding the xa_lock.
> 

