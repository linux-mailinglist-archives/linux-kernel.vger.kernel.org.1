Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532591C0B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 02:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgEAAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 20:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEAAkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:40:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A59C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:40:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so2797989lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sRFJfZwHnsJQqFJepe+LvPqS40H3J51FnSnbFsYaAJM=;
        b=AvUgqN7PB/2m6j6r3ChFqht9nBGFMbV8AKa9u30SyVlVrTUy+Tv1TOIg+df2atuDm9
         mrQr9/kg7XzvTBlUGO0QByBQRaSsjKRXNdddPP7Y9Z8zjn9Nh1TKQSTFhhdcbHFIGZAm
         23fUYndzjvvhniZu8dhlkJL4EDHoYqfSv1iW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sRFJfZwHnsJQqFJepe+LvPqS40H3J51FnSnbFsYaAJM=;
        b=hYOH9Tm5u6lBXd53ot5IKTZFkP//ikh/jGJF2EHv2YTBrEighdJXCOt8WPzjgjl+xp
         +G9gCuoY7bXlpW7QXzf7O/c8HvhdLeH4TnOIhUbbEDbPbp2r0UIR7m2mzofwYF6RAaPw
         vfuK0as242Rngu6cIy31OWkgAi5mRaCxGDK+EMPsN1NCLc3uxwTvoDmrwbVF9+7eim8d
         EuYtORzvCpL1eQ+5t1fYNcmCDZigV/3Pv25++8va9IZt4dn4Pqg2DLVhGr7mDo0oL9em
         VglLTMToX3iJz6kte+R0VVFcFWyXNPqtUz6K49Tp9ezj9MhdvEOXHiwfXFfXdSeCjhdH
         lCuA==
X-Gm-Message-State: AGi0PuYIV7FqsxwqGCMRsnci1ndUPctdbDKuxWXwZf4ty2ntggT3djP0
        ri1cjZfcEqIN1dhQyy2FqTSz+QTOOjc=
X-Google-Smtp-Source: APiQypJZzW3czjSpgLtrvhayHcYwjJ8IepcX1vk8L0GQqqvG1sppDQYvz02PGcnLYPJf/mqmLF7xIQ==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr818589lfh.87.1588293604399;
        Thu, 30 Apr 2020 17:40:04 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p14sm970206lfe.87.2020.04.30.17.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:40:03 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w20so1351071ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:40:02 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr886854ljg.204.1588293602471;
 Thu, 30 Apr 2020 17:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
In-Reply-To: <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 17:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
Message-ID: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:23 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> > But anyway, I don't hate something like "copy_to_user_fallible()"
> > conceptually. The naming needs to be fixed, in that "user" can always
> > take a fault, so it's the _source_ that can fault, not the "user"
> > part.
>
> I don=E2=80=99t like this.  =E2=80=9Cuser=E2=80=9D already implied that b=
asically anything can be wrong with the memory

Maybe I didn't explain.

"user" already implies faulting. We agree.

And since we by definition cannot know what the user has mapped into
user space, *every* normal copy_to_user() has to be able to handle
whatever faults that throws at us.

The reason I dislike "copy_to_user_fallible()" is that the user side
already has that 'fallible".

If it's the _source_ being "fallible" (it really needs a better name -
I will not call it just "f") then it should be "copy_f_to_user()".

That would be ok.

So "copy_f_to_user()" makes sense. But "copy_to_user_f()" does not.
That puts the "f" on the "user", which we already know can fault.

See what I want in the name? I want the name to say which side can
cause problems!

If you are copying memory from some f source, it must not be
"copy_safe()". That doesn't say if the _source_ is f, or the
destination is f.

So "copy_to_f()" makes sense (we don't say "copy_kernel_to_user()" -
the "normal" case is silent), and "copy_from_f()" makes sense.
"copy_in_f()" makes sense too.

But not this "randomly copy some randomly f memory area that I don't
know if it's the source or the destination".

Sometimes you may then use a common implementation for the different
directions - if that works on the architecture.

For example, "copy_to_user()" and "copy_from_user()" on x86 both end
up internally using a shared "copy_user_generic()" implementation. I
wish that wasn't the case (when I asked for what was to become
STAC/CLAC, I asked for one that could determine which direction of a
"rep movs" could touch user space), but it so happens that the
implementations end up being symmetric on x86.

But that's a pure implementation issue, and it very much is not going
to be true in general, and it shouldn't be exposed to users as such
(and we obviously don't).

                Linus
