Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368101B067F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDTKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:25:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JpkWKCLdUo/1wRG/R5CCW8O5RQZJeGF0mmdsvEx6E0k=; b=LE/ela+FhpjJCc2gpLHTwODAf6
        6hDWzzjFmtaU2Vqv4nFUl/RURvFZlko7gdQWjYeDPKurAAQR6cZFw6kjSXEyM0anhRq2Ks/C7wALT
        IOLPyFZBAPf79sDftoOavDJ3nIXuQj5jjTdva/+lcssXuJVGDuz2YTP6AX7rrttbSQ0MuivYKPS2E
        obXLl+YgF6ef2xBYwOK2Cu8TjAGCO0/ug2XsSbOv9hGn6wEMinXzZmrrIuT6Hcjx8XOeor5r4uTYQ
        QW27Z5EHMvofdVLudaMIU4EgZMhu1t9J9uVukIPR+3+THsYnyskyGjvLXqU0nwfJW1lODBZ08smmj
        H6co1nzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQTcP-000602-W9; Mon, 20 Apr 2020 10:25:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 658713012D8;
        Mon, 20 Apr 2020 12:25:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 215BC2B4E73E6; Mon, 20 Apr 2020 12:25:35 +0200 (CEST)
Date:   Mon, 20 Apr 2020 12:25:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
Message-ID: <20200420102535.GB20696@hirez.programming.kicks-ass.net>
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419203137.214111265@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:31:37PM +0200, Thomas Gleixner wrote:
> The per-CPU tlbstate contains sensitive information which should be really
> only accessible in core code. It is exported to modules because some inline
> functions which are required by KVM need access to it.
> 
> The following series creates regular exported functions for the few things
> which are needed by KVM and hides the struct definition and some low level
> helpers from modules.
> 
> The series is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel x86/tlb
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
