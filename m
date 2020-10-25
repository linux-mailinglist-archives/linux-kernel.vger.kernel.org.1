Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE1D2980CA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768283AbgJYIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768277AbgJYIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:33:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD5C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 01:33:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x203so1989079oia.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLu2puIBJMzkzJcyETQ70Rj2NF1EgRhiqjPv9k4/Hbw=;
        b=Mr4mn1+FR3HZCuyy4+0BMHkQ8h0CUi7LYMc3AAeQMtqHJZd+KqerUdOini7ZQgZ53f
         RwOoDlyX4Wc03dLjDEp06Aa5gQP4dFUldP8+oPMnONo1/64I27vEFDQMxfKKvn4a5W8w
         3k1TzqvDfCnudR9MuPoXazebofCkG16abo+msgiQdFl0Tw9Jph3QBiMLVaH7kP1HHICF
         Jaw8qr6gWz/0JfR6/e7Ds3E3TmWq6oAoBXr/IFlCst/Hyp9aRIya4DYW++6sNhjPSmqG
         yJWBjadSxi3UyW+r5S781nMOi8FdtgG6UAN/42aG28lxqsqqTfgBNPJrhhaqolHRM+Zr
         KULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLu2puIBJMzkzJcyETQ70Rj2NF1EgRhiqjPv9k4/Hbw=;
        b=Zeltq9Emfs+CFMzXIIV4eVdgwwERoUT2qXue34Q2A3X1CiEI3T2DE5rA7Rxeq1Yg0A
         rQoDvqwPI1CAgm4XD4YPSV4kSto0A9hMJ96q53DXw/J3R3FGHxLp30drYSNIe+QC7lrF
         D8JRWEj3qvPxty5/3FroG2KsgNV4Omi7MWW/MQ/DbRJgLbPnY8e3k086V1UQrhjNt2Nm
         KlcQALJb9i5OSVrKFU6b11Ber4pXOO/E+wo8Em4davW6ws62w9U7CQ0MHho0qqwTF5Ao
         AsnbEYvWpWkQEGamUjlkuOQawvdy0yKU35gB0ilqUEuPdthcSRp8OJFzE/Rd/pONiAe+
         Eo7Q==
X-Gm-Message-State: AOAM5310KnQ2+u/UrG8uDYfGD1Om7aJMVUCUyk+ok8C4xQe9w+3gKBcc
        bxAmXDcCwu4lBsqS9EyT6C8g3hshd69topUUsxg=
X-Google-Smtp-Source: ABdhPJyDyXw2oz1MklvsLGfAzReADRUl/YEU8DSnSp18ZEZTrTns8VmzGmn6PBUuALmQ1HSl8wr12ngyhGjRSNEieIE=
X-Received: by 2002:aca:420a:: with SMTP id p10mr7002175oia.117.1603614781589;
 Sun, 25 Oct 2020 01:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201025065134.21737-1-dwaipayanray1@gmail.com> <e96f8306d57e9a2ce7118b545db197e819e97b19.camel@perches.com>
In-Reply-To: <e96f8306d57e9a2ce7118b545db197e819e97b19.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Oct 2020 14:02:32 +0530
Message-ID: <CABJPP5D9ziuyPpPPyPM+n101vT1LGEjHj+JQjOhdN533t8Ud7w@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 1:52 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-10-25 at 12:21 +0530, Dwaipayan Ray wrote:
> > It is generally preferred that the macros from
> > include/linux/compiler_attributes.h are used, unless there
> > is a reason not to.
> >
> > checkpatch currently checks __attribute__ for each of
> > packed, aligned, printf, scanf, and weak. Other declarations
> > in compiler_attributes.h are not handled.
> >
> > Add a generic test to check the presence of such attributes.
> > Some attributes require more specific handling and are kept
> > separate.
> []
> > Also add fixes for the generic attributes check.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > +                             if (exists($attr_list{$curr_attr})) {
> > +                                     my $new = $attr_list{$curr_attr};
> > +                                     if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> > +                                              "$new$params is preferred over __attribute__(($attr))\n" . $herecurr) &&
> > +                                             $fix) {
> > +                                             $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$new$params/;
>
> Thanks.
>
> This fix would only work for the single conversions
> and would not work for multiple attributes like:
>
>         __attribute__((aligned(4), packed))
>
> It would be nice to be able to convert this to
>
>         __aligned(4) __packed
>
> One mechanism to do that might be to:
>
>         create an empty array
>         for each attr
>                 push(@array, conversion)
>         s/__attribute__(...)/join(' ', @array)/
>
> if all attrs were converted.
>

Okay sure I will try doing that.

I think I need to also change the test to correctly display
the warning for those having multiple attributes too.
Because now only single attributes are reported.

And also do you think there should be a separate check
for __alias__(#symbol)? I think it expects a string and that should
be trimmed in the fix.

Thanks,
Dwaipayan.
