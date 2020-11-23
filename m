Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE82C1109
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgKWQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgKWQsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:48:17 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A3520717;
        Mon, 23 Nov 2020 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606150096;
        bh=kA8c3OfIwdiQgZa+jhGYvbIcKRQ4uxazZENPSYYhqxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJKB6HEhoJU2IsKoFXLnIZYVF5vYv4ScRMhB6CR9MZ9Ny/zp9CPtl+iUna0DZETg8
         Vn9lHtG71fup6t0eEEnO/ZkDT6DWvKF6yOFCIpwomLAe+u7AaqhU1tMHK2/5NYJ3pJ
         YorfxbjuAvXdBFC5FJ1vcJUgQCRxFcItrPvqa71E=
Date:   Mon, 23 Nov 2020 16:48:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
Message-ID: <20201123164811.GA11494@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-6-will@kernel.org>
 <CAHk-=wghWFQCW83Xr16C3q+y5xZNM9frH4V9AqauedMEJ1V4wQ@mail.gmail.com>
 <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:31:09AM -0800, Linus Torvalds wrote:
> Oh - wait.
> 
> Not ack.
> 
> Not because this is wrong, but because I think you should remove the
> start/end arguments here too.
> 
> The _only_ thing they were used for was that "fullmm" flag, afaik. So
> now they no longer make sense.
> 
> Hmm?

Oh nice, well spotted. I'll drop them for v2.

Cheers,

Will
