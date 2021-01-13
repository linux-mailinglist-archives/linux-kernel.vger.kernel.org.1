Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066632F49EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbhAMLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbhAMLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68FAC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:20:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x18so889904pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4itm2nFdFTo23gw4YVK9Laikkc7ZPrs4G1cHd0Rl8Ls=;
        b=a9Oq9XAprkYfHTeno/RpjsivMC4RbCA+3vBkjxxyfqFTC71dxJ2G5qR3WgFOT3jBo/
         8pgkarOizjJnjl4QQPw0DmOUrDUoNa7g7H7/dHFrgMJtLhoiy2NAz5B1G/Uf2Z0ymdH1
         dhqIHSIKpt4reg8jmn6//yNnaJIaAavy7ZSQo1m3+TO8NBHbbklUJHg5twUl8OtM687m
         CbXDwukYkh02uPKsGy/vUQZMF8DmcI1aJ/fDfdy2hs8N3w0nFtrBIIAoz/vqAWBcFjuO
         slgy8wfoIY3+c4YszaTJPy4A6Ew6cUMPnmxc6cgnQiy7IECZla5FL/LDzL7B9uKsw3pA
         LUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4itm2nFdFTo23gw4YVK9Laikkc7ZPrs4G1cHd0Rl8Ls=;
        b=mtNPXh3oYEyCU0m/WGEhD/MPBbz2oaezigxTh/Gs0KMLOLSErbzmu9A0Efvfdb4/Qh
         bMG/hM1qbHLWrUxujdmPkDBmtUZRsohZ3NzHmzYo6Pc7RxvZnqGk5IwUnAMgdtX/4YZw
         VeUv9ptvYhtNgZd3Mw/LzEcenDKSC4qiEQPwpXy8noJOuHT5SxCsXwOgDvCX5VeQxm5d
         eap2TTRLPVbI48WE9Z08EopykO7px/1ukfmgVWgPZNsnebEr03IapgZR9O0iVVZgeUYj
         fOgz0MMnB/ecYaZGwjH5Gd6OIJjSI9IiFq4Yiu5UAK6JYQEPYfwWJ8ug1vWX5/6h1zby
         qlMg==
X-Gm-Message-State: AOAM533IKKgT9B/HdzwEpS1VUQ2nIl7rjhyZ2JgDR4Kc7damOd17+coy
        Ny86ci5ViuLD0Ize6tqHe2ETA9HwXjLZluz0TA1/2g==
X-Google-Smtp-Source: ABdhPJyv8BplOZEuDtAFQyPEJVczxKgdzpmehJ9wH/oHDDrs0Yhu/BkS4+qjxB526x/b//CCgcLydpIqQ/wNwUdvZKA=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr1743880plb.34.1610536856321; Wed, 13
 Jan 2021 03:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com> <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
 <20210113103836.GW22493@dhcp22.suse.cz> <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
 <20210113111449.GA26873@linux>
In-Reply-To: <20210113111449.GA26873@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 13 Jan 2021 19:20:17 +0800
Message-ID: <CAMZfGtWn95u2s11MUk33z4MDVec5j4+usRasTqHxRp9Ud73mSA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:15 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jan 13, 2021 at 07:11:06PM +0800, Muchun Song wrote:
> > If there is no task to be scheduled. Here is just a while loop.
> > The cpu_relax is a good thing to insert into busy-wait loops,
> > right?
>
> But if the race window is that small, does it make sense?

Actually, there is one exception. The race window could
become larger. If the page is freed via a workqueue (see
free_huge_page()). In this case, the cpu_relax() can
make sense. Right?

>
> --
> Oscar Salvador
> SUSE L3
