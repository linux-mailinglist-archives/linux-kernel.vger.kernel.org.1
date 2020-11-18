Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF82B8577
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKRUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:23:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:23:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f11so4892871lfs.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20CZ0mMTdqYZmScmnhKZcCAXu1Wndcjz7koPln1t+qY=;
        b=KU8Gjb7mHayD7Jt1lL9faSUPJQWG73iP7Y43UvTA0kQcuAdKqOtNSZX5H/qYBr4Awf
         d1HGNZLYZBLh3xw3BHf5kAX7nHOEEoi1807t9wVRhxpG6zOBtNiG8ZhnP1l53efYfJsH
         9YQqde7EBATjwEpD/P2xJ29kUh29ltT79qR0Kwl5RNKkBFmV3YnNeahTb3V3Gc6oymzw
         ziDJBZmh1udwnAwNvawMwDvcFfV6wKutN66iqLTH/LX98vnpjW0s66a4Co7NAjgm9ZJ2
         Z4tPyLjcWu4/OG3wchFU0SL3qvUjds1OJthBQ6/Cthmhe8+lN7MgoMAbEK8PGB/LjYu+
         bVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20CZ0mMTdqYZmScmnhKZcCAXu1Wndcjz7koPln1t+qY=;
        b=mIDYg6um5etrei0zJaA4GRhDbFBb0JQjZNC5T1EJfjpZ6oxCDNTcVaXY/FSelKTICY
         dtDNHFqP0w77s0n0iG452E6tOKP9AUHE6LAoEVnsBu62WGegwd1PhjpcMNh/hKXI3Cy8
         hVLw2k/qsNMnIPyI3tSBXpofrP+5zBbcPjfu+6rTWnY9yKEiOjn9f5RLhulNF3M3zIAq
         KgnUQyrxjEqmMUCSdWUFOfXAKXQWwNyYeDvb++kZEQoZ864zN+40zuCPUv0X9dRQBym3
         Gvu9Jb2JB/RBRUrWK7POnCYsTVBbSCiKIBVVeezCYo5UEf4l7541GzD6vZ1KxIhafUTr
         8uoQ==
X-Gm-Message-State: AOAM5310r98yZXlFzjcTy3muPIYK00md4EXkbNC82vnpqXR74D+5RO+N
        0N6dkn2WtLo3lYAbzg68zzddLfdpvpz8C1rsHT3N22p0bb1ToA==
X-Google-Smtp-Source: ABdhPJygARz6iDkAvScV3Pe7WNMax5IbCJBi8REKGbfjygwxixZm/JA0DMP266qu5T/9Xc55mkAj5Zq9/alOGahZjg8=
X-Received: by 2002:a19:8110:: with SMTP id c16mr4198068lfd.372.1605731003760;
 Wed, 18 Nov 2020 12:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20201118124035.96976-1-dwaipayanray1@gmail.com>
 <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
 <CABJPP5CqKjY3_mfkJEsHX_8Zc7q1TRCgA4T54sTEZBiKgPS+OQ@mail.gmail.com>
 <754e240d1c88274ce2d94a5b6dbcfff1cc8c9508.camel@perches.com>
 <CABJPP5CHofzA46FHe3eJrgjQBTcaoCkR=dc29xxK80oFZJVfoQ@mail.gmail.com> <12b44d3a477de314320dc9d26b26576875525f27.camel@perches.com>
In-Reply-To: <12b44d3a477de314320dc9d26b26576875525f27.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 19 Nov 2020 01:52:52 +0530
Message-ID: <CABJPP5DTBkuzEjs28wufdnOXf61-T=wtoZWiTya_idXfJ92eNQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 1:28 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-11-19 at 00:15 +0530, Dwaipayan Ray wrote:
> > On Thu, Nov 19, 2020 at 12:09 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Thu, 2020-11-19 at 00:03 +0530, Dwaipayan Ray wrote:
> > > > On Wed, Nov 18, 2020 at 11:44 PM Joe Perches <joe@perches.com> wrote:
> > > > >
> > > > > On Wed, 2020-11-18 at 18:10 +0530, Dwaipayan Ray wrote:
> > > > > > Brace style misuses of the following types are now
> > > > > > corrected:
> > > > > []
> > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > []
> > > > > > @@ -3937,9 +3937,23 @@ sub process {
> > > > > >                       #print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
> > > > > >
> > > > > >
> > > > > >                       if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
> > > > > > -                             ERROR("OPEN_BRACE",
> > > > > > -                                   "that open brace { should be on the previous line\n" .
> > > > > > -                                     "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
> > > > > > +                             if (ERROR("OPEN_BRACE",
> > > > > > +                                       "that open brace { should be on the previous line\n" .
> > > > > > +                                             "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
> > > > > > +                                 $fix) {
> > > > > > +                                     my $line1 = $rawlines[$ctx_ln - 2];
> > > > >
> > > > > How are you sure that in a patch context this line always starts with /^\+/ ?
> > > >
> > > > Hi,
> > > > I followed it from the other fixes for OPEN_BRACE which were already
> > > > there. In the patch context if the lines are added then only I think the fix
> > > > should be triggered. Other instances should not be modified.
> > >
> > > As far as I know there are no existing uses of --fix with OPEN_BRACE.
> > >
> >
> > I think you added it via 8d1824780f2f1 ("checkpatch: add --fix option
> > for a couple OPEN_BRACE misuses")
>
> The difference here is that you are dealing with a $stat context and
> the existing --fix entries are just for single line fixes.
>

Hi,
Ya I understand that. Though I am dealing with $stat content,
I am also directly accessing $rawlines here.
So I think that should have the proper patch line format, starting
with + or - or so.

So in this case if the error is triggered, checking for /^+/ should be done
becase it would be wrong to fix the others with /^[- ]/

Is there something else that I am not getting here?

Thanks,
Dwaipayan.
