Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3C2F3F77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404890AbhALWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404847AbhALWVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:21:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A4C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:20:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ga15so237730ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTIoaNVkYWwgsEp9LMpgcyP45XmLf/k0fgDnsh1vc7Q=;
        b=OixaNP0KdqpjiYzt/2c0kRVvoc3YdMlU0G7M1jrAHP+WZLnsjLBn2HI2a4KD49XU8k
         QOksFhFZvPS61lNudfnotINI5/cED2AEfo/wlKhLUj45QyiV9pMKxNRMNo/5EuhDU4j8
         EPbnWKZ/3CdJIIUTRFjW/ZcaC6of0+NgM8eBCYsOhdMFQdiDdlNFsUvrib8myhSkD5hh
         MswOsS5zCgxRwd2dIJPjTXvxwv7PmuV9u48+GD+XLG9Zc1m6IZNtxZFD3yickfaAsUgo
         dg/vxNFR2H+MEZuwdoll7yOfU8nPSmp4m9DB+yASQzXhOC5Hg8KcoG0rXJHqK/awpiL/
         MN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTIoaNVkYWwgsEp9LMpgcyP45XmLf/k0fgDnsh1vc7Q=;
        b=nfZkrBQxIeXDzRAGamAri2AwdZO3BD5Fc/XhTbQDNdMkHeZ3tUbHeZX5TGJHliEE+e
         /3lmVSJunJHXRo7bMAL9Lca59BEE0Tcb3tYJqTS9fVfEMGz8PWRn16cRE8R57s324e0E
         fDvqyyWSeCUJvEmr6HpYVugHwqfove0D14Y3ZPk7xKrhOzN+bRX9ap8BiG9NRKiGEnPg
         vhltexu+KVSNALqwvjRUsz6Eeet3IiH69AJqXDWDtD7U87TqNQd3E2idU2qw/LQQLKhl
         6vXJbxSW9AUon7c1QoOns9q/lucm6a5H+VUN1IyNRMN8Vrk7zSr5fWf9fY6SG0iM2kgH
         HPig==
X-Gm-Message-State: AOAM533HrGZVPwTRvIqhKWO5MDt3z/+BaCy7OQG4reqJD6ZCx2hJalC+
        UAOJ3dDWG29aDxXJqh171qXrPcZDWCifWcXf4oxIgg==
X-Google-Smtp-Source: ABdhPJw+Gi32iWw2zRGAmyQWdcoaZTNn+kztXT/ZCK7VAyrtTePrZuY+wMdQpD/H7tRkOKeEi/FfHmD3PDqzCNyOS5A=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr647229ejz.45.1610490049654;
 Tue, 12 Jan 2021 14:20:49 -0800 (PST)
MIME-Version: 1.0
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
 <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
In-Reply-To: <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 14:20:40 -0800
Message-ID: <CAPcyv4hd_Bt-krepaV2rVaKLQEKEWK+gGvk_ZbeD-_tk2+hn8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:53 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 10:34, Dan Williams wrote:
> > pfn_section_valid() determines pfn validity on subsection granularity.
> >
> > pfn_valid_within() internally uses pfn_section_valid(), but gates it
> > with early_section() to preserve the traditional behavior of pfn_valid()
> > before subsection support was added.
> >
> > pfn_to_online_page() wants the explicit precision that pfn_valid() does
> > not offer, so use pfn_section_valid() directly. Since
> > pfn_to_online_page() already open codes the validity of the section
> > number vs NR_MEM_SECTIONS, there's not much value to using
> > pfn_valid_within(), just use pfn_section_valid(). This loses the
> > valid_section() check that pfn_valid_within() was performing, but that
> > was already redundant with the online check.
> >
> > Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/memory_hotplug.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 55a69d4396e7..a845b3979bc0 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -308,11 +308,19 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> >  struct page *pfn_to_online_page(unsigned long pfn)
> >  {
> >       unsigned long nr = pfn_to_section_nr(pfn);
> > +     struct mem_section *ms;
> > +
> > +     if (nr >= NR_MEM_SECTIONS)
> > +             return NULL;
> > +
> > +     ms = __nr_to_section(nr);
> > +     if (!online_section(ms))
> > +             return NULL;
> > +
> > +     if (!pfn_section_valid(ms, pfn))
> > +             return NULL;
>
> That's not sufficient for alternative implementations of pfn_valid().
>
> You still need some kind of pfn_valid(pfn) for alternative versions of
> pfn_valid(). Consider arm64 memory holes in the memmap. See their
> current (yet to be fixed/reworked) pfn_valid() implementation.
> (pfn_valid_within() is implicitly active on arm64)
>
> Actually, I think we should add something like the following, to make
> this clearer (pfn_valid_within() is confusing)
>
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>         /* We might have to check for holes inside the memmap. */
>         if (!pfn_valid())
>                 return NULL;
> #endif

Looks good to me, I'll take Oscar's version that uses IS_ENABLED().

Skipping the call to pfn_valid() saves 16-bytes of code text on x86_64.
