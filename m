Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA32DA72C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgLOEjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgLOEjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:39:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1074C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:38:32 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ga15so25733448ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjas04zq4quJPDf/2Zl8W/3PIeOhXPZgNazOTkbLsjU=;
        b=GDNB/aCqhln43599Pj7A2uVQlX4OYo4k0I9Dp6EdhU8h/suX8Kcgr94s0vG5G4AsnS
         GyqJ6Jxg0aq0K3BNSs6krIkxfxVrixOORoACeUCI0EeUYuHdU/0KkaODusnGRhJaz6uM
         20EelORVe4K3b2B4XpT9vDqWkOylgP3IDNynB6isAOyS/BabSgEvuguS2d/zehk4KuDB
         pn6kpGKURU0c2xhX5BvLAc5xBp763QXa/l92BxeuvqdssCpgI6CwVq/H1yl18AdhYgsN
         OVkoWDZlyGX6whsYCfE8VOjfBcmyW2wRLZmsFb85XgqutAuXwV/jSLrIE65UNJ2g0UOE
         Gtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjas04zq4quJPDf/2Zl8W/3PIeOhXPZgNazOTkbLsjU=;
        b=HCPJWiXIKUKjOl/nxqnUuTSU53Oy5QiF8Bly6PmqyIF6EzwLeX+K2i6HaHCt/ecReR
         HSuKz6VXo5tcl9KWVhP4rXhmlZ30WIHHnvb9FfL9wPZk3f1lhCE9HxXFiFQN7qG8gF9J
         cNAmIS7gBde2DEnQQZNAm85AnIfPgO0aO3nXRTKb1WQCd12a+rHfDC78/EO8gmsZem1l
         ZuprNFH7DCH15/qA4EHLI+wu6wp2Lg9AdOVv0QJef732tA175Eha7iCFXx1q+7LGj3RG
         eMqEeUHWY7k5acwKMDyyayc1xdliBwOxES5ciCzRHMiyPGWjnvTAV/ZvRoVf7MecmKtS
         ryTw==
X-Gm-Message-State: AOAM530AKdCxTq/ZG7yyd5YSagDwuVzfRi6iRv0Th7PKlsT0bQO9UCL0
        fb9vq42vT38MyRD/P4QO1bWhHE8F+CDGBhP4iwsAKA==
X-Google-Smtp-Source: ABdhPJxmmg2xBh9Z1x6jNfKkt61RWp5JGX1NTncLKP19jmRPohZ5nawq5vIMNeMZ2XyD8PMP5v+IraZ8V0c8PmC1A+A=
X-Received: by 2002:a17:906:fb9b:: with SMTP id lr27mr25823947ejb.175.1608007111384;
 Mon, 14 Dec 2020 20:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-3-pasha.tatashin@soleen.com> <20201214140337.GD32193@dhcp22.suse.cz>
In-Reply-To: <20201214140337.GD32193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 14 Dec 2020 23:37:55 -0500
Message-ID: <CA+CK2bBM1s=MxOcNR3pmO1rwKfrbA4=ObLYszUuU8Cz3N30OJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 11-12-20 15:21:36, Pavel Tatashin wrote:
> > PF_MEMALLOC_NOCMA is used ot guarantee that the allocator will not return
> > pages that might belong to CMA region. This is currently used for long
> > term gup to make sure that such pins are not going to be done on any CMA
> > pages.
> >
> > When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it is
> > focusing on CMA pages too much and that there is larger class of pages that
> > need the same treatment. MOVABLE zone cannot contain any long term pins as
> > well so it makes sense to reuse and redefine this flag for that usecase as
> > well. Rename the flag to PF_MEMALLOC_PIN which defines an allocation
> > context which can only get pages suitable for long-term pins.
> >
> > Also re-name:
> > memalloc_nocma_save()/memalloc_nocma_restore
> > to
> > memalloc_pin_save()/memalloc_pin_restore()
> > and make the new functions common.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you.

>
> with one comment below
> [...]
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1576,7 +1576,7 @@ extern struct pid *cad_pid;
> >  #define PF_SWAPWRITE         0x00800000      /* Allowed to write to swap */
> >  #define PF_NO_SETAFFINITY    0x04000000      /* Userland is not allowed to meddle with cpus_mask */
> >  #define PF_MCE_EARLY         0x08000000      /* Early kill for mce process policy */
> > -#define PF_MEMALLOC_NOCMA    0x10000000      /* All allocation request will have _GFP_MOVABLE cleared */
> > +#define PF_MEMALLOC_PIN              0x10000000      /* All allocation request will have _GFP_MOVABLE cleared */
>
> This comment is not really helpeful. I would go with
> /* Allocation context constrained to zones which allow long term
>  * pinning.
>  */
>
> Something similar would be useful for memalloc_pin* functions as well.

I will add it.

> --
> Michal Hocko
> SUSE Labs
