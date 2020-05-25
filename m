Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA321E11A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbgEYPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403996AbgEYPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:25:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67Pp2K07rsDEiwyIQepVcEcJzzewNU6na93Mu3juojQ=; b=g6KUhPZ9roVqd5YXwqlKVXub/P
        z7RW5yNuga22tjhq5muAT9FDw1qKg5X3prJDbADcUS9GkgPXAzUeWM20PNVtMcUXGfDMrfmLoEe3D
        NOK0lHQdVKvcbC7/5M/NDs4aJ1vzdQNnpp6KFecz2M5L3GPGiQyvRtY2xPrQpmM9vQoPZqFfDjJ0W
        E5cqqs5hLwXR/6sv2Zw2Qx9NrQAf1cTBZZyL1AWqAaiyYXzV0phNXNLAbspLg/4QUiwkwrMNdE86B
        encocoidsL60WB1n2kWVgIv2w3v9cgZPCGUZQQRuQaWb2E3q+ozhSKtMyJUGEm9uphUzzZD/HwZgb
        QVFmM6qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdEyd-0005sN-Rz; Mon, 25 May 2020 15:25:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A09793011E6;
        Mon, 25 May 2020 17:25:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9280C2389FE1F; Mon, 25 May 2020 17:25:17 +0200 (CEST)
Date:   Mon, 25 May 2020 17:25:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [RFC PATCH 0/5] x86/hw_breakpoint: protects more cpu entry data
Message-ID: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
References: <20200525145102.122557-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525145102.122557-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:50:57PM +0000, Lai Jiangshan wrote:
> Hello
> 
> The patchset is based on (tag: entry-v9-the-rest, tglx-devel/x86/entry).
> And it is complement of 3ea11ac991d
> ("x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area").
> 
> After reading the code, we can see that more data needs to be protected
> against hw_breakpoint, otherwise it may cause
> dangerous/recursive/unwanted #DB.
> 
> 
> Lai Jiangshan (5):
>   x86/hw_breakpoint: add within_area() to check data breakpoints
>   x86/hw_breakpoint: Prevent data breakpoints on direct GDT
>   x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw

I think we can actually get rid of that #DB IST stack frobbing, also see
patches linked below.

>   x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask

Should we disallow the full structure just to be sure?

>   x86/hw_breakpoint: Prevent data breakpoints on debug_idt_table

That's going away, see:

https://lkml.kernel.org/r/20200522204738.645043059@infradead.org

But yes, nice!

