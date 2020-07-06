Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CF215E34
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgGFSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgGFSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:21:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774DC061755;
        Mon,  6 Jul 2020 11:21:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so33782307ila.3;
        Mon, 06 Jul 2020 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0UyprzGOpJCrvSRMTeiKdKQODoWH/Ul9V8rM2fcjek=;
        b=NQxVWHcjXotZUs9osvV8QUiCAoR4tgGZHVto/QVWnE0/gvvZ/6BbHfRgDABY5x7aRH
         wEjq6u56xD5ttDRD+QN8gI96K4JYZ+1bTu6k3KxUAJLKV332WUUOmFkawijGXlCgzffl
         dWChdPB+z/ZSX+AAVk7SALZYVvlJkdKBlaYOWZPzhcbIFrZ0W3d/mhZGvngoEgbDi5bO
         1QbHKlFdAsfOeicqSqbieDFyV5R4mUNsaylwX0RbxLVQJa97thInsGJuUxMV8kCck8gb
         d4vPb6QR+LqA+viO/qYinJH/bc/4tx8y1OMMuWMfbgO3EvKr+Ct5SuStM2TGUulxYHr9
         3hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0UyprzGOpJCrvSRMTeiKdKQODoWH/Ul9V8rM2fcjek=;
        b=RgYcoUPvXeIgXvaC7wEbtAtNVHeh6zzTiNzPRBxhFI59GGdhlqbHizis7parSl9evI
         yI7znxlAke+tshstovj9rHBCXXYBqvWRYA3bbv2XnxlhQ38y0UEe3KvuDpjXIlrTrN+l
         6rCc9nRUBpJHwrtlQ3wG1kxK38KZk/eYbf2iBe8XE2JlkagyyQPhvz3Wvg2WCIO0vfkN
         Tri9aOpRNyTPowEL4ahGAGwRdCurIGHxparNoGYWwdjjf0vF3uHrqZ0YrQ3dywgtI6/R
         pFDA4N6jLMD/p96GzgKwFHKGy5zAmTRaEWPandUbVrfh8x+bYQghIBnQE9fVWiIxUGdG
         G/Eg==
X-Gm-Message-State: AOAM532xq6cJVvKVa6xJ285Y1wOhBfTbq6AhNsjRJCFiCqP8RtWeU4Br
        rZZM0x+7fO94T0g7DOoLqZ4B1ko2Do5WZeyeF64jDA==
X-Google-Smtp-Source: ABdhPJyoUpqQP7ExvgQg6jlWGuD67jd+pPKzAlGa3XPHsroQPCFsp38zhEGfcVb52hJVx5RhRxmhKo1NuYqZ7YP9TJs=
X-Received: by 2002:a05:6e02:1086:: with SMTP id r6mr29456065ilj.158.1594059676475;
 Mon, 06 Jul 2020 11:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200706180010.29032-1-puranjay12@gmail.com> <20200706121407.6c24f537@lwn.net>
In-Reply-To: <20200706121407.6c24f537@lwn.net>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 6 Jul 2020 23:51:05 +0530
Message-ID: <CANk7y0h0p+OjYvtFbGf-C7FeOdgf3HBtd=jVdDTHYP5eKv2uvQ@mail.gmail.com>
Subject: Re: [PATCH] Security: Documentation: fix: `make htmldocs` warnings
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:44 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Mon,  6 Jul 2020 23:30:10 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > Remove extra ')' after function name to fix warnings.
> > It solves following warning :
> > WARNING: Unparseable C cross-reference: 'groups_sort)'
> > Invalid C declaration: Expected end of definition. [error at 11]
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  Documentation/security/credentials.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> > index 282e79feee6a..d51e42b92395 100644
> > --- a/Documentation/security/credentials.rst
> > +++ b/Documentation/security/credentials.rst
> > @@ -455,7 +455,7 @@ When replacing the group list, the new list must be sorted before it
> >  is added to the credential, as a binary search is used to test for
> >  membership.  In practice, this means :c:func:`groups_sort` should be
> >  called before :c:func:`set_groups` or :c:func:`set_current_groups`.
> > -:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
> > +:c:func:`groups_sort` must not be called on a ``struct group_list`` which
> >  is shared as it may permute elements as part of the sorting process
> >  even if the array is already sorted.
>
> So this is a great fix, thanks for sending it.  That said, there are a
> couple of ways in which this fix can be made even better:
>
>  - The simpler of the two is to change the subject line of the patch.
>    "Fix a warning" is almost never a good description of what you're
>    doing; what you are actually doing is fixing a broken cross reference.
>    So the subject line should say that.
>
>  - In this case, though, there is a much better thing to do.  We
>    deprecated the use of :c:func: around a year ago; the docs build system
>    can now do the right thing automatically.  So a fix that would both
>    eliminate the warning and improve the document as a whole would be to
>    replace every instance of:
>
>         :c:func:`function_name`
>
>    with:
>
>         function_name()
>
> Is there any chance I could get you to send a patch that does that?
Yes! I have started working on it.
>
> Thanks,
>
> jon
Thanks,
Puranjay
