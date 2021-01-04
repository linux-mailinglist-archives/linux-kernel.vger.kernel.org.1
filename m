Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B62E9D39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbhADSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbhADSlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:41:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B670C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 10:40:56 -0800 (PST)
Received: from zn.tnic (p200300ec2f086c00477cccdca46ad35a.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6c00:477c:ccdc:a46a:d35a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A03861EC0300;
        Mon,  4 Jan 2021 19:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609785654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1IrJEPqy47tJ8tj13J9znmWrNyKbcOQeWIwH/pLaAy0=;
        b=b98vkCW4lphpmXn7AAy2SipqYXyWBfOrvGLU2niEkEwW7CcI8W+pW0TbGiPX8dcZcBH/D5
        52Ogk5MxFviRL0Fz8YnWa1TmZDkQZh/En3jO5yd/pgPHiLVR7XlpnWkx0i1fWgDG+wbtlN
        kWOpuUzO4C+DDb4ooWXd0+hsULCQOdM=
Date:   Mon, 4 Jan 2021 19:40:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, x86@kernel.org
Subject: Re: [PATCH -tip v2] x86/kprobes: Do not decode opcode in
 resume_execution()
Message-ID: <20210104184051.GG32151@zn.tnic>
References: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
 <160830072561.349576.3014979564448023213.stgit@devnote2>
 <20201231160923.GB4504@zn.tnic>
 <20210104124558.7c89fb6fa305507c098f0d85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104124558.7c89fb6fa305507c098f0d85@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 12:45:58PM +0900, Masami Hiramatsu wrote:
> Hrm, I meant setting the flags used in the resume_execution() afterwards.
> Since the instruction itself (not only opcode but also oprands) was
> also analyzed in other places, so I like the set_resume_flags() for it.

Your call but I still think that set_resume_flags() is misleading. You
even have in the comment above it:

"Analyze the opcode and set resume flags."

so it is doing some insn analysis and setting flags as a result.

But I won't insist - you're the one who's going to be staring at that
code.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
