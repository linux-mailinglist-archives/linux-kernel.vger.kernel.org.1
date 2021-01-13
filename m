Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D952F548D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 22:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbhAMVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbhAMVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:09:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C6FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:09:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 23so4832523lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19mOysAs+fTjcD5aUR14g3fjxBQ+jCPuSKPUbQp6pcQ=;
        b=fvAa76vVm4UeUn3/+YKF40BxY0qutgZf+kqrPbuzDLN5YGlXBWuOhJn0J7+Bid5n04
         QalokEw9hIQMVObZsxbp1evtprnNpHgM6G7zxFv96d+3hp+kQfcFKuf92akziTJ61XkD
         DRVAMR574SkGiwj81JKLYNwQD4xs6fVU0FEKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19mOysAs+fTjcD5aUR14g3fjxBQ+jCPuSKPUbQp6pcQ=;
        b=iFilGCDM8I2wAXTP0GdO2nR0qzEH6ftw8NZdVgKJWsw9tMx06HOq4ESBs8NXYY+FbD
         RdkA+CbcS17atRfCGrhiRMVX2P/WBcfmRg0RNsp/ouiO4IF4+wN7FSHhnso5QZcaE8sp
         M1IZwSV54I9IQzlhA1Ulh2ORSayvQG6CFBm4JjdT8NV/8iDTjehdlu/8ZboDXoUke+lw
         GGlqKp2rprcXzGm6M3RO8tMFp9Z76Qc4nDgwoNs3X6JjWOA2vd7aIBovoTShr1BK0CKT
         6JoOvp+klO2smGj0KLA7xrm3XSOBJMbQibq+4P+XT6K9tIDsx5MvFcmbNK1iI9I93xFp
         AeDw==
X-Gm-Message-State: AOAM531wQLUYGbuerG6wa9dyeZkVbwMmCfKy4CgX+5vYz5FCe4eKKAPz
        CP9shJrU91t+rm3lPYryMFUJATVYkuusaA==
X-Google-Smtp-Source: ABdhPJy1ZSx1z11QiJFBsmahvI3/zfob0QOdklmL1xSKwW1xRGELBR4Rt5LNkjW+liFsMLyQykN7XA==
X-Received: by 2002:ac2:58dc:: with SMTP id u28mr1595913lfo.332.1610572189172;
        Wed, 13 Jan 2021 13:09:49 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e9sm320396lfc.253.2021.01.13.13.09.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 13:09:48 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m12so4846811lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:09:47 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr86645lfh.377.1610572187357;
 Wed, 13 Jan 2021 13:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20210113024241.179113-1-ying.huang@intel.com> <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
 <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com>
 <20210113031142.GM35215@casper.infradead.org> <CAC=cRTNMN5Pmz2PC8p3N2-uJkqLUCW95wr=VWTZmodoECmj6nQ@mail.gmail.com>
In-Reply-To: <CAC=cRTNMN5Pmz2PC8p3N2-uJkqLUCW95wr=VWTZmodoECmj6nQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jan 2021 13:09:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3nL28QfkKV6gpVGjh5iPjoEZtEQYPDvwPgscm-yMAfA@mail.gmail.com>
Message-ID: <CAHk-=wh3nL28QfkKV6gpVGjh5iPjoEZtEQYPDvwPgscm-yMAfA@mail.gmail.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection fault handler
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:24 PM huang ying <huang.ying.caritas@gmail.com> wrote:
> >
> > Couldn't we just move it to the tail of the LRU list so it's reclaimed
> > first?  Or is locking going to be a problem here?
>
> Yes.  That's a way to reduce the disturbance to the page reclaiming.
> For LRU lock contention, is it sufficient to use another pagevec?

I wonder if this is really worth it. I'd like to see numbers.

Because in probably 99%+ of all cases, that LRU dance is only going to
hurt and add extra locking overhead and dirty caches.

So I'd like to see some numbers that it actually helps measurably in
whatever paging-heavy case...

            Linus
