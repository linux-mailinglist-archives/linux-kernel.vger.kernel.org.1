Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252ED29F0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgJ2P5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgJ2P5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:57:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:57:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p93so3557101edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPnk/G7BX8SIzBEguNflOMTQJEcMKd2LhAeOHUohXx0=;
        b=rpMrco7c8TIn+xeDLi4hUw/J2nDZC1S/yseVOZolm5cwBmWMXh9/I84w1CHoq+iLOy
         QY3YBcqavaSD/pX6kNIGp5Oq1fTAubJXFM3yaXkrYJ3lcYyR/gW87npmYbnu30kXbyCi
         kRgUU9BVdp8yAPaYnp3oSmW2poLHKvpLtLlLxY2vtYJS7P9VLZ3W1ovDJuQvJRxd/JE3
         c5RZQmScQcvTt3NZbrrHwYFGdOxYKot2payT1OwVdJU0+DeqV6ZNvDufPVPQfrD5Br3U
         7ZT4bJd28mJ22FB4N9UiZeEc48BxxTS17rlfGXaRxt8uhL0+kHx9KQZsgbY6wVOSFMEN
         s0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPnk/G7BX8SIzBEguNflOMTQJEcMKd2LhAeOHUohXx0=;
        b=muIENp3OxjJ1mqgKclcL04PcE0fkfVJbs1DB1GX3Re0hY9TXJHvZFVJl82fBuutnHD
         doBiRNXlhTr5TvaNvzXsktlxVFz0gQ16mmyjL2GiCo/lp22VCkPFKJgz+1JfHYajEtzQ
         kKGG0nVj6OwCRHmqrG42LgwvrNnzFAQ1otF8EEY6A/pLcOhRmnPiLzNbqbgX7bcEfAiY
         +hRb55PheRYQMdKwMRAuHrnCE9g592N88GmNhJblc4EcQNuFMpP8D2H7vCwNMaMF+Czk
         ANgX5U7sRKuFzns8jcEGw1yBG2KiHDLhWBnjkaGA3YPqIPjRVKufQYjBrykDsfAHf7wL
         VMrw==
X-Gm-Message-State: AOAM532mFmj3pldmyebjoAHiPUTrh5Ukpc+0TP/xHjmr7AKn2uiTPJTv
        fuXcLDBUv5ZXMvUnQU5eLpyouFlEAdYgBHLJmEA=
X-Google-Smtp-Source: ABdhPJzJt8zjHrjYi/9z5vlQquco3PAqMPP/29FKyDPYEzhWuf/iF4bwR5KUYd7dXJw1vuR4gDnv62+UgHjbfiq5HMQ=
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr4776181edy.168.1603987064744;
 Thu, 29 Oct 2020 08:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161736.ACC6E387@viggo.jf.intel.com> <20201007161749.4C56D1F1@viggo.jf.intel.com>
 <20201029081454.GA30442@linux> <99dff0cd-2b1a-2c41-2596-eda7ecc7c160@intel.com>
In-Reply-To: <99dff0cd-2b1a-2c41-2596-eda7ecc7c160@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Oct 2020 08:57:32 -0700
Message-ID: <CAHbLzkpfwsR663Kv_16kW81aZ7sLMPQp6WYbqwBBpofq3x0HNg@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/9] mm/vmscan: Consider anonymous pages without swap
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
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

On Thu, Oct 29, 2020 at 7:33 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/29/20 1:14 AM, Oscar Salvador wrote:
> > With this patch, we will use always the atomic version
> > get_nr_swap_pages from now on. Is that ok? I guess so, but it might
> > warrant a mention in the changelog?
>
> I _think_ it's OK.  But, you're right that it's a potential behavior
> change that's not mentioned in the changelog.
>
> I'll mention it in the changelog and see if I can dream up any other
> practical implications from this change.

IMHO, we don't have to modify those two places at all. They are used
to rebalance the anon lru active/inactive ratio even if we did not try
to evict anon pages at all, so "total_swap_pages" is used instead of
checking swappiness and available swap space.

The changes may result in imbalanced anon lru.

>
> Thanks for taking a look!
>
