Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8294D2848AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJFIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:35:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gWs/lPE2i/OF/DrPdvnJHXbiH0OnG2x6H7UkOFuk3vw=; b=Wp5R9pGnwR6MqXSTvsoSJGAp3X
        Wes0zsq6DJzOqzpjw+W+DDDqs1w82SHDjdYsFbPSXtcLm0B3lASHEh6itZTwTnVWI/Pq3v/Fiyv/O
        IT42zlvS7SxlQ7/pcpxR46oQTQ+KwrcyAUOO0lvD+KYk1gjLrTpZl1D0DmKZ2cEG8vNvhWuBvgwQL
        fTusFM+SIffRyRzmqLSjHstDYyFbg0SobobZCF3Xv5/z9wAIsohzjFNymahe71Y3e/0bhYI/50muf
        5EXkZlxedkoRx7M9lgoSogELNDyaT9TkgLxZL3U92W4kwim4py8MJCztpSoxIYdcmcerzJoc/+kb3
        yMvbLIbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPiQK-0008Mh-3I; Tue, 06 Oct 2020 08:34:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEACA300B22;
        Tue,  6 Oct 2020 10:34:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7252C28B30F6A; Tue,  6 Oct 2020 10:34:15 +0200 (CEST)
Date:   Tue, 6 Oct 2020 10:34:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 2/2] x86/entry/32: Remove leftover macros after
 stackprotector cleanups
Message-ID: <20201006083415.GO2628@hirez.programming.kicks-ass.net>
References: <cover.1601925251.git.luto@kernel.org>
 <1469babd36eb342aaa5e274a73a49293fad75272.1601925251.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469babd36eb342aaa5e274a73a49293fad75272.1601925251.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:30:04PM -0700, Andy Lutomirski wrote:
>  .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
>  	cld
>  .if \skip_gs == 0
> -	PUSH_GS
> +	pushl	$0
>  .endif
>  	pushl	%fs
>  

Is there a good reason not to just push gs into it? It might be nice if
pt_regs is complete.
