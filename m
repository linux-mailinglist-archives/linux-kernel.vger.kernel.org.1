Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5228CB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgJMKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgJMKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:11:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36CC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:11:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so20286563edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=haoOXCnUClmCMszLSKymJ6r/6Isw0jOjGMpIS4DuvU8=;
        b=dzbJs+d76xcRDH6LEhc6rRMbD/eR5c6TeapOLjHOn3pVvAmQDWRTs8TYLie2gWLUgZ
         S5t99qg/KWe2jUCP/3vKPMdlMtZ/y0zbhD2eLyuFutxWAoKsbdLXA+p4kungNJErYCSN
         eojaHdpNt8k9WEMxfv5+yXV9Xt2w2qMtbZCTj7myDufp9lEplmpUF2si929WyUUKuyHL
         301z9GUPjtLC5HQ9AZNDSvtKvCJ2/m6S/yBOkY8JMTsU8Ly0deG56W+4jW8UCDrZQp6I
         m55xbNiR/t1XAyL4iPyA21pkBCuv2Uu+RDN+ltxoEB5v4+E7zQOREcOgX3gSZCWnYBSw
         9A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=haoOXCnUClmCMszLSKymJ6r/6Isw0jOjGMpIS4DuvU8=;
        b=tQjd1m6VoPqUWWdwM5IIo2Gp2rkDWQaH81lHn/9hfhL8LIyeo2RdwzvwS2sHXcAazZ
         Ssf/1NfU9BZtmCeClKIYgw0G1wS5DDqKuXwfK3k0+SKmNbGveHu3hXO+Amx/engOVBHp
         iqe1iGIZ49NzjP6FvewtCmZHN7pNgrYDLdqW87p5z+sms6Hx6Bw2FO9hRfFjSmEhYY52
         KfDuhS/KJQATfOcmO7Fw8JEGQndIx1yFSstwNLY9jp5bRphU7LKBIxxzh43m0dPpWqSB
         fXQw8MPCvqzRLuOuaX1fNEDovguufft4t0oQ1CfwMJThkCfinjCgjByEgaP2RgBDg5Rb
         bqNQ==
X-Gm-Message-State: AOAM532KWN7QAHU1AHCYQFWwWuU4MP7/r9yLZ0aBl0Dp0Eiz1OHFZza1
        8u7zTskuCiPmUsD54xiIUeI=
X-Google-Smtp-Source: ABdhPJwGW1eiE6R3L0LnLEfwHbziRSUQKbt4ydqwio8lGOddJapSkscEJ+gB2Beg0p2w2ZiKwD3ltw==
X-Received: by 2002:aa7:dcd6:: with SMTP id w22mr19150554edu.378.1602583858870;
        Tue, 13 Oct 2020 03:10:58 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id k21sm11991408edv.31.2020.10.13.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:10:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 13 Oct 2020 12:10:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [GIT PULL] objtool changes for v5.10
Message-ID: <20201013101056.GA3933713@gmail.com>
References: <20201013082625.GA775379@gmail.com>
 <20201013204312.6052157d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013204312.6052157d@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Tue, 13 Oct 2020 10:26:25 +0200 Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Ilie Halip (1):
> >       objtool: Ignore unreachable trap after call to noreturn functions
> > 
> > Jann Horn (1):
> >       objtool: Permit __kasan_check_{read,write} under UACCESS
> > 
> > Julien Thierry (16):
> >       objtool: Move object file loading out of check()
> >       objtool: Move ORC logic out of check()
> >       objtool: Skip ORC entry creation for non-text sections
> >       objtool: Define 'struct orc_entry' only when needed
> >       objtool: Group headers to check in a single list
> >       objtool: Make sync-check consider the target architecture
> >       objtool: Move macros describing structures to arch-dependent code
> >       objtool: Abstract alternative special case handling
> >       objtool: Make relocation in alternative handling arch dependent
> >       objtool: Rename frame.h -> objtool.h
> >       objtool: Only include valid definitions depending on source file type
> >       objtool: Make unwind hint definitions available to other architectures
> >       objtool: Decode unwind hint register depending on architecture
> >       objtool: Remove useless tests before save_reg()
> >       objtool: Ignore unreachable fake jumps
> >       objtool: Handle calling non-function symbols in other sections
> > 
> > Raphael Gault (1):
> >       objtool: Refactor jump table code to support other architectures
> > 
> > Vasily Gorbik (1):
> >       objtool: Allow nested externs to enable BUILD_BUG()
> 
> This seems to be missing
> 
> https://lore.kernel.org/lkml/patch-1.thread-251403.git-2514037e9477.your-ad-here.call-01602244460-ext-7088@work.hours/
> 
> or did that get sent in a previous pull request?

No, that fix is still missing, thanks for the reminder. I overlooked it 
thinking that it's a tooling patch - but this needs to be paired with:

  2486baae2cf6: ("objtool: Allow nested externs to enable BUILD_BUG()")

I'll send a v2 pull request in an hour or two.

Thanks,

	Ingo

