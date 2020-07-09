Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9D219696
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGIDZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 23:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGIDZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:25:38 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7EC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 20:25:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so689363qtg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LOg+f3qhnwQmEv3CzFJxkl1rctpcpyUrfk9aMulJx7M=;
        b=eJkV7KBxSafkL4HURo1waDCP/9DJQrH839C7BP4d2pLoVRHmry9RD58EEWmKz0pM9W
         1LR3yhI0QgjCKEX1PFZoeadc4pi1GYakfUUsbd0nuEi1Sx6MR/iGxGN56BTm3mf6A9pf
         7DBnfpP24Bmllz2R4Ok0BFE03J32LJqFIL2AFlDuc7U3z+nKacRrUz+B4DUp4uvXq3zF
         +XX6Fex3GkoH18kpM7AYIf/2fET1Zc2qUmFOoCw3L76Auy7OmVCP7QaG4JqW/m+Umfme
         eLE7nWgEa51HjKovrEDrFAt+/35l4PO0UuWs1/S4aB6swtbR+z5RFpcGk3wgfc+KpZTc
         nh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LOg+f3qhnwQmEv3CzFJxkl1rctpcpyUrfk9aMulJx7M=;
        b=fJNBKcJFyD36vHRNAhlVuZY3hTosFyD5ZHk6KUoBxivzJ+4vLvT7YbZWuLDQJOY3MO
         JmONZ/TR7LKd7nfqVC15HTttWVOI+q39FKPaMGfHWWre0rLuKPgFZhGZ3MHgjqulMI5P
         zlUSEbz9ARoQA+kIsaD7kdJxNuCwc/eQmPAeSYH959HTGgbXEJNjfEZuYP986z5QS8+7
         6NAuk/j+XSq46yoX46/KOJQLITJbFZjN0aatJwTZxgS1pCcr0C2xPuzw281gfJ8sg8KX
         klswyeogWg00N5d62EyiQx4Qsjkwvfl0PNM1sjAa7L5HPZbG6BBeGfocBAxKjxY0iw7/
         lfFg==
X-Gm-Message-State: AOAM531GZh85QTB/nX+8WBS/1//orrLzVOesuErKz/TY0S+YtIasthUy
        7vTcZhW2JBqSogyMRut7FakNBKZszvZmDUUBS3o=
X-Google-Smtp-Source: ABdhPJw0Q/Ut7/2bkhotkhqZH5Tfr8SZaQDdE5Ab0dJiE1MatYpXZU5MfcgVESlhklquY7ydZpnJyOi2DHregWhNTbg=
X-Received: by 2002:aed:22ef:: with SMTP id q44mr60197673qtc.333.1594265137456;
 Wed, 08 Jul 2020 20:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com> <575ab75d-1382-5f12-96df-53c0bb947f8c@suse.cz>
In-Reply-To: <575ab75d-1382-5f12-96df-53c0bb947f8c@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Jul 2020 12:25:30 +0900
Message-ID: <CAAmzW4MdTstiqEccFsw61HHyim2uutA8jd23reX-kOtDnXmzDQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] mm/memory_hotplug: remove a wrapper for alloc_migration_target()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 8=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:34, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > To calculate the correct node to migrate the page for hotplug, we need
> > to check node id of the page. Wrapper for alloc_migration_target() exis=
ts
> > for this purpose.
> >
> > However, Vlastimil informs that all migration source pages come from
> > a single node. In this case, we don't need to check the node id for eac=
h
> > page and we don't need to re-set the target nodemask for each page by
> > using the wrapper. Set up the migration_target_control once and use it =
for
> > all pages.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Thanks! Nitpick below.
>
> > @@ -1345,9 +1324,28 @@ do_migrate_range(unsigned long start_pfn, unsign=
ed long end_pfn)
> >               put_page(page);
> >       }
> >       if (!list_empty(&source)) {
> > -             /* Allocate a new page from the nearest neighbor node */
> > -             ret =3D migrate_pages(&source, new_node_page, NULL, 0,
> > -                                     MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> > +             nodemask_t nmask =3D node_states[N_MEMORY];
> > +             struct migration_target_control mtc =3D {
> > +                     .nmask =3D &nmask,
> > +                     .gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RE=
TRY_MAYFAIL,
> > +             };
> > +
> > +             /*
> > +              * We have checked that migration range is on a single zo=
ne so
> > +              * we can use the nid of the first page to all the others=
.
> > +              */
> > +             mtc.nid =3D page_to_nid(list_first_entry(&source, struct =
page, lru));
> > +
> > +             /*
> > +              * try to allocate from a different node but reuse this n=
ode
> > +              * if there are no other online nodes to be used (e.g. we=
 are
> > +              * offlining a part of the only existing node)
> > +              */
> > +             node_clear(mtc.nid, *mtc.nmask);
> > +             if (nodes_empty(*mtc.nmask))
> > +                     node_set(mtc.nid, *mtc.nmask);
>
> You could have kept using 'nmask' instead of '*mtc.nmask'. Actually that =
applies
> to patch 6 too, for less churn.

You are right. I will change it.

Thanks.
