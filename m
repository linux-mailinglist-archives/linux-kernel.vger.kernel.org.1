Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8112B95EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgKSPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:15:44 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82118C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:15:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p6so718644plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiJ6sLleKQDn0ka0YtFFZrD090kUoFe8h4Pf41RPSK4=;
        b=PMFafYPk2vDpxnYlxuSc5hGzDYvJljf949da2m8epBNo4wbzPqtI40dzctARZabFgi
         jDlZoZVH4bcNJRrZF14A+A+nNXpD+LXm6MjpsWjYEC0Gb9BIm6+EujjEYCY8erbgbNoj
         PkSbpivI1Kvqb4Oe25434lybwxy3TOK479niQeH8utz/PYvb8HAEr2PZqSZg3EuvoCJ0
         SwneVnK4qyOeBVJwIiqvOSzlhsOCQD9uOn4HUgkyJtIgUx0QWYrmCDO8Y1QcqywXWWic
         iVl+A2nrYCAJk5lIweLnlG913Ush/qmgIqnK7xQNv+ttphFWDrIm0M+hgn5/qIBOsS/z
         iqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiJ6sLleKQDn0ka0YtFFZrD090kUoFe8h4Pf41RPSK4=;
        b=oX8Mx5PwXtWpSGzDZqYcKq3txu8zpyVyZUnyX1gAqdOr1cnz0+6f38eu4GFb7cLxXN
         DOPffoLUd93etqieeYlxHijXgtv+GBnrAbWqqw9D/Tqvsfa6dN68nnDcG5pho1MUNwvi
         D7oZpgfSj+iAhPyVNq4p2miyHMfNSwD+JiSgaMA+xA12xf+CmbzOO6F8hDL6gKph9VuN
         Au8/hsE8Uutw+Y8hK8fF8YsCyr9h1xHFmVozv0aurHRiplWXOowJQgtu18neQj7cokFL
         ZhI29vseyR1pzG3LUgc0Xcm1a3ffbwub1RvurcExwp+E494whlxzpzJ//UxlUrzAFwZk
         EZFA==
X-Gm-Message-State: AOAM533R/Ko+e5XWj8HB5/JHwPFEQYTUNMKU8GM+Np5uD9v5VZi54FJC
        3g0ghoTaoGGff2XBdVikZ3Lc8owlL8P1uTwK2FQ=
X-Google-Smtp-Source: ABdhPJzL6/Ibqat+YEH+FWvGmqxO5U+t7pZ+/0LZyeLBrb5NS2gARQQdWAt1XTAKLSbosrt02IRhSXrj8/HGGCOwwO0=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr8851803plr.17.1605798943815; Thu, 19
 Nov 2020 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
In-Reply-To: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Nov 2020 17:16:32 +0200
Message-ID: <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
Subject: Re: Proposal for a new checkpatch check; matching _set_drvdata() & _get_drvdata()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Robo Bot <apw@canonical.com>, Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> Hey,
>
> So, I stumbled on a new check that could be added to checkpatch.
> Since it's in Perl, I'm reluctant to try it.
>
> Seems many drivers got to a point where they now call (let's say)
> spi_set_drvdata(), but never access that information via
> spi_get_drvdata().
> Reasons for this seem to be:
> 1. They got converted to device-managed functions and there is no
> longer a remove hook to require the _get_drvdata() access
> 2. They look like they were copied from a driver that had a
> _set_drvdata() and when the code got finalized, the _set_drvdata() was
> omitted
>
> There are a few false positives that I can notice at a quick look,
> like the data being set via some xxx_set_drvdata() and retrieved via a
> dev_get_drvdata().

I can say quite a few. And this makes a difference.
So, basically all drivers that are using PM callbacks would rather use
dev_get_drvdata() rather than bus specific.

> I think checkpatch reporting these as well would be acceptable simply
> from a reviewability perspective.
>
> I did a shell script to quickly check these. See below.
> It's pretty badly written but it is enough for me to gather a list.
> And I wrote it in 5 minutes :P
> I initially noticed this in some IIO drivers, and then I suspected
> that this may be more widespread.

It seems more suitable for coccinelle.

> The shell script gathers a list of xxx_set_drvdata() functions then
> greps through all files and also checks if there are any matching
> xxx_get_drvdata().
>
> Thanks
> Alex
>
> Shell script:
> -----------------------------------------------------------------------
> #!/bin/bash
>
> fns1=$(git grep _set_drvdata | cut -d: -f2 | cut -d'(' -f1 | sort -u)
>
> for fn in $fns1 ; do
>         if [ "$fn" == "//pci_set_drvdata" ] ; then
>                 continue
>         fi
>         if [ "$fn" == '``dev_set_drvdata' ] ; then
>                 continue
>         fi
>         if [ "$fn" == '"pci_set_drvdata' ] ; then
>                 continue
>         fi
>         if [[ "$fn" == *"_set_drvdata" ]]; then
>                 fns2="$fns2 $fn"
>         fi
> done
>
> fns1=$(echo $fns2 | tr ' ' '\n' | sort -u | tr '\n' ' ')
>
> for fn in $fns1 ; do
>         get_fn=$(echo $fn | sed 's/_set_/_get_/g')
>
>         echo "Matching $fn - $get_fn"
>         for file in $(git grep $fn | cut -d: -f1 | sort -u) ; do
>                 if ! grep -q $get_fn $file ; then
>                         echo "   Maybe $file"
>                 fi
>         done
> done
> -----------------------------------------------------------------------

-- 
With Best Regards,
Andy Shevchenko
