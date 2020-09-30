Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911FB27EC43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgI3PUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgI3PUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:20:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601479200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJ2ag1Mmh5kTbyFCESLoQcAb1qiI9vhyzO9OqzkURbo=;
        b=dVqvwNDmi407ppMVxpRv2JwMlFUgYSRcdApMIU+M5lxxwuZu8odXbI5vh7OaoJZNaG6NBe
        pRAKctO2iXKNC9LKmnZQ9YBgxwmSDqMxSnfEUbgA+OxjqON0jpUKJqjPGcOsip0vPL6nEw
        t4clJUhiacl/laASkWeCrKnVrcebmU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-RTStyAFnN_KnrobJwcHY9g-1; Wed, 30 Sep 2020 11:19:58 -0400
X-MC-Unique: RTStyAFnN_KnrobJwcHY9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4BC80734F;
        Wed, 30 Sep 2020 15:19:56 +0000 (UTC)
Received: from treble (ovpn-120-207.rdu2.redhat.com [10.10.120.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B35C760DA0;
        Wed, 30 Sep 2020 15:19:53 +0000 (UTC)
Date:   Wed, 30 Sep 2020 10:19:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] objtool: x86 instruction decoder and big
 endian cross compiles
Message-ID: <20200930151951.wwsleh6m4buybqhf@treble>
References: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
 <cover.thread-ca645c.your-ad-here.call-01601468251-ext-3723@work.hours>
 <patch-1.thread-ca645c.git-a25fdca3bf6d.your-ad-here.call-01601468251-ext-3723@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch-1.thread-ca645c.git-a25fdca3bf6d.your-ad-here.call-01601468251-ext-3723@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:24:19PM +0200, Vasily Gorbik wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Make the x86 instruction decoder of the objtool usable on big endian
> machines. This is useful for compile tests on non x86, big endian
> hardware.
> 
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> [ gor: more endianness problems findings fixes / rebasing ]
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/x86/include/asm/insn.h       | 42 ++++++++++++++
>  arch/x86/lib/insn.c               | 95 +++++++++++++------------------
>  tools/arch/x86/include/asm/insn.h | 42 ++++++++++++++
>  tools/arch/x86/lib/insn.c         | 95 +++++++++++++------------------
>  tools/objtool/arch/x86/special.c  |  2 +-
>  tools/objtool/check.c             |  4 +-
>  tools/objtool/elf.c               | 34 ++++++-----
>  7 files changed, 188 insertions(+), 126 deletions(-)

Can the insn changes be done in a separate patch from the objtool
changes?

Also, 'Masami Hiramatsu <mhiramat@kernel.org>' should be on Cc for the
insn changes since he wrote the original code.

-- 
Josh

