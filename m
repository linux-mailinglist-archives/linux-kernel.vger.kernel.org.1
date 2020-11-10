Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCFE2AE14E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgKJVDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgKJVDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:03:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F188C0613D1;
        Tue, 10 Nov 2020 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jXrVumA1i2kZezBmOTg1+6kfgcCy4jVb7CD/Abz9u0k=; b=kqiYQYL/NsgXXqkSd+EGls3rwZ
        v1Za/W32bJuLl8briOhT1rGbbS8A/dCgir4neGS2PWrd8O5PMgQXhYbeFQkvyZNWjrUV4ayMPQoEn
        BTbd2YFwnw3nIgg9NM2k+44zIfRdmms3ixHO6UyIwHlTbwZ0PgRusNtP1gSHn73ikpZeHgKLIQqD5
        w7KG/AIqajPFv3r9uaTVmgB9bCFgj+Mi5Uoe+ILglcuQkkSafyzex34gt2OYw+keNd+Et12DoONza
        O0V3N6JRVP4/ixegnsQRH0YEOmz+tGSOLTN9B36UmwrDltgPc+fBcPg9q78/kTJQLW9GS/UEc3GTV
        ZRDrV/Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcanM-0003Jb-UG; Tue, 10 Nov 2020 21:03:17 +0000
Date:   Tue, 10 Nov 2020 21:03:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201110210316.GO17076@casper.infradead.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
> Sequence Numbers wrap around to INT_MIN when it overflows and should not

Why would sequence numbers be signed?  I know they're built on top of
atomic_t, which is signed, but conceptually a sequence number is unsigned.

> +++ b/Documentation/core-api/seqnum_ops.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: <isonum.txt>
> +
> +.. _seqnum_ops:
> +
> +==========================
> +Sequence Number Operations
> +==========================
> +
> +:Author: Shuah Khan
> +:Copyright: |copy| 2020, The Linux Foundation
> +:Copyright: |copy| 2020, Shuah Khan <skhan@linuxfoundation.org>
> +
> +There are a number of atomic_t usages in the kernel where atomic_t api
> +is used strictly for counting sequence numbers and other statistical
> +counters and not for managing object lifetime.

You start by describing why this was introduced.  I think rather, you
should start by describing what this is.  You can compare and contrast
it with atomic_t later.  Also, I don't think it's necessary to describe
its implementation in this document.  This document should explain to
someone why they want to use this.

> +Read interface
> +--------------
> +
> +Reads and returns the current value. ::
> +
> +        seqnum32_read() --> atomic_read()
> +        seqnum64_read() --> atomic64_read()
> +
> +Increment interface
> +-------------------
> +
> +Increments sequence number and doesn't return the new value. ::
> +
> +        seqnum32_inc() --> atomic_inc()
> +        seqnum64_inc() --> atomic64_inc()

That seems odd to me.  For many things, I want to know what the
sequence number was incremented to.  Obviously seqnum_inc(); followed
by seqnum_read(); is racy.

Do we really want to be explicit about seqnum32 being 32-bit?
I'd be inclined to have seqnum/seqnum64 instead of seqnum32/seqnum64.

> +static inline int seqnum32_read(const struct seqnum32 *seq)
> +{
> +	return atomic_read(&seq->seqnum);
> +}
> +
> +/*
> + * seqnum32_set() - set seqnum value
> + * @seq: struct seqnum32 pointer
> + * @val: new value to set
> + *
> + */
> +static inline void
> +seqnum32_set(struct seqnum32 *seq, int val)

You have some odd formatting like the above line split.

> +static inline void seqnum64_dec(
> +				struct seqnum64 *seq)

That one is particularly weird.

