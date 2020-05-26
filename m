Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947BB1B4C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgDVSAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgDVSAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:00:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90802076E;
        Wed, 22 Apr 2020 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587578447;
        bh=NABYNKvs9sdWR1s9Ukqb7xA7e+KXEGWr4qmakQtX2oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIWTCp0/uGUSMGuwWVLFng26QFFNEEyjpTIYnEYtTtH7rdtaX57uIzFs/BzvdR9ni
         ePP+N0LiLAOGVfPbD9BA0ZOSUWHgZJ8tEHTtYdx82R6CSL4NLvVuWj/VZ9123jk92Y
         AcNNFlBLukBMtR23rMiE1xDoXYGQUyefGhPfX8hc=
Date:   Wed, 22 Apr 2020 19:00:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200422180040.GC3121@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200421021453.198187-1-samitolvanen@google.com>
 <20200421021453.198187-2-samitolvanen@google.com>
 <202004221052.489CCFEBC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004221052.489CCFEBC@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:54:45AM -0700, Kees Cook wrote:
> On Mon, Apr 20, 2020 at 07:14:42PM -0700, Sami Tolvanen wrote:
> > +void scs_release(struct task_struct *tsk)
> > +{
> > +	void *s;
> > +
> > +	s = __scs_base(tsk);
> > +	if (!s)
> > +		return;
> > +
> > +	WARN_ON(scs_corrupted(tsk));
> > +
> 
> I'd like to have task_set_scs(tsk, NULL) retained here, to avoid need to
> depend on the released task memory getting scrubbed at a later time.

Hmm, doesn't it get zeroed almost immediately by kmem_cache_free() if
INIT_ON_FREE_DEFAULT_ON is set? That seems much better than special-casing
SCS, as there's a tonne of other useful stuff kicking around in the
task_struct and treating this specially feels odd to me.

Will
