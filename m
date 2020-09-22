Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41616274421
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:24:24 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE95C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:24:24 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n193so4310736vkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfEeVl7uF+pO9WIve/HLLXPr12CavwB47OaHN9XwVJg=;
        b=udPvWmaWg4sTDLCy8Ps4cLvXnr6bBOEKy/OJn3qaeDP9CGo2YerlfVwKslFcq+Ovlw
         3uPxEzCWjiehjU6tUh0BHOyixf+DiW6JTzvt2gTD1fjRpbTTS7ilcV9X120DmBuHncXh
         oABbpgAGFdl2D1GjgLr+YaravNNqU41b/jdP/MjlE/5gXPOTFajFVHVblAhigB3auefm
         zgGot6PW60Z/13MnrFoDvDrpYGWxi8TJ6ilBzojF8nb/INwfyIJYdU005wIRI5PsTQ4P
         LU6dIhWndYLd5SbcXaQb84xkYANb3oldSgK3hmE+05hgp+jwBKrWT+tlZDCEawWeGyVu
         92Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfEeVl7uF+pO9WIve/HLLXPr12CavwB47OaHN9XwVJg=;
        b=N0eOR7zSRn4CbXXTeJE7P3bnwvGHK6cGlSRoGNOWsQf2ow+jyObCfbAoqrGXaX1w8S
         7kP/HE+3Rgx2fF+womz50eLsXXSPEKZ+1njNUWFL6FgPjifgl4wVY+X5lv79fbTZjsmi
         mmLFrCd6nWvq3jE5xQQeox7uYif9oqkqqIISpHvj4h45Ly3WXFJNeE0L84eFdMGZrJed
         iAuBXtvXYi2Pd++UicoU/579EykTvOYohj3bzC/+5RW2p4nfsWXDFga3klLWtc9ZEIBb
         iqQzNKdL4vKUPCCw0HVoj9DKfE871bn/yxREncdtEQNZY7svRgop9eN2AIDp1YxTU+vQ
         HLiw==
X-Gm-Message-State: AOAM533544H6df7XFjdeKoPvwzQN0qa0ZqWhlC1jkP9OY9YJZnK4h4t4
        BDRFevkb0zhedt2QH7vUVR9fLOubG0qVH5unOys=
X-Google-Smtp-Source: ABdhPJzUdzazZOJ7vxm5zre66cAm1vrzjGEfZE5W2eVHEL0UDBz6ELxCX6eCpaawLDN9OMAbvHFRq2jawGHs7HO4I9E=
X-Received: by 2002:a1f:3144:: with SMTP id x65mr3524144vkx.3.1600784655758;
 Tue, 22 Sep 2020 07:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
 <20200921190433.1149521-2-jim.cromie@gmail.com> <20200922080819.GJ14605@alley>
In-Reply-To: <20200922080819.GJ14605@alley>
From:   jim.cromie@gmail.com
Date:   Tue, 22 Sep 2020 08:23:48 -0600
Message-ID: <CAJfuBxz7sz7816zqZURDcubdJT6Wz056eVyMWWL46UD58bxyvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dyndbg: dont panic over bad input
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 2:08 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2020-09-21 13:04:32, Jim Cromie wrote:
> > This BUG_ON, from 2009, caught the impossible case of a word-char both
> > starting and ending a string (loosely speaking).  A bad (reverted)
> > patch finally hit this case, but even "impossibly bad input" is no
> > reason to panic the kernel.  Instead pr_err and return -EINVAL.
> >
> > Reported-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  lib/dynamic_debug.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 2d4dfd44b0fa5..90ddf07ce34fe 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -259,7 +259,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
> >               } else {
> >                       for (end = buf; *end && !isspace(*end); end++)
> >                               ;
> > -                     BUG_ON(end == buf);
> > +                     if (end == buf) {
> > +                             pr_err("expected non-empty bareword");
> > +                             return -EINVAL;
>
> My understanding is that the BUG_ON() was there to catch eventual bugs
> in the algorithm.
>
> IMHO, it was never reachable in the original code:
>
>    1. The following lines will skip all spaces and bail out
>       when we reached the trailing '\0':
>
>                 buf = skip_spaces(buf);
>                 if (!*buf)
>                         break;  /* oh, it was trailing whitespace */
>
>
>    2. The following code will find the end of a quoted text:
>
>                 if (*buf == '"' || *buf == '\'') {
>                         int quote = *buf++;
>                         for (end = buf; *end && *end != quote; end++)
>
>
>     3. The else part will find end of non-quoted word:
>
>                 } else {
>                         for (end = buf; *end && !isspace(*end); end++)
>
>     4. The BUG_ON() will trigger when the above cycle reached the
>        trailing '\0' or space.
>
>        This will never happen because this situation was caught
>        in the 1st step.
>
>
> Your patch triggered the BUG_ON() because it wanted to handle
> '=' as a special character and was incomplete.
>
> If you want to handle '=' special way. You need to do it the same way
> as with the space. You need to skip it in 1st step. And it must mark
> the end of the word in 4th step.
>
> But it will be more complicated. You must be able to handle
> mix of spaces and '='. I mean the following situations:
>
>     word=word
>     word =word
>     word= word
>     word = word
>     word = = word   /* failure ? */
>
>
> Back to the BUG_ON(). It might be changed to something like:
>
>         pr_err("Internal error when parsing dynamic debug query\n");
>         return -EINVAL;
>
>
> Best Regards,
> Petr


yes, the original patch was ill conceived

Im blaming Transient Acute Myopia,
where I couldnt see to the end of the line, where "=flags"
is a proper flag setting.

That "interferes" with using '=' to separate keyword=value.

As you outlined, its possible to implement something that handles both,
but I decided that handling keyword=value is just a convenience feature,
and isnt worth the added corner-cases and explanatory burden.
