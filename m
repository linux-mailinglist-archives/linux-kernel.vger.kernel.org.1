Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C928E48C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgJNQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgJNQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:34:02 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:34:02 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w204so3870813oiw.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIEoiqLMaLoSOx4X+V1uBCmur2V5OdkLLdZqKbX2SnA=;
        b=rg0yhHjGil/dzr/a2r090Uzy71YZ6LwH6gb5YAXVZUcpNYYN6vJFrk24EdIm7N9glw
         Ej4mjIqOaGACI+im/P4GIz35o/hh54kfG+u6ovZPR7hzQ92sk2Ro7i5FtghwQ9cm1r55
         7jaYJJiq8Ck/k8U5xr8sY6WLoIJK3rxniMhyGPsKskNVv9nykI00cj73uZQ6/vxpieog
         sNCAYdNdgDjALkL3m9EiGUy1B9kPKnnQplvuzLodH8viOH1+PqmqNr1n5D+MzM3kEUa+
         C/BnXCE2Yk+AMyFUwMsqD5HvR7RFEw1ozrIrrm3fp4YXm3PaBF/H+ZB72CxV+c9+i2lR
         28uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIEoiqLMaLoSOx4X+V1uBCmur2V5OdkLLdZqKbX2SnA=;
        b=GVAeSHZ3xBjMZE0rR5+adXMQ62pnGpognzouDW5tGwSHksgCQWTS+dfF1VQKn2H6xH
         8ODwOAGyhscX7DWDwbofuSGVQ7IxLT/XHrAYMGr8pXXo2nCoC0XVNc1/nsSTe1ejBoof
         m4VXABhfXov2oP/p3j3ARmQN6Ls4dUzhiZGigxsVtmLjgYLTVHfLzoQwTubnavRUzs0B
         CvNkIM8GfyY5hq9HTUQar/0Elv33z7UxY43ckDhfOb7gk36UJYKVSq1vFEnmOcLkLoHr
         SlnDaPFb18Wrx5FRx7aB3CIC5mV5I4Wq095IWQBVYJWWH8sG4bdq3xavLGI88uf1jL9G
         ZcPA==
X-Gm-Message-State: AOAM530mUqjtaqpEzlVrwEKKOF6fLKE3CWBxKCdFoGZcup/gVpRI0ZvN
        foU491ctIAc9CvGO/mBJ01UFFYBvtnqHOkAWdXnk4P1aWsax+w==
X-Google-Smtp-Source: ABdhPJzVo0v65nl2zPlqkLM0/OOjzT9osCrWLOd4xBBJL/VL/iQz4IkzF4Aq4gIE3/eaagTLZrgyw2dwFbp+cuAqkKU=
X-Received: by 2002:aca:420a:: with SMTP id p10mr97960oia.117.1602693241890;
 Wed, 14 Oct 2020 09:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135637.92319-1-dwaipayanray1@gmail.com> <eb7e86171263a27e5c761bddf91439a5ec8c83e1.camel@perches.com>
In-Reply-To: <eb7e86171263a27e5c761bddf91439a5ec8c83e1.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 14 Oct 2020 22:03:35 +0530
Message-ID: <CABJPP5Cp7LNJhhNTtpoHidZEO1nXWL-+ZWijvOJ9EVQ4_cK_ng@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:47 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-14 at 19:26 +0530, Dwaipayan Ray wrote:
> > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > moved the repeated word test to check for more file types. But after
> > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > new warnings of the type:
> >
> > WARNING: Possible repeated word: 'git'
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3063,7 +3063,7 @@ sub process {
> >                               }
> >
> >                               next if ($first ne $second);
> > -                             next if ($first eq 'long');
> > +                             next if ($first =~ /(?:long|git)$/);
>
> Nak.  This needs a leading ^ otherwise words
> like "belong" and "digit" match as well.
>
>                                 next if ($first =~ /^(?:long|git)$/);
>
>

Yikes, that was silly of me. I will correct and send you the
updated version.

Thanks,
Dwaipayan.
