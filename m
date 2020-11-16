Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E52B4854
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgKPPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbgKPO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE946C0613CF;
        Mon, 16 Nov 2020 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6EdMp+J4CPsD0P134OEgMzKPGqPxSRaNzTZK3tAi2vc=; b=Vlf4RNF5FC7pjylF3gIWO1MIuh
        UR7DDYawMGFs1g4faKaSosRjQ2LEI5vXfyjL+tmyFv2iTEwDGzh9f2OPWGaIOtKmNOjtNa9OXsWTf
        1B8edQMA7OxMjS4K/DbkxM9B1wY/HG7XWM+VZCwfSIiEtfeM25A48AJj7UUgmVkf7+tSC/saozz+q
        glcIUhge/OFe4cWaZ5QLy9SPWMO39mlJjp8Oosxe5pxM0cw6HOXNDM1mkkKWCTHhJKqf6HNnyIpqw
        HdiWQSmlLQcmRu6j8Be72teIYAKuI99jkYGhMYeuYI9G8T5JJqRxNDAp5by+fOu3dhsXGYbiJTLuy
        iTE5XtxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxy-0003u0-W3; Mon, 16 Nov 2020 14:58:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43EFB305CC3;
        Mon, 16 Nov 2020 15:58:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F5BE2025CA2A; Mon, 16 Nov 2020 15:58:50 +0100 (CET)
Date:   Mon, 16 Nov 2020 15:58:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201116145850.GC3121429@hirez.programming.kicks-ass.net>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
 <20201116144914.GE3121378@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116144914.GE3121378@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:49:14PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 13, 2020 at 09:03:27PM +0000, Matthew Wilcox wrote:
> > I think almost all of this information should go into atomic_ops.rst
> 
> No, we should delete atomic_ops.rst. It's bitrotted nonsense. The only

Sod it, I'll just queue a deletion. That'll stop people from trying to
update the trainwreck.
