Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDA2B53CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgKPV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:27:59 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10283C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:27:59 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id l22so9958059vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwGz4nO+cm59nPX+1nCEN39WoYWpvBzcZZIZEOPDIWA=;
        b=WWFLjZCEFXGX7nlWQl0XMopyn+eK+0oe8HZcFqey62EqTnLU9iplnYPU1lorxuC3gA
         HFHuQvZWK2+H6lYArmzCQcRrFiIq8fKwj4zAGe2wZyKU4OH8SgLitvaF70dJPG7wkVgE
         x2AG0J6vEurQeQ8of0VpuFo4CUsOTdgtAkLRcr2MOaUpT1Pj02Zb2uiachTTvWJ6jVSQ
         MwA2dTPbYm6S0RJuvJngvlBz/EbYXn1DEnSQ5QC9xx+f4+cHjCZAqyAA2s5tVckKBPKT
         +jp0AUTmo4AFGZK/HcxbVtRgUbQxxqh6crn4xpQIKNd6MrXlr0Zy1Jvor/U+mdNJLbpN
         ADAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwGz4nO+cm59nPX+1nCEN39WoYWpvBzcZZIZEOPDIWA=;
        b=OnISJgPD9wP54hD11oJny+Lu0kqQtwxMq9c8IkpWWX+2e0fC63Msbip+Cp7i6nfO15
         ZMRnTDreAYspmY10P9DhJpVLdxasdGM7+TChl+zWZ9l7255kJK7Tx6BEsam6ncM9o0bM
         FAvetmqQJ4D0oD7Ze+fCYLeYFg6hTDl+F0MIR6x/cSPLVDa5etlE6vzLULYz4nxrusnj
         Gn90EK+siX6qTfxYSVWXgZey0n1bblG25NfZdOzG75hpfQd6YCR3M5/RH/qbEdC7FZEI
         hqgA3F3R7y0jblToxDksq3PxKaMPZNtTiwurAB7KBe/dP06/9L3mcfCq3oDMlyK4hiiN
         4BIA==
X-Gm-Message-State: AOAM530OPB9WwMeSw+jdshX7LyqLY55A/WUMK0VWEpFZL+nmvzIIvJWC
        9sydavIhA4bewCa4z9t9ci65cjl11Qv9AZMAD0ZfYw==
X-Google-Smtp-Source: ABdhPJxD0wEewB35Q1kJPwqNImnMrI54oVrlA24LDOT161npZGqN8UpJNB5Vz2vjX0SQ8sSGozZJilo5ensS7fojXjg=
X-Received: by 2002:a05:6102:448:: with SMTP id e8mr9656538vsq.14.1605562078079;
 Mon, 16 Nov 2020 13:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20201113183414.1446671-1-samitolvanen@google.com>
 <20201116113931.2b60a191@gandalf.local.home> <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
 <20201116153834.57ace64e@gandalf.local.home> <CABCJKufdFmoEEmx1-P_0d6vE6TOoDwJ43mq8eCQNQZ7rb0PxPQ@mail.gmail.com>
 <20201116161819.040408dd@gandalf.local.home>
In-Reply-To: <20201116161819.040408dd@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 Nov 2020 13:27:46 -0800
Message-ID: <CABCJKudT1vaoNNXjgduxzKJNiNCOWhCY3cq=xxi2rgJPQvYAag@mail.gmail.com>
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

On Mon, Nov 16, 2020 at 1:18 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 16 Nov 2020 13:10:57 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > Clang doesn't warn about this as we're building a module, it just
> > generates a reference to a non-existing global "my_tramp" symbol,
> > because the one defined in inline assembly has a local binding:
> >
> > $ readelf --symbols --wide ftrace-direct.lto.o | grep my_tramp
> >     16: 0000000000000000    13 FUNC    LOCAL  DEFAULT    1 my_tramp
> >     33: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND my_tramp
> >     42: 0000000000000000     8 FUNC    GLOBAL HIDDEN     8 my_tramp.cfi_jt
> >
> > This would prevent the module from loading, which modpost catches:
> >
> > ERROR: modpost: "my_tramp" [samples/ftrace/ftrace-direct.ko] undefined!
> >
> > > From user space, I'm just using the following file:
> >
> > As this error happens only with Control-Flow Integrity, we need to
> > take the address of the "test" function to force the compiler to
> > generate a jump table entry for it. Here's a slightly tweaked
> > stand-alone reproducer:
> >
> > https://godbolt.org/z/GnzjE4
>
> Thanks, we don't need to look more into this. It was mostly my curiosity to
> find a way to have the compiler know about a function declared statically
> in inline assembly. Maybe I'm asking for too much ;-)
>
> I'll take your original patch. Does it need to go to stable, or is this not
> that big of an issue to allow it to be added in the next merge window?

Thanks! This is definitely not a big issue, it just fixes the
allyesconfig build with CFI, and it's not needed in -stable.

Sami
