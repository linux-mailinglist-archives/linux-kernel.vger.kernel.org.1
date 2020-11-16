Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6005F2B5376
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgKPVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgKPVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:11 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00BFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:11:09 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y78so9903247vsy.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9qQQsRnsWVAqLHH3ytfRUmgawjh1Ra4odXLB1eIRlA=;
        b=m8hxlLr8H3hNcrtUHu/X2dST+yw6MXfClMiduM6rwb3vnOAcMFRSY4vKaoZf7s6TAq
         4bIXl85oqOU63eCMmLMiF0BL+onRvZo7cRLHMCLMIzkUfTS0caSz+/vmBTVMUtLfsNic
         dLN4js5bH9Vaa3lox8SoZFYUaK59jiMQwN5qtsdeknTcKJT5bTZjn1tYbbYgEgxWlrkm
         S/gU7ab7x4/UryT/3Hq9DAgoGSbJHCRyUUTm5OYRpkflz3T5ptTIyeRzflCAxiH7B991
         O+ijjaBJC+oBfHUbS9oPSu5hcmWE3ihFKLf1j2QNPb72l8Vp4Wcjmrhz2UH7OfnrNU5G
         iPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9qQQsRnsWVAqLHH3ytfRUmgawjh1Ra4odXLB1eIRlA=;
        b=rP+KnxC7fsNYv1dfBx91xo9fxSQJQAY7P2Uu0bgIxYdTOCfDQXq1A9TjLQUUfqRE2j
         p1H1sZUPlYRpj9O8xRpUzE5P6Nmtg1YcI1CJTSLO0V+E5DgwDQsQ23EkrNYU0SXgXXDi
         +LKm95t93+i0IlJAtfQlclM17/1wLlp4Xmu3M8B18x9WNGmomiUHyvuqXZ6MPsClSGJp
         9BqXnuAT4c8UiZA8aeAZ8OLV7FZPYpks1LiMYbv5Rd6Ne+KlhCshJhBP9zIdHGbusLlm
         KNFzojIIgE81jU02CUOCFLpoAmod/+R6eXcDOJZG8BIyhoHCvF2RFWtRGAvqVYsSKZAe
         TH+A==
X-Gm-Message-State: AOAM532KMG456SwrwF6TF7lN9hfux7BbzRD4oZvW9VqxWGLBgXuEsj+v
        SMCZGGMoPZftaDXRQGEOIQMRYkzUcov0OzjYyR78bw==
X-Google-Smtp-Source: ABdhPJxnFSP2v7a06YNbl7pPhtCHK8tah2pGtUitEUY4kXPTuNS2mOhfvEIqhUbBTuuYDLrYRMi0KBlGjDmLw0MxLnw=
X-Received: by 2002:a67:1783:: with SMTP id 125mr2689790vsx.36.1605561068598;
 Mon, 16 Nov 2020 13:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20201113183414.1446671-1-samitolvanen@google.com>
 <20201116113931.2b60a191@gandalf.local.home> <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
 <20201116153834.57ace64e@gandalf.local.home>
In-Reply-To: <20201116153834.57ace64e@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 Nov 2020 13:10:57 -0800
Message-ID: <CABCJKufdFmoEEmx1-P_0d6vE6TOoDwJ43mq8eCQNQZ7rb0PxPQ@mail.gmail.com>
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 16 Nov 2020 12:10:10 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > On Mon, Nov 16, 2020 at 8:39 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 10:34:14 -0800
> > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > > my_tramp[12]? are declared as global functions in C, but they are not
> > > > marked global in the inline assembly definition. This mismatch confuses
> > > > Clang's Control-Flow Integrity checking. Fix the definitions by adding
> > > > .globl.
> > > >
> > >
> > > Actually, since that function is not really global, would it work if you
> > > removed the "extern" from the my_tramp declaration?
> >
> > Unfortunately not, removing the "extern" doesn't seem to change anything.
> >
> > > In other words, is there a way to tell C that a function is declared in an
> > > inline assembly block?
> >
> > I'm not sure if there's a way to tell C that a static function is
> > declared in inline assembly. At least I couldn't find a way that would
> > make the compiler happy.
>
> I'm trying to see the warning. What option makes clang trigger a warning on
> this?

Clang doesn't warn about this as we're building a module, it just
generates a reference to a non-existing global "my_tramp" symbol,
because the one defined in inline assembly has a local binding:

$ readelf --symbols --wide ftrace-direct.lto.o | grep my_tramp
    16: 0000000000000000    13 FUNC    LOCAL  DEFAULT    1 my_tramp
    33: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND my_tramp
    42: 0000000000000000     8 FUNC    GLOBAL HIDDEN     8 my_tramp.cfi_jt

This would prevent the module from loading, which modpost catches:

ERROR: modpost: "my_tramp" [samples/ftrace/ftrace-direct.ko] undefined!

> From user space, I'm just using the following file:

As this error happens only with Control-Flow Integrity, we need to
take the address of the "test" function to force the compiler to
generate a jump table entry for it. Here's a slightly tweaked
stand-alone reproducer:

https://godbolt.org/z/GnzjE4

Sami
