Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6B303AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404401AbhAZKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbhAZCHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:07:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA4F22EBF;
        Tue, 26 Jan 2021 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611626783;
        bh=YGAANK8L9e+mLQGBGtUyNcxlA05RGcL/dRm8R3QZimA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0F+KQnyQhSFzPmy4spIusLLEyzLU/NH2f28CItVWhk6q8lFTK291lg4Yyv9AxTww
         7NoI+wZm8Dx2KPP3kenAgz1E+vxIsSeigsjsMCZuOJ1pGACu7tJW6vbRKAFkKTGm+P
         DA96y1S6GMTyrK9D6WBeYGxcvI6IloGtvA2kkKs9jLuiFSlq2w1hYIy1otxEnlqfys
         nTCtWAfPSk/aOQd+HNb0aaN3pimp9Y1UbenaWoyAHLK4CbkovAjMv7dzx5369wxfy6
         ZBpZTqf8ei0xUlTWEke57ebfDXnucF6YZ+qOUdnLXengEi4yTAjrzOC7STiNztt9pk
         a0uQjWbEbsKZw==
Received: by mail-ed1-f46.google.com with SMTP id g1so17946193edu.4;
        Mon, 25 Jan 2021 18:06:23 -0800 (PST)
X-Gm-Message-State: AOAM531PhMP/rUWB73g5JBRqKjmolGGyExu9BrDmRyv8hIvifOMugfHE
        1nT7fOD7wBXIvgPVD/LfWm72tNcWEnnjl+C+WA==
X-Google-Smtp-Source: ABdhPJweh1PUzzmE10rGd3297H4LLle3hpTK3RC9qiKGn1v/Vs694RWOj5hwq8I9snXJi3mMGX4LoqqdvmWzIXT2v7E=
X-Received: by 2002:aa7:c895:: with SMTP id p21mr2748271eds.165.1611626781894;
 Mon, 25 Jan 2021 18:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20200528132541.463300-1-arch0.zheng@gmail.com> <ebbba4ac-ea65-472c-5a3a-201dfe59e402@alliedtelesis.co.nz>
In-Reply-To: <ebbba4ac-ea65-472c-5a3a-201dfe59e402@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Jan 2021 20:06:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
Message-ID: <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
Subject: Re: [PATCH v2] of/fdt: Remove redundant kbasename function call
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Qi Zheng <arch0.zheng@gmail.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+LAKML given it's an Arm issue

On Mon, Jan 25, 2021 at 6:47 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> Hi All,
>
> On 29/05/20 1:25 am, Qi Zheng wrote:
> > For version 1 to 3 of the device tree, this is the node full
> > path as a zero terminated string, starting with "/". The
> > following equation will not hold, since the node name has
> > been processed in the fdt_get_name().
> >
> >       *pathp == '/'
> >
> > For version 16 and later, this is the node unit name only
> > (or an empty string for the root node). So the above
> > equation will still not hold.
> >
> > So the kbasename() is redundant, just remove it.
> >
> > Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> > ---
> >
> > Change in v2:
> >       remove another kbasename() also.
> >
> >   drivers/of/fdt.c | 4 ----
> >   1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 38619e9ef6b2..4602e467ca8b 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -643,8 +643,6 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
> >            offset = fdt_next_node(blob, offset, &depth)) {
> >
> >               pathp = fdt_get_name(blob, offset, NULL);
> > -             if (*pathp == '/')
> > -                     pathp = kbasename(pathp);
> >               rc = it(offset, pathp, depth, data);
> >       }
> >       return rc;
> > @@ -671,8 +669,6 @@ int __init of_scan_flat_dt_subnodes(unsigned long parent,
> >               int rc;
> >
> >               pathp = fdt_get_name(blob, node, NULL);
> > -             if (*pathp == '/')
> > -                     pathp = kbasename(pathp);
> >               rc = it(node, pathp, data);
> >               if (rc)
> >                       return rc;
>
> I'm trying to keep our boards up to date with newer kernels.
>
> I've just hit a problem on an older board that uses
> CONFIG_ARM_APPENDED_DTB and has a number of command line args passed up
> from the bootloader that are required for a successful boot.
>
> I'm stepping through kernel versions in the hope that keeping things
> running is easier in smaller increments I'm up to v5.8. I'm not
> currently able to check a newer kernel on this board but looking at the
> code the problem still seems to exist in the latest tree.
>
> early_init_dt_scan_chosen() searches for "chosen" prior to this change
> the "/chosen" node that gets inserted by atags_to_fdt.c but with this
> change it can't find it and fails to boot.

Given this code works for normal cases, I'm guessing the problem is in
atags_to_fdt.c or libfdt. Is it possible to add an empty chosen node
to the DT and see if that makes any difference.

Rob
