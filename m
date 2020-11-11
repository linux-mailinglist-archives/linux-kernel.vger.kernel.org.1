Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060F32AF796
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKKRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:50:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F5C0613D1;
        Wed, 11 Nov 2020 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I4VB6AjyVLVrgx79NznZ+wPYu75kAxiKFR/i1fmYTpU=; b=n+auQG7pPfv+Wca1d8fF0+Lldc
        HfGtUiQHn54BkCjhemyDdnCl1g2jQ0bkWnlTZqiRK1Ij94LqkXzGSIuhiZ8jUuDbPuAhfH2I+ZWCX
        fgNVrHjfmOL5CW1Aoh++7yOv4Ag1AzTapBjDJioJViHgZdExQS3ATjvlvI9lJ6FVkrDySmvgOTVFD
        csIU4So8rW1FA5usumQT0e31ad9ETfn42+zL43WL4nL47MuHxm0YPe79Sh6H7yLXHYDjUC/F/VCXD
        xfdxVKqHOkB0QQOKJkeAOCeTtQUxbWu8ljEX15SIIg+b5K0TlCmm9u0EcXsSENpZglJ56iIzupdzN
        HmCFn/Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcuGO-0006OJ-Bp; Wed, 11 Nov 2020 17:50:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98B07301E02;
        Wed, 11 Nov 2020 18:50:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 868812BE0D3EC; Wed, 11 Nov 2020 18:50:31 +0100 (CET)
Date:   Wed, 11 Nov 2020 18:50:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201111175031.GI2628@hirez.programming.kicks-ass.net>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
 <20201111160411.GF2628@hirez.programming.kicks-ass.net>
 <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:34:05AM -0700, Shuah Khan wrote:

> Not sure what to make of the 6080 atomic_read()s and 3413
> atomic_inc()s, some of which might be assuming uniqueness
> guarantee.

Well, clearly you just did: git grep atimic_{read,inc}() | wc -l and
didn't look at the usage. Equally clearly there can be bugs. Also
evidently much of those are not in fact sequence numbers.

All I'm saying is that if you want a sequence number, inc_return (or
fetch_inc) is the only sane option.
