Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606D02AB445
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgKIKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgKIKDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:03:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60D9206E5;
        Mon,  9 Nov 2020 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604916190;
        bh=6uqlKQJMFGkCsYr7woYsXdVNDYK/EygJxpdA4wgOWKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtvUwlSap8HV/tGnKr012/TeDGiRu0JYvQ+J+/tbb+B5SqmFdW5Ah42Bh7EiBkxuB
         zXPJ51tX2UhG3XAhR3rUlbGB2QKVb0eCWXx6ns3VINuTt98G2K9pOSezfx4s9taKEq
         fkCWy4fofpFDlGlMXYOB0W8B9FhXCQUoKS6+MvNM=
Date:   Mon, 9 Nov 2020 11:04:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] locking/lock_events: no need to check return value of
 debugfs_create functions
Message-ID: <20201109100409.GA1053500@kroah.com>
References: <1604740753-17662-1-git-send-email-yangtiezhu@loongson.cn>
 <20201109083251.GA2594@hirez.programming.kicks-ass.net>
 <ef0058d3-8308-bd9c-7289-e4009fed3b4b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0058d3-8308-bd9c-7289-e4009fed3b4b@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:51:56PM +0800, Tiezhu Yang wrote:
> On 11/09/2020 04:32 PM, Peter Zijlstra wrote:
> > On Sat, Nov 07, 2020 at 05:19:13PM +0800, Tiezhu Yang wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > I strongly disagree and have told this to Greg before. Having half a
> > debug interface is weird at best, so upon failure we remove the whole
> > thing, which is consistent.
> 
> Hi Peter,
> 
> Thanks for your reply.
> 
> I find the early discussion and see the following opinion by Greg:
> 
> https://lore.kernel.org/patchwork/patch/1290162/
> 
> [ For debugfs, this isn't an issue, what can a user do with something like
> "debugfs isn't working?  What does that mean???"
> 
> And if we _really_ want warnings like this, it should go into the
> debugfs core, not require this to be done for every debugfs user, right?

The debugfs core does spit out a warning when this happens, so no need
to duplicate it in your code as well.

And for subsystems that _really_ want to check this, that's fine, it's
the minority for the whole tree, but please, document it well with a
comment on the check so that it doesn't get "cleanup" patches sent for
it in the future.

thanks,

greg k-h
