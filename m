Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07D2B688D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgKQPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgKQPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:21:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E84AC0613CF;
        Tue, 17 Nov 2020 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Enbb0xaD9p+aI9prwRGmvNBILp41HXLOKQP0KddruwQ=; b=WCgi4ptwo02ENrFbjshvIKy+3R
        cwwg6dj5qCz2wTDVPXDJGB80peZ5LQDZshRaV9hYHnGRcBm05j+5Ktf4UnNsjQZ0iuFhsDJ5JC9bO
        SI2s71lnTRYRYoKF//qlNSq6oVUE+YDV4pwNJ5mGBJGgMcd2ab0fA2VFi+bQlviv88a3oo+GG6TTD
        GcEx+N/wlMSZe+0HVSf4OgMLWfU/w8vogVlU5y+cmswaUBtGpHue+wdHMv+oQ7fnrxO9pdGD8neIv
        oSsxdFpgk85M+OgocOLlhBI1NB4N57jsFvadlndoBDD68uAql4wHT682EO3WZBUvgtNK/2cnE5oY8
        gpKsImYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf2na-0002aE-En; Tue, 17 Nov 2020 15:21:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F419301959;
        Tue, 17 Nov 2020 16:21:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EFD120116725; Tue, 17 Nov 2020 16:21:35 +0100 (CET)
Date:   Tue, 17 Nov 2020 16:21:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201117152135.GO3121392@hirez.programming.kicks-ass.net>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
 <20201116144914.GE3121378@hirez.programming.kicks-ass.net>
 <20201116145850.GC3121429@hirez.programming.kicks-ass.net>
 <050d5555-f8b4-f54d-e13c-149815b1b64c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050d5555-f8b4-f54d-e13c-149815b1b64c@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:50:15AM -0700, Shuah Khan wrote:
> On 11/16/20 7:58 AM, Peter Zijlstra wrote:
> > On Mon, Nov 16, 2020 at 03:49:14PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 13, 2020 at 09:03:27PM +0000, Matthew Wilcox wrote:
> > > > I think almost all of this information should go into atomic_ops.rst
> > > 
> > > No, we should delete atomic_ops.rst. It's bitrotted nonsense. The only
> > 
> > Sod it, I'll just queue a deletion. That'll stop people from trying to
> > update the trainwreck.
> > 
> 
> Please don't delete the document. This is one of the documents that has
> the information to make decisions about the api usage.
> 
> atomic_t information is spread out in various Doc directories. It should
> be consolidated, instead of removing files.

It is gone.. Please read Documentation/atomic_*.txt if you want to know
about atomic_t or bitops.
