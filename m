Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA22AEB10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKKIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKKIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB31C0613D1;
        Wed, 11 Nov 2020 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMcX4YoeA2URPCcSaoYxor19bUOpdGTUmKeWjsFHix8=; b=DYo/yKDygVOiv4/qWNH8TtJh9d
        n6w3SW09VvRippFHmPsyydM9v5FJFGVliYy7xfpqOqtoI82bnfGhHTXmD/f+NbZkhuue47O+/vut+
        yIMAJa+tDUc6u2DWkb1HytwnWJI2ajk0nGS36DO7yr3jB2twKOtg0F8XrIfm8ZD13J6ltlv3yAGHY
        N6Vykc+k3WuJb5spkZLJxWqbJsuHzwWWCxSG4owguaxHsF7q3FYjMzTwknGbBu5U2QUVHAvWbWjQk
        Ca9/PwHaYu0n+cJBzMCr8NiG2pxy+TXNiz6CO1etg/RYyq2n16iAe7GaMQvfC4cNgg5QY5XkrqU/M
        Je9cLWOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclPW-0007Ao-9x; Wed, 11 Nov 2020 08:23:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D019305C16;
        Wed, 11 Nov 2020 09:23:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A0F72B85A2BB; Wed, 11 Nov 2020 09:23:21 +0100 (CET)
Date:   Wed, 11 Nov 2020 09:23:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201111082320.GR2611@hirez.programming.kicks-ass.net>
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

> + * The interface provides:
> + * seqnum32 & seqnum64 functions:
> + *	initialization
> + *	set
> + *	read
> + *	increment and no return
> + *	decrement and no return

NAK, this is batshit insane again. If you want a sequence number, the
one and _ONLY_ primitive you want to expose is inc_return.

No set, no read, no inc, and most certainly, not dec.
