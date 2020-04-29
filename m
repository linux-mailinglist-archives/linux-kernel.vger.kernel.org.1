Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5279A1BE6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD2SwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:52:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4507BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FreQTZyNiQbmio5nHGLGF2May2I7BgbfYH3zJe2eCY8=; b=pYfMbweJoOSbYYIWpbnXDRvmNL
        b9IF6Znq+xvAKwoZPExCr3Vm7SxR6MjaUkA6TTJL8vMPu+FzYO5tyy9/EMNu4cgTfZVFZzpydqnF6
        tRlB1QbjXxKmOgsPYAyp9Igsfhj8QL5ridRkiaP3M4FxK/LzarDHdCrLcy6wy3TAcMR4bpvhmw1QA
        uBbHEoaT6VjEgEPu4Kk5WC8lubBpMDACKQT9pRGLwDXShO3f0GJrhXPLBubiemPuqUh6kV5R2HEkk
        kTOwjA6Uu5NXlON5rogOBnhp+equjWUogDI5Ley9TFAIMnWUCtFhrePKXQl4TBfAnmUofC2tN5y+m
        LKiKwVpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTroJ-0008Qq-9B; Wed, 29 Apr 2020 18:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDF6D300130;
        Wed, 29 Apr 2020 20:51:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E00EE20BD8FF7; Wed, 29 Apr 2020 20:51:51 +0200 (CEST)
Date:   Wed, 29 Apr 2020 20:51:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>, Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200429185151.GO13592@hirez.programming.kicks-ass.net>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200429161747.GS30814@suse.de>
 <20200429162026.GT30814@suse.de>
 <20200429125245.5a804f62@gandalf.local.home>
 <951556503.76104.1588181386082.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951556503.76104.1588181386082.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Basically, it's a big bitmask, where each bit represents a possible process
> > id (can be 2 gigs if we allow all positive ints!).
> 
> I think you mean 2 giga-bit, for 256MB worth of memory, right ?
> 
> And AFAIU the PID_MAX_LIMIT is at a maximum of 4 million PIDs in
> include/linux/threads.h, which means 512MB worth of memory for a
> bitmask.

PID space is limited to 30 bits per FUTEX_TID_MASK, still, stupid large
:-)
