Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B102967CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373649AbgJWAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901294AbgJWAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:00:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A601C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:00:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so4399889lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDXB6MzIAjPa6Z+bYdtdThdhAzUe/hH836F46Z6tXhw=;
        b=guRkvILP5wkBF+Y8oh3Zj7febDKb+DRU+Ww1jYwe0hatSbkoSvbf2KK84bXYRPYpEc
         UcIAxUjcnJZrINp5BGV6sKtKGNlAG6k3n3FkO8x4H/85YVV7SR/705oDXmT5x3d0yhVZ
         mG6PuVtvKHPX8zk3WDn7PAnWbJx9bjuy7E08MCpKuK2f7ke3p5BXY9C2tUa6TY/xPrMM
         8qsv+MYRUGERFLfHpupKVI1x3jOXVV9VUezVFFIPeMf+nK0oIbHJevGLpn5M5RnUCXqI
         FgiXurXdocx0CUIqiFWILkvklKd3RHDh47dcC4y37Yo+GN5Ns+yckbpjeJjxnoSZ8MRo
         pzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDXB6MzIAjPa6Z+bYdtdThdhAzUe/hH836F46Z6tXhw=;
        b=AMeifQC047/HLi9rbVnbZ8YbM2aoyc3rmq9ofY6XDkyuMblyHdGd/n2DVAjU4nyNAk
         BtXBj5bbLkN23oXljvGl7eFOy0HosvD6zz0dWpH7bK/hO86ZMo81TrbaDHKZGhWN5WVh
         H2hCO1ZiQQgm38K9QnoN8sO/Y+3zLUBXb3F5e/UE6QodDNZ54KESxpoxR2lJzc9t0joV
         9BVfRcsjO9i149ASPk+2VUePFVkctu444y58U1Hee3+SPXmMYFgmgPdM38TNBPxjlwjI
         WU2WR7tb8Chy+HVhC8V+XBzhdIKkkTojXtIYuuSCopiVF6jNtFCTUuYVQ2kvQ3mA01dT
         uYhg==
X-Gm-Message-State: AOAM531VcCXr4cIyvdlLcaDTrPbWPMd2eKfs99QPQ7Y8eCsUTpMc94Xh
        LVioSxlEHXpfOHofm+iEhX5G3Iv/I8aUz69ziZX8yQ==
X-Google-Smtp-Source: ABdhPJzuULwrnVGAGtEgdR0cHZymQzvgHmTA54WaDGuHfGCXTVu1rVTxbqmOoQxfxggqrA9eJa1zXMFPgmAY7VgAR18=
X-Received: by 2002:a19:7ed8:: with SMTP id z207mr577866lfc.54.1603411208087;
 Thu, 22 Oct 2020 17:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <87sga6vizp.fsf@suse.de> <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com> <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Oct 2020 16:59:56 -0700
Message-ID: <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
To:     Roman Gushchin <guro@fb.com>
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:25 AM Roman Gushchin <guro@fb.com> wrote:
>
[snip]
> >
> > Since bf4f059954dc ("mm: memcg/slab: obj_cgroup API") is in 5.9, I
> > think we can take this patch for 5.9 and 5.10 but keep Roman's cleanup
> > for 5.11.
> >
> > What does everyone think?
>
> I think we should use the link to the root approach both for stable backports
> and for 5.11+, to keep them in sync. The cleanup (always charging the root cgroup)
> is not directly related to this problem, and we can keep it for 5.11+ only.
>
> Thanks!

Roman, can you send the signed-off patch for the root linking for
use_hierarchy=0?
