Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6383F2ECEB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbhAGL0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAGL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:26:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07DEC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 03:25:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so3679235pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 03:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPYoUF04sANxUtBvsIvdeDWelO8MgjMrgBU4JJEctH0=;
        b=TvudalW7R6i7/vU9sTrkO4sh60H3U4/8P27eO63GcrPpBy3bezHyzilID1hR76cu/I
         aKZ/GdbNTzel2pIxzGeBIuP+SBbh6Q78n3AvutjTCblcEoRSoZdPP3lcSCZEUg7SYb2u
         Juk4Hr5fhlYpW/itNzug7q/4LAk1/TAkPV3hqa0dj89YBBld8E07srbU70COu6n9Dw5d
         Vth0eDhESYuibWQ5y0+zE51jDqD5i1IztKMcjw43QLsNfINPPsiAc68KOY3QU4Xn6N5i
         uPWMtrkdmmPF4Qir2Iu5WetsGUnpOFWTCkvyIk/lKe6Vxl56PgajLsmQ67hMFhB7t+We
         6W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPYoUF04sANxUtBvsIvdeDWelO8MgjMrgBU4JJEctH0=;
        b=Gs4tjrr36ps6+IwQjWWfiGn9SCbTQ0YlUaDKT8pAg5VxH4NG2PplTKsBCL6CL8qD7G
         gI2ZZ3O3DcSx6fbzNW6QP8uKWj7PtVSPw+Dwi3RzLA/1od59q/3VmBUZ53UXqsLw94mr
         rmrpsK9yO+GOnlsukSjLIVe7OtO9zO4Kkp6C5Wzh3wFRoPefbbV0ZEV7cFqnqZgveHqF
         cDLcysPy2oNAWzLXho/bUfLovYLwwlM6iqH8X1VrNSQFqOyRHymbGM1tiEjwJEwdZhkw
         v3kiXXnyVbXLWUR7/ak2APzec+OIIB963Vel1YInH0nB2FL85/XiZomPjTokRunPCEt+
         slVQ==
X-Gm-Message-State: AOAM531BW/s1IgilZvQhZHrp2zWgdHFwrEm0wPhvTOOvVJl6GeT01sQv
        rpHnSLk8TEXx9Sz0+DN9d0yCGq3Mnu1qHJmdD0S3Tg==
X-Google-Smtp-Source: ABdhPJzwC4SoLTS/ZVQ8BJgEnbOgZezDkFf7YNbkHo1QTe4S6D0UBaAsfywIcNSjOF5t9mP7NIbVtTxpzYJcnS87Cwo=
X-Received: by 2002:a63:480f:: with SMTP id v15mr1369677pga.341.1610018740564;
 Thu, 07 Jan 2021 03:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-2-songmuchun@bytedance.com> <20210106161327.GR13207@dhcp22.suse.cz>
 <CAMZfGtUTkeeswiS8M1aq67JXztrjQwzqd0aZ9cgvgPZEEQQPEQ@mail.gmail.com> <20210107111642.GF13207@dhcp22.suse.cz>
In-Reply-To: <20210107111642.GF13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 19:24:59 +0800
Message-ID: <CAMZfGtULi=E5pNoLciaedGfNpSdopzyOzFhnzALf+nCciFRUPQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 7:16 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 10:52:21, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 12:13 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 06-01-21 16:47:34, Muchun Song wrote:
> > > > If the refcount is one when it is migrated, it means that the page
> > > > was freed from under us. So we are done and do not need to migrate.
> > >
> > > Is this common enough that it would warrant the explicit check for each
> > > migration?
> >
> > Are you worried about the overhead caused by the check? Thanks.
>
> I am not as worried as I would like to see some actual justification for
> this optimization.

OK. The HugeTLB page can be freed after it was isolated but before
being migrated. Right? If we catch this case, it is an optimization.
I do this just like unmap_and_move() does for a base page.

> --
> Michal Hocko
> SUSE Labs
