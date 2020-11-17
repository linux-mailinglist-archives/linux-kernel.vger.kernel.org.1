Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F017D2B5CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKQKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKQKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:22:05 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF447C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:22:05 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w10so3752729ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw60kYhqDr8ucVZwMJU6Ksh44AdpP2IZ3BFIM3cTzRo=;
        b=LvHrMR1lfhWHyeQcTkHK37DeXiBddSQQBxVKj63o0rJUyRa/Le6hZ0RdFTRqSXNWg2
         2TnM3OBFrwfb4Fc83RIE9mpI8M8b69AghoMIDfwoVHK4UeRpW/Wuj/76qgZHJDLKfLec
         Rr4A0LqkRob9YuhD4D9ADVfc+T1USBq1o/3B4ni98+KR9uYg69G3Cyuea0M9eJGpW7vP
         W71P0VZ2vo+QIQ1tra1LizrdjXg9eMJ23SfFRAcRPx1ASuhemmSmHKcbI5BhbbCcbdvl
         usV8qzirhM1jXlj8Az0DG36t8hA8DE4ZzbPvWHLGOtawYN31OFTbqQUBIIlDVekjSAkA
         ltBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw60kYhqDr8ucVZwMJU6Ksh44AdpP2IZ3BFIM3cTzRo=;
        b=RwTjZPI01RI1xQQQnfpV4w/5gEouhjC0kgvQpr7ECDYzGOeiht3927NfnCcphSMpJD
         zKTi6/LAJH4VwoFD2XyB0B6qNzBVmT4OaD5AR0BYrzHZBp4gRB6B44ckmOyUfVZVoPti
         pjMUMJecOikjq+TW4kq6/xZUnXa5zjBscxpT3HqX8vikQSFyKjf2AC53i1HikyyrZLL1
         o3QOdzrkenyuk4ku0Yqcg11Gv09tkCqrhI9VtCtLiziROZeWZWkGXpjR+Wa1BEWVWh2i
         7ghXI9YWdOmZjnYE2Pgl3zGZzJkv4ZtuN0v7Hi+g8/kPhqdadAyaxPZ2d7dhQP4O6OcF
         9NXg==
X-Gm-Message-State: AOAM531B8PK2PQBvCQSZ3OVMjLg+gwwhCzj1AB2oFxasP6xbcG198fHY
        EuQR0GPUWPvuWLsrGp6dMnjGp/7Tsmtz/TQtzLIld55sQr8=
X-Google-Smtp-Source: ABdhPJxPVUFNZHk/tHp765anbL/PX5LiAT50Eagj4VX1/c2e/6QjgTEAJQvKGDjBoBTQsI9nWscsJrnY0d1Grjd4NQM=
X-Received: by 2002:a92:512:: with SMTP id q18mr11260314ile.147.1605608524946;
 Tue, 17 Nov 2020 02:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20201117040501.21914-1-yashsri421@gmail.com> <1b9c5353c6318cc7a4e013886012739e6627d82d.camel@perches.com>
 <791b3213aaabd5ecccc9d3f6dd0e8ee420611dbd.camel@perches.com>
In-Reply-To: <791b3213aaabd5ecccc9d3f6dd0e8ee420611dbd.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 17 Nov 2020 11:21:54 +0100
Message-ID: <CAKXUXMxGbL8myAJwobCNEimxmwKTyF41WUNkLU45HTqSKKAPRw@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add fix option for MAINTAINERS_STYLE
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 5:29 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-11-16 at 20:26 -0800, Joe Perches wrote:
> > On Tue, 2020-11-17 at 09:35 +0530, Aditya Srivastava wrote:
> > > Checkpatch expects entries in MAINTAINERS file in a specific order and
> > > warns if the changes made do not follow the specified order.
> > >
> > > E.g., running checkpatch on commit b33bc2b878e0 ("nexthop: Add entry to
> > > MAINTAINERS") reports this warning:
> > >
> > > WARNING: Misordered MAINTAINERS entry - list file patterns in
> > > alphabetic order
> > > +F: include/uapi/linux/nexthop.h
> > > +F: include/net/netns/nexthop.h
> > >
> > > Provide a simple fix by swapping the unordered lines, if both the lines
> > > are additions (start with '+')
> >
> > On second thought, nak.
> >
> > This fails when there are 3 consecutive misordered lines.
> >
> > SECTION
> > F:    c
> > F:    b
> > F:    a
> >
>
> btw:
>
> scripts/parse-maintainers.pl already does this reordering properly so
> this particular --fix addition isn't all that useful.
>

I think the real fix is to provide some more documentation on
scripts/parse-maintainers.pl that explains how to run this script when
an author hits the warning type in checkpatch.pl.

I see these follow-up patches:

  - some documentation on scripts/parse-maintainers.pl
  - a patch to checkpatch.pl that points out this documentation when
this warning occurs.
  - maybe: improve of scripts/parse-maintainers.pl to handle exactly
this use case of a patch author (assuming that the patch was just
created with git format-patch -1) and how to get the corrected diff
for this patch.
  - maybe: a patch to checkpatch.pl that can create the command for
scripts/parse-maintainers.pl for a specific patch and which then can
be added with git commit --amend or git commit && git rebase and
squashing that in.

I think once that is done and better understood, you can much better
judge if there is really a need for a fix in checkpatch.pl.

Lukas
