Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9338282F16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 05:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJEDls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 23:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJEDls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 23:41:48 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F92207F7;
        Mon,  5 Oct 2020 03:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601869308;
        bh=vgyk5ypX915tVD4vhCLypoGHnjjpPzUVAZJByu6lzog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vG4Xni21hbDZBADEV2O44raKRMyUZ/+zn/tbA5aZeZ6Mu+qCjxIlWWR953RPOKD1D
         PNPg+h4V7wyTCT54LDj60KW6X6bKqCZjv3cv0AX6ZMY9XabTxtbUQ2Cx0LIncByKDN
         bmKrcAYJ/V1nbYwCpTV736nPdoraSGtvdj3uylqM=
Date:   Mon, 5 Oct 2020 12:41:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] objtool: x86 instruction decoder and big
 endian cross compiles
Message-Id: <20201005124141.6a523ef633248a1eefd724d3@kernel.org>
In-Reply-To: <20201002151841.4ojt45mtcpkylvdq@treble>
References: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
        <patch-2.thread-6ec90b.git-f1af53789d02.your-ad-here.call-01601502173-ext-7769@work.hours>
        <20201002151841.4ojt45mtcpkylvdq@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 10:18:41 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Oct 01, 2020 at 12:17:25AM +0200, Vasily Gorbik wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > Currently objtool seems to be the only tool from build tools needed
> > which breaks x86 cross compilation on big endian systems. Make the x86
> > instruction decoder of the objtool usable on big endian machines.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Since this changes the decoder (which is shared with the kernel), please
> prefix the subject with "x86/insn:" instead of "objtool".

Thanks for pointing it.

> 
> This patch is a bit ugly, but I don't necessarily have a better idea.
> 
> Masami?

Yeah, agreed. Maybe we can split that part in different header, but
that makes it more ugly. And code itself looks good to me.
(I like insn_field_set() idea :) )

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
