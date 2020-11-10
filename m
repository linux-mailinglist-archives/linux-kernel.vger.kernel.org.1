Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D82ADEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgKJS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:58:42 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:58:42 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so12514098ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xY+OYzm36HZ2hizRqFw7LNCZnSuEE495c5e+Ma5DQ2c=;
        b=Vhj+Cj3Q1ccxlLI6gcrPUEJwiIBfusiKaYvL7ob4w/12LPgA6zNtZ5pjxrYV9aeEAk
         W1zmVui1It7Km0JFET7bFmNdb0PKdc6sFCfEDiF5OlDbln+C1U7a4bS9PIuLO8TT3aLi
         Yt16OOHKvIVQ/rxDEM2sOieKmo+PDp8ZZNjjQWiZWOMx6OPrhRa4eefqDwzjRjIuhIER
         V7VURrtzQVUtioPnjMfH0sb4Ce6hpl9vDtvqlI8QdTOSt8scL+EOlEbmiSvYT9BO3Wyg
         JrnfGWN/p+Ba8KhlLYLQynf/RAFKjBkmn8l8BAEZsPIrVXEmiE/Q+KXdnDoagWaFoiFp
         WXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xY+OYzm36HZ2hizRqFw7LNCZnSuEE495c5e+Ma5DQ2c=;
        b=eAjz7nsQH1zFNhamNTFDsBomQkKLPHzo2n74n1mdspKJNwfKs8glikqkdxl/N3j/I2
         a42nYkq+z88sSRwmvGwq9Z6fu9nPHCMjpGgGCjDBPwL2pfXU62FExiQEoGWLd3hbM5f3
         0Z3tI545OBqynj+owWEDIu2dUi8gkrYmVGywvG8ayWsOz/JwJZMYgYtPnEtnV5f+NSD3
         XGXjTKDXB5vBJB1f+GkmCugFW/3GWujEBT50uWgxcb0AeDP5iojcTEwQVS0mWp+HK/rp
         fRHfA4NuDuX8USqOiVOZdckNvfiZdiQPNB0kcNR+Cs8e8fpHfIrIYagGwZVfRo/N4z5P
         j87w==
X-Gm-Message-State: AOAM531hcVwI/QnBBVBZCnbcgUZA716oBrFKzX+LinJ3pYAiAIyNu8Nb
        C3sZcpMSfk24bW1eDbotewwV7Fnrm05NKWkGzVQ=
X-Google-Smtp-Source: ABdhPJxwDJhG09qcVrcjklXnfM/k9mQpcKMuMSWu2ZjJvkfUOmfZW+dNKN4so2UwpPmnYJYYSHiJ1Ue3oFsUeG2s1X0=
X-Received: by 2002:a17:906:814:: with SMTP id e20mr21018873ejd.514.1605034720962;
 Tue, 10 Nov 2020 10:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20201110181250.264394-1-shy828301@gmail.com> <20201110181250.264394-4-shy828301@gmail.com>
 <20201110181636.GJ17076@casper.infradead.org>
In-Reply-To: <20201110181636.GJ17076@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 Nov 2020 10:58:29 -0800
Message-ID: <CAHbLzko+++aGr08js=J6_jmiHSM4zv1XFzGuqpjRdpR_f3+C1A@mail.gmail.com>
Subject: Re: [v2 PATCH 3/5] mm: migrate: skip shared exec THP for NUMA balancing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Song Liu <songliubraving@fb.com>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 10, 2020 at 10:12:48AM -0800, Yang Shi wrote:
> > @@ -2142,6 +2151,10 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
> >       int page_lru = page_is_file_lru(page);
> >       unsigned long start = address & HPAGE_PMD_MASK;
> >
> > +     if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> > +         is_shared_exec_page(vma, page))
> > +             goto out;
>
> Why include the IS_ENABLED() check?  Once the ~50 patches I have pending
> go in, shared executable THPs can exist without this option.  And can't
> we have executables on tmpfs today without this option too?

Aha, yes, thanks for reminding. I had the patches baked in my tree
before your patches were posted.

We could have executables on tmpfs w/o that config. Will remove it. Thanks.
