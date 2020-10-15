Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D3728FB00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgJOWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgJOWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:01:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:01:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q9so1066785iow.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mzwJk/1YT7Qs2X5Zd056Q/R8AqhXJAI5UxwwaHjH+vs=;
        b=Q5v+MJP2jA3lqaEUWV2NI39c+fTXkKRxXA+hTRgHLFAMpYP1fl7MExAjahQSLh6u3N
         40GQxX+JMymhrdr7lsMKEWuatZHH59WXDhKeZZ7UoIj2rgwKn3EtG3W3kx1wc7BLEZl/
         ar1Ku8iuHFIT2LAG1klKMDfTtZrvbTJrRXUJtWXkfYWpYb7peI3G/0QgLLAdqrlbbDyg
         /zj9KC6C4fOfQAFUF4lEMzcS2qgXEmoMEi1XlVDyIwMBi8AT8afeERnRlp5F061Y+aqE
         zVmPf8Qg8OucmbgmM897qdP//3vGX4QnOUhKGazUIllIx+RjXUVXT1tR6aE3m1goe1bl
         s6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mzwJk/1YT7Qs2X5Zd056Q/R8AqhXJAI5UxwwaHjH+vs=;
        b=XVpHAgP+QZQqTXubfbFRy+MCe8uMIXhVcmieJSgZQ6BVx2X+OGMZjphAMlioJOQS+f
         XzG+1FkAr7viNRzEpvph2aur3n73QaKeruxE0ZlLliAg9wFrVpKSHoUYAffivJaFN9rk
         Ap3DafNDjn1rObSPcVr5fmAGgxI+lbu49+07nvin0s4VKqCt6L2iKvDd8M2G21yjWsaA
         cpmTQPrCCLeg4Zp0XhgUQH35A1nOZiR/hzClotF4yv/SnPR+dMUWF25z0vIJ4Ja3RmV7
         SYjfULCadlNWM0eT+XuGmpB/A8pAUZ23Dfy9BgxXFSZl6v10LRsK1InvWuwSnds+hOaB
         Pwqg==
X-Gm-Message-State: AOAM5337LenwOmY6GF5PuVbeKYF4TW0P+0g8fPhdE0l96M3zeIii+jSr
        clvZSKWWNq+ZaAQGERnrMSs=
X-Google-Smtp-Source: ABdhPJzp2cRPxsz0xe8MujS2MyCbunZ+VNlSPfH65gbodnJhAtohIzXiCht/MsdsO8fASXTGiBvciQ==
X-Received: by 2002:a6b:1497:: with SMTP id 145mr205044iou.202.1602799286358;
        Thu, 15 Oct 2020 15:01:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h14sm267428ilc.38.2020.10.15.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:01:25 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 15 Oct 2020 18:01:23 -0400
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Message-ID: <20201015220123.GA919128@rani.riverdale.lan>
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
 <20201015181340.653004-1-nivedita@alum.mit.edu>
 <72958fd25e33490181b0df9413ec08b4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72958fd25e33490181b0df9413ec08b4@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:09:11PM +0000, David Laight wrote:
> From: Arvind Sankar
> > Sent: 15 October 2020 19:14
> > 
> > Be clear about @ptr vs the variable that @ptr points to, and add some
> > more details as to why the special barrier_data() macro is required.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  include/linux/compiler.h | 33 ++++++++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 93035d7fee0d..d8cee7c8968d 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -86,17 +86,28 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > 
> >  #ifndef barrier_data
> >  /*
> > - * This version is i.e. to prevent dead stores elimination on @ptr
> > - * where gcc and llvm may behave differently when otherwise using
> > - * normal barrier(): while gcc behavior gets along with a normal
> > - * barrier(), llvm needs an explicit input variable to be assumed
> > - * clobbered. The issue is as follows: while the inline asm might
> > - * access any memory it wants, the compiler could have fit all of
> > - * @ptr into memory registers instead, and since @ptr never escaped
> > - * from that, it proved that the inline asm wasn't touching any of
> > - * it. This version works well with both compilers, i.e. we're telling
> > - * the compiler that the inline asm absolutely may see the contents
> > - * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> > + * This version is to prevent dead stores elimination on @ptr where gcc and
> > + * llvm may behave differently when otherwise using normal barrier(): while gcc
> > + * behavior gets along with a normal barrier(), llvm needs an explicit input
> > + * variable to be assumed clobbered.
> > + *
> > + * Its primary use is in implementing memzero_explicit(), which is used for
> > + * clearing temporary data that may contain secrets.
> > + *
> > + * The issue is as follows: while the inline asm might access any memory it
> > + * wants, the compiler could have fit all of the variable that @ptr points to
> > + * into registers instead, and if @ptr never escaped from the function, it
> > + * proved that the inline asm wasn't touching any of it. gcc only eliminates
> > + * dead stores if the variable was actually allocated in registers, but llvm
> > + * reasons that the variable _could_ have been in registers, so the inline asm
> > + * can't reliably access it anyway, and eliminates dead stores even if the
> > + * variable is actually in memory.
> 
> I think I'd just say something like:
> 
> Although the compiler must assume a "memory" clobber may affect all
> memory, local variables (on stack) cannot actually be visible to the
> asm unless their address has been passed to an external function.
> So the compiler may assume such variables cannot be affected by
> a normal asm volatile(::"memory") barrier().
> Passing the address of the local variables to the asm barrier
> is enough to tell the compiler that the asm can 'see' the variables
> (and spill anything held in registers to the stack) so that
> the "memory" clobber has the expected effect.
> 
> This is necessary to get llvm to do a memset() of on-stack data
> at the end of a function to clear memory that contains secrets.
> 
> 	David

I think it's helpful to have the more detailed explanation about
register variables -- at first glance, it's a bit mystifying as to why
the compiler would think that the asm can't access the stack. Spilling
registers to the stack is actually an undesirable side-effect of the
workaround.
