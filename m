Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF2296DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463143AbgJWLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463081AbgJWLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:40:44 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 04:40:44 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h10so1511128oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tMz4xjMTw2zkncTRGPRg5ATleTstjjcW3zdYcWIUZ8=;
        b=D+MZNOl9KG4lNGVBXfL8k0PcmmYSzFxfUFkqj6aW5/yV0sSsYNQ/zmxDSCp5uLc3C0
         mPHDTmSte4s1nanfDqwuMSb12ezW25S8uyyqqnJla0VOaKRvodHwKWDJy7oFVm0QU11U
         gpMsp2g/HQMBn20yfNWBrXwyMr9NHSjGyuEP5f6Rs+yx30oC8b7RYzEjBWn6qqmztFLV
         7vHQCPmOk8pS6gCzlkyRKrhLHKyJ/heHulQQyuI5riWsUOs/491xUQ51cAP9zB419rAH
         +fmFxtDPsqY2VxumLmMfZHp1qbkZ3nMuQwoeNBociQ6c1nK+UkWCY3Jr33OBUpiRjwsh
         rM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tMz4xjMTw2zkncTRGPRg5ATleTstjjcW3zdYcWIUZ8=;
        b=mYcNdadUbFlIJazxpvxqiELbBI+zaeFCbzJHg3K1JgrCj1JTs/tAFQ9PFYOlJGBhhT
         CxlF4KIvNPlxIxMfi3GClQUcG5wlXUufC5bzmyf3KplPeS0K7rZDT4CvdHQJWhvyYetn
         m9VGj8B7BeVq3twpNtxNCWZ283dnve8tOZ2yugXm8fAoR6BPsikDJE4SIIZlF0l0phhO
         hGKpkF3pKHGj+KnW5P3Q8R3AgiToUMRpkHBvz7KZgGCm758WJ2xIk76fs0VGliWGGbxf
         jBR8EODaoM+46THPwM4U5nLzu2fDrk9hTn9dZsm2YbByEpPevfMQNDLM+oB0K5zPPSjz
         w3GQ==
X-Gm-Message-State: AOAM533zH1fruGF/36FnXfv1+z/Pnu/bNy+oYGUvENJeVXvYEffPLrSE
        4kp2g2yvuU5IAvyCx2RGcokg82GOakI6aasWwMU=
X-Google-Smtp-Source: ABdhPJwTgZqlGq2Lz+G+sI5Gveu5gTKnDWV9h7x8Lv0cTLjXijkbz512fzlzx6+0eP0ArmNbPfvF9JAYq01O/rftKhY=
X-Received: by 2002:aca:420a:: with SMTP id p10mr1224817oia.117.1603453243163;
 Fri, 23 Oct 2020 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201023094307.20820-1-dwaipayanray1@gmail.com> <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
In-Reply-To: <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 23 Oct 2020 17:10:14 +0530
Message-ID: <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:34 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-10-23 at 15:13 +0530, Dwaipayan Ray wrote:
> > It is generally preferred that the macros from
> > include/linux/compiler_attributes.h are used, unless there
> > is a reason not to.
> >
> > Checkpatch currently checks __attribute__ for each of
>
> checkpatch, no need for capitalization
>
> and non-trivially:
>
> > +                     my $attr_list = qr {
> > +                             __alias__|
> > +                             __aligned__$|
> > +                             __aligned__\(.*\)|
> > +                             __always_inline__|
> > +                             __assume_aligned__\(.*\)|
> > +                             __cold__|
> > +                             __const__|
> > +                             __copy__\(.*\)|
> > +                             __designated_init__|
> > +                             __externally_visible__|
> > +                             __fallthrough__|
> > +                             __gnu_inline__|
> > +                             __malloc__|
> > +                             __mode__\(.*\)|
> > +                             __no_caller_saved_registers__|
> > +                             __noclone__|
> > +                             __noinline__|
> > +                             __nonstring__|
> > +                             __noreturn__|
> > +                             __packed__|
> > +                             __pure__|
> > +                             __used__
> > +                     }x;
> []
> > +                     my %attr_replace = (
> > +                             "__alias__"                     => "__alias",
> > +                             "__aligned__"           => "__aligned_largest",
> > +                             "__aligned__("          => "__aligned",
> > +                             "__always_inline__"     => "__always_inline",
> > +                             "__assume_aligned__("   => "__assume_aligned",
> > +                             "__cold__"                      => "__cold",
> > +                             "__const__"                     => "__const",
> > +                             "__copy__("                     => "__copy",
> > +                             "__designated_init__"           => "__designated_init",
> > +                             "__externally_visible__"        => "__visible",
> > +                             "__fallthrough__"               => "fallthrough",
> > +                             "__gnu_inline__"                => "__gnu_inline",
> > +                             "__malloc__"            => "__malloc",
> > +                             "__mode__("                     => "__mode",
> > +                             "__no_caller_saved_registers__" => "__no_caller_saved_registers",
> > +                             "__noclone__"           => "__noclone",
> > +                             "__noinline__"          => "noinline",
> > +                             "__nonstring__"         => "__nonstring",
> > +                             "__noreturn__"          => "__noreturn",
> > +                             "__packed__"            => "__packed",
> > +                             "__pure__"                      => "__pure",
> > +                             "__used__"                      => "__used"
> > +                     );
> > +
> > +                     if ($attr =~/^($attr_list)/) {
>
> I would remove the __ from the entries here.
>
> And you could check using
>
>         $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*)/
>
> and check for all attributes in $1 after
> stripping the leading and trailing parens
> and any leading and trailing underscores
> from each attribute.
>
> And you only need one hash and you should
> check for existence of the key rather than
> have multiple lists.
>
>         if (exists($attributes($attr))) {
>

Okay thanks!
But what should be done for the attributes which are
parameterized, like __aligned__(x). Should all the __
for these entries be trimmed too? There are also
cases where there are multiple versions like:

__aligned__
__aligned__(x)

To help differentiate between them what can be done?
Should i make the keys as:

aligned
aligned__(

instead of

__aligned__
__aligned__(

Thanks,
Dwaipayan.
