Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D912B4668
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgKPOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKPOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:53:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7EC0613CF;
        Mon, 16 Nov 2020 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zbANDMsxAnGY4qJHxu4bFJO67hGjNSt40DSg35mbbGk=; b=Rjhun6fXTUjpx8RHKiO/gk7Ssv
        CahjIZzcLRXWFppQHaZacXVKNp8931tU0rIuAjPDYvptQJK9o5DSci2bcHvuSBMuK1NJrUZVSMxEc
        ueIAA3tqhh7Xzbh9fPlkKERgKGuuaZraF9pionz3/ucjOZLsEE+kLMPbMs4E0WGQcv6dolC2MIxnE
        Mr8cZnzVYzXtaUYwj0/NoRBoPKuExlqZmNxg1oQzqYC1LpqixVI9fYd1b5qjD+9cK/7CbLxmcwUA1
        nnppXE13+HP+YxIdgaVkb/NBeJ/pDSWoiGdq151HFAx7eQJq3GAkxsHC/7dZxzanjWA6LvnIEMZPA
        P3JJ+GCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefsV-0002vS-KB; Mon, 16 Nov 2020 14:53:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1A5D301959;
        Mon, 16 Nov 2020 15:53:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF28120299B60; Mon, 16 Nov 2020 15:53:09 +0100 (CET)
Date:   Mon, 16 Nov 2020 15:53:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201116145309.GF3121378@hirez.programming.kicks-ass.net>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:46:03AM -0700, Shuah Khan wrote:

> +Increment interface
> +-------------------
> +
> +Increments sequence number and returns the new value. ::
> +
> +        seqnum32_inc_return() --> (u32) atomic_inc_return(seqnum)
> +        seqnum64_inc_return() --> (u64) atomic64_inc_return(seqnum)

Did you think about the ordering?

> +Fetch interface
> +---------------
> +
> +Fetched and returns current sequence number value. ::
> +
> +        seqnum32_fetch() --> (u32) atomic_add_return(0, seqnum)
> +        seqnum64_fetch() --> (u64) atomic64_add_return(0, seqnum)

That's horrible. Please explain how that is not broken garbage.

Per the fact that it is atomic, nothing prevents the counter being
incremented concurrently. There is no such thing as a 'current' sequence
number.


