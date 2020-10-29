Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE28629F544
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgJ2TbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2TbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:31:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7CDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:31:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k9so4250637edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyJygmAvNgYlCXg5FRM2hRgcjUEjJ9Xaju1Fs9LLpuU=;
        b=glBEJM+fqw6vvS11sAi4ED/GhnYv6vtIMwfqmGflxe+RAcGJCMyOC1To9OOgz3UJQQ
         vUYC+iaxxWuX5oE3VGCXqfcWsvCoUNdYl+m8Djyovzn0oJJhfgrjlUxAhMThkJuqYPBn
         phz910BKRi74+YHn+2giV/C552vY9iNPMAnAvTkDabcmsIdyIQ/VHB8TXAvLvSOmU4xP
         zHorz1AFdc2ngNlieyqSx90h+n72eSKgC8pTwMOzn2iVeexPoJBEYuyrx4Aua6BfjoHV
         w4/2z45Qi+bGy7rA1s/3NUJNnbo1NMi9j0uYa+UrmK83n8Qpn5YZMlS58Ynld5HhQgF8
         EDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyJygmAvNgYlCXg5FRM2hRgcjUEjJ9Xaju1Fs9LLpuU=;
        b=oM5mYlZF8XCiSgudrG1mrNJG3kGX7dKsdVCpNeoUJYq62yQ1FdEDkdb4qgyzLFGnJd
         cE6ef3AxguUtDmmtE0cqYlbar+4vO33Rksyc688tdanxGtOH8USVpcbg6ZU71mjaSZwW
         zAOiRzzaAeK+SzG7er8a4Op/xYd5O0JuBCv0gbWDeIHCT8znniEh/zoQ81w1qAyHImjg
         y67s2JcKp/TBvsl2umD634bUGR93A2Lln2nyBRGcOw2KXKzOMNJwtadNSxRAQWA9FsvC
         ZDNG1JH3FUk08ENKX0nXSREznte3HvwvMEusyFHTmmc1d/6ZdA7fFbRKUYh1uz6K50YB
         4Hgg==
X-Gm-Message-State: AOAM532LAFXnyVBXBvIUf5sVPymzbasTwmAKBtJMfDgfFg5IRtTjm3h4
        MqwWjJvz6PZggnt5G5xBb2sOLRJrPiiYUvLKxKc=
X-Google-Smtp-Source: ABdhPJwXoFbywY8gxuGz4icKbLF1mbamWY0Fv4e+d+QSffi2fe03Epf8ca0A1gr4qjWb7HTpHAE7jAHpsVr54zWvlRE=
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr5598142edw.151.1603999863626;
 Thu, 29 Oct 2020 12:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161736.ACC6E387@viggo.jf.intel.com> <20201007161749.4C56D1F1@viggo.jf.intel.com>
 <20201029081454.GA30442@linux> <99dff0cd-2b1a-2c41-2596-eda7ecc7c160@intel.com>
 <CAHbLzkpfwsR663Kv_16kW81aZ7sLMPQp6WYbqwBBpofq3x0HNg@mail.gmail.com> <20201029190804.GA4205@localhost.localdomain>
In-Reply-To: <20201029190804.GA4205@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Oct 2020 12:30:51 -0700
Message-ID: <CAHbLzkowJQjkqweVg=g_HTS25Nx4U=boeD3bTtVJ1JBdHsBOtQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/9] mm/vmscan: Consider anonymous pages without swap
To:     osalvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kbusch@kernel.org,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:08 PM osalvador <osalvador@suse.de> wrote:
>
> On Thu, Oct 29, 2020 at 08:57:32AM -0700, Yang Shi wrote:
> > IMHO, we don't have to modify those two places at all. They are used
> > to rebalance the anon lru active/inactive ratio even if we did not try
> > to evict anon pages at all, so "total_swap_pages" is used instead of
> > checking swappiness and available swap space.
> >
> > The changes may result in imbalanced anon lru.
>
> I might be missing something, so bear with me.
>
> It is true that since we are only rebalancing the lists, we do not need to
> check for swap space yet, but here we are also adding a new end-point where we
> can migrate to in case of memory pressure.
>
> So in case we can demote pages, it makes sense to proceed with the aging
> and rebalancing regardless of whether we have swap in place, right?

Yes, makes sense. I missed that point.

>
> But maybe the right procedure would be to perform some sort of the
> following check in those two places:
>
>         if (total_swap_pages || can_migrate_to_demote_node)
>                 - proceed_with_rebalancing_or_aging

Looks sane to me.

>
> --
> Oscar Salvador
> SUSE L3
