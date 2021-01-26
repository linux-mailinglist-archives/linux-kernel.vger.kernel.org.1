Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE439303AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404506AbhAZKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbhAZCfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0BE7230FC;
        Tue, 26 Jan 2021 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611628505;
        bh=vY8skLmS8gAa3C2YdwzeUu+thyB3c8wHH/g4ryiz9X0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4Mb5OgJuGjK7oUVR8+iQTwJOU1sO2dAJ2Y/Gq6QBS/d24d0GFw8apcYotLbkjE4M
         XFsen8tTjwgYOl1MSZvPSPLqICNQEJ+xqLOAx3dPfPWZVdBl3EBKOvMAQGeoTk3WQs
         Li3xZa+YhBC6jpDW31QYHS/reTejSaMZmeGFkYlYPA5culIXC3qOl9bjHLsOX1F12i
         Zk0A90+hKvDPXe1iaHt3mpf0QssWI1Q9jZV0HBvprsahuz0qAv/3w+PdQ2QQyHWpGE
         Z/lkmq1Pz7KcxNTdY7XaTJEqmlIJTZrMxIwWRb2iF+1hjJlgH6F1dMGdfI1WemBswG
         uSOSHuoxrRdiQ==
Received: by mail-ed1-f48.google.com with SMTP id j13so18005989edp.2;
        Mon, 25 Jan 2021 18:35:04 -0800 (PST)
X-Gm-Message-State: AOAM530RpFFkvsub3mn6LSBhs3WFnUyb1FIWx7Y21ypGhLqQNJm2b4Bk
        97T3oUvNWcCptRXqpTiJezKj0bFsObLsd2/pYQ==
X-Google-Smtp-Source: ABdhPJz3LoRDEKajGyRaIcQrswahRbzqtudpMO1X5AbaHvIxQ1oYjpkVNNCcTzAZoKzXVR+JMPIGAIb/6bvMZMlUj/k=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr2877008edd.62.1611628503416;
 Mon, 25 Jan 2021 18:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20200528132541.463300-1-arch0.zheng@gmail.com>
 <ebbba4ac-ea65-472c-5a3a-201dfe59e402@alliedtelesis.co.nz> <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Jan 2021 20:34:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpy+8DdXjYAJJyHmcaQe8MBftWbzftaCAkvt9nr6pQEg@mail.gmail.com>
Message-ID: <CAL_JsqLpy+8DdXjYAJJyHmcaQe8MBftWbzftaCAkvt9nr6pQEg@mail.gmail.com>
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

On Mon, Jan 25, 2021 at 8:06 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> +LAKML given it's an Arm issue
>
> On Mon, Jan 25, 2021 at 6:47 PM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >
> > Hi All,
> >
> > On 29/05/20 1:25 am, Qi Zheng wrote:
> > > For version 1 to 3 of the device tree, this is the node full
> > > path as a zero terminated string, starting with "/". The
> > > following equation will not hold, since the node name has
> > > been processed in the fdt_get_name().
> > >
> > >       *pathp == '/'
> > >
> > > For version 16 and later, this is the node unit name only
> > > (or an empty string for the root node). So the above
> > > equation will still not hold.
> > >
> > > So the kbasename() is redundant, just remove it.
> > >
> > > Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> > > ---
> > >
> > > Change in v2:
> > >       remove another kbasename() also.
> > >
> > >   drivers/of/fdt.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 38619e9ef6b2..4602e467ca8b 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -643,8 +643,6 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
> > >            offset = fdt_next_node(blob, offset, &depth)) {
> > >
> > >               pathp = fdt_get_name(blob, offset, NULL);
> > > -             if (*pathp == '/')
> > > -                     pathp = kbasename(pathp);
> > >               rc = it(offset, pathp, depth, data);
> > >       }
> > >       return rc;
> > > @@ -671,8 +669,6 @@ int __init of_scan_flat_dt_subnodes(unsigned long parent,
> > >               int rc;
> > >
> > >               pathp = fdt_get_name(blob, node, NULL);
> > > -             if (*pathp == '/')
> > > -                     pathp = kbasename(pathp);
> > >               rc = it(node, pathp, data);
> > >               if (rc)
> > >                       return rc;
> >
> > I'm trying to keep our boards up to date with newer kernels.
> >
> > I've just hit a problem on an older board that uses
> > CONFIG_ARM_APPENDED_DTB and has a number of command line args passed up
> > from the bootloader that are required for a successful boot.
> >
> > I'm stepping through kernel versions in the hope that keeping things
> > running is easier in smaller increments I'm up to v5.8. I'm not
> > currently able to check a newer kernel on this board but looking at the
> > code the problem still seems to exist in the latest tree.
> >
> > early_init_dt_scan_chosen() searches for "chosen" prior to this change
> > the "/chosen" node that gets inserted by atags_to_fdt.c but with this
> > change it can't find it and fails to boot.
>
> Given this code works for normal cases, I'm guessing the problem is in
> atags_to_fdt.c or libfdt. Is it possible to add an empty chosen node
> to the DT and see if that makes any difference.

This will work. It's a atags_to_fdt.c bug. In node_offset(), we search
by path (/chosen) with fdt_path_offset. If not found, then we add a
subnode called '/chosen' (instead of 'chosen') with fdt_add_subnode().
Though arguably, libfdt could catch and handle this. I'll send a patch
in a minute.

Rob
