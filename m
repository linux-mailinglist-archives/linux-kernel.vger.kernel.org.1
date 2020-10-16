Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F97290205
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405997AbgJPJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394545AbgJPJhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:37:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD6C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n4yntp56hTwz5NkrDIzMv3NkULA7PrzNmrNXwNVmCHo=; b=DIVMzKpK3EpHN8VYg4/a77d4JI
        24U8EBhKJHOfuX6bWSmnFHhqPQ+9YYaeiRRD9ofzAOro+O3NtpP5pe4vQlq5yr/HkoffBfZU4OBMp
        BxRMmYM+ZmhoIIqSHo8hQuHyfXxR6felXuB17LWtDez1f4bPAeciT19xSUr58v9WDrnw/Nn+6F+ZK
        duHUjNzluiCBibYo1WW3+0o2xepWKEIrJ74dZyUn21if2bPQbXHLI0xPv7uTDHdjCdyorzdlOeWLa
        h6rS0QdN9W+Sj6heQDzi+1bZgYh30K7aQDlaCAXZbN9GJ4CMIdL5d75EF6yUlk99lbmcIeKrKGvRr
        08WL5FoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTMAw-0002rN-G8; Fri, 16 Oct 2020 09:37:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E209630015A;
        Fri, 16 Oct 2020 11:37:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C79422019D2CA; Fri, 16 Oct 2020 11:37:24 +0200 (CEST)
Date:   Fri, 16 Oct 2020 11:37:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Message-ID: <20201016093724.GH2611@hirez.programming.kicks-ass.net>
References: <20201015161216.1563600-1-irogers@google.com>
 <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:34:57PM -0700, hpa@zytor.com wrote:
> Wait, what?
> 
> You are taking about x86-specific code, and on x86 unaligned memory
> accesses are supported, well-defined, and ubiquitous. 

Objtool uses this x86 instruction decoder, people are cross-buildling
objtool to cross-build x86 kernels.

So it's entirely possible to run the x86 insn decode on BE RISC, which
very much doesn't like unaligned loads.
