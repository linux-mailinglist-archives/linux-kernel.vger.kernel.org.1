Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACA2B83F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKRSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:34:31 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC7C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:34:31 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so4385697lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6Pr4KsX5I6OjoV/O+XnmJxxfakXMRzrCCZbtymxAyY=;
        b=DgkNLNcO1RLJwk9m3YOKJyfHXrmu2SzimggufjzxWH40vzwvdBmqiEdWVWs5LIV2hZ
         6m4deP7+BsCigur2P/hut8eIQNAti5cdRx0dUxbS1LKb5gtA/406E2AAhoS/AIpFTNP/
         O7bGYbS1kykGnsZh3zV/N3oNUtO7h0iT8M2LGoQ/WuTNHw0b0iLlJKgU0KY7hKUHefHG
         ALlf3WgFF2/l9eMNtNucSTKTVH2c0HGmaISCES4f+h4KvGtSc2Jlyq9BGiQXLF9rD09U
         E33tehClQcOZJHTxV1FMLq+yy0q0YoUC9gSSLTPrNn2RE5Wap09m6phQRHXVRYLFU2SM
         s3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6Pr4KsX5I6OjoV/O+XnmJxxfakXMRzrCCZbtymxAyY=;
        b=FU+gMa8KTs5V3opOUf8qYcPzP/OWz3B/wRa6cKIYRzrPY0aUhVKLr6DcNIM/3xZh61
         /wDQPFQJ3GK/co1cOzj+E6gQOEsiA1zNTojMFVPAw1L98W3dtePNjge3OSFUO8mctKV+
         oue5mPD8kL1HjYB76cufb4gdPzTIcr0JLryBQ9yrJ2QCK9GISlgLKuBm02SDbHjlnzyS
         41ov7aPCkrgRkpToX9X7KEvo1ahhdEijm6KlXMnMTLwloLOsrmRzj713mJc/WLjbx3KR
         fHnymheMEcVF/7S99SB7rVOwW+b8hoIJPQy2jDJQr4K71o5BfGZkuS22VYJXxVFRs6nK
         tRUA==
X-Gm-Message-State: AOAM533kwfNS/CUXjBiVBu12G/05uWoxm3O6Q0CfVWjxuOjZusrQP0FS
        nlryxu9ImIn5lqOYJ01NzciyHIH19wwn0/DOACI=
X-Google-Smtp-Source: ABdhPJxUQ/Y1xtlrn2AAPKoG862Lp1eEeGED2YqWBNkU3uR3d0YRuo1P6Zx/usyKuhoH6qf1x/bI1UqhgI6FLan5m6A=
X-Received: by 2002:ac2:598f:: with SMTP id w15mr3906570lfn.148.1605724469568;
 Wed, 18 Nov 2020 10:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20201118124035.96976-1-dwaipayanray1@gmail.com> <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
In-Reply-To: <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 19 Nov 2020 00:03:58 +0530
Message-ID: <CABJPP5CqKjY3_mfkJEsHX_8Zc7q1TRCgA4T54sTEZBiKgPS+OQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:44 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-11-18 at 18:10 +0530, Dwaipayan Ray wrote:
> > Brace style misuses of the following types are now
> > corrected:
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3937,9 +3937,23 @@ sub process {
> >                       #print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
> >
> >
> >                       if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
> > -                             ERROR("OPEN_BRACE",
> > -                                   "that open brace { should be on the previous line\n" .
> > -                                     "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
> > +                             if (ERROR("OPEN_BRACE",
> > +                                       "that open brace { should be on the previous line\n" .
> > +                                             "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
> > +                                 $fix) {
> > +                                     my $line1 = $rawlines[$ctx_ln - 2];
>
> How are you sure that in a patch context this line always starts with /^\+/ ?

Hi,
I followed it from the other fixes for OPEN_BRACE which were already
there. In the patch context if the lines are added then only I think the fix
should be triggered. Other instances should not be modified.

Thanks,
Dwaipayan.
