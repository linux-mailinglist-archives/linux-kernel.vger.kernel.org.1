Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0609270A47
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgISCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgISCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:53:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE202C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 19:53:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so8652522qkd.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hoAhHDzq/SLuBLbuMh1HEUQHDSft8kw1VcPB/+ozFJE=;
        b=Hy3jke9Cj4flJUNpP5g32NhzM37SteMA15yYutV3tfppHSWK0wnNR7043F8xxSygR6
         z+gIrFr8lobp5D/etEgBm65+SOvNCafbrQwK0KDQuU4K9VTWXHqXyZfvTWb/jOAPnKKk
         G528pi1cx1c5lEJUDgiRWZIMY4ehSVIaehluZrvWgFlWVIYuosKljf13mo9n58IWbFx5
         C1lfsq1W1/pQbrf/E0eJ+p9DHd4wsg7Y7OQ+7r99ySNYlNyolPj24LFG2dg0UlEACtR9
         mnu9KEjmyrA2bLDWja6Eli3Sm379SP8FlxYjJJm0v4xRrUhXUHk0NeZK9iFzp+la7c2J
         /aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hoAhHDzq/SLuBLbuMh1HEUQHDSft8kw1VcPB/+ozFJE=;
        b=r4FHg4XppvPtNdyGNVxNm5foDs9f819RmmUEPlnEdITw5wuVeO5C/hByCgYS1+8qpR
         2Ah7GmyeJ3UxB+GofZl0ErLetZvqh1A1LtEfkb+6U4PZvs0BJkf8J9RD39zq9zvmi8QH
         PrRj/zPzfBSDCWQt50vq33GNf4qOJ+RAbn/XiJkBtvCM8ZSVUvjgYpKitj6dNWIfe6P+
         cyz61QibG6b35M6NIBYfgxjO6JxUeZu3hk21t/MtRu9+MC5Arurr9+ucloTVgrvLChaR
         sIv5WA2Fzt1HLzhy89y4M2KoR6DQId5kwEwfJ8hMCoY0VIdLqi/md564cof+1plxZPLU
         7URA==
X-Gm-Message-State: AOAM530AnudFIyHWOds6PQeX5G9FuiA941wvQOGyErXnvKRneYmyTaVi
        JAap3SteB3EO+AijyM2GmkO+Riwjw10=
X-Google-Smtp-Source: ABdhPJxydkfObOrADPvitjEWYXj5F5HEhxQpJN2UI9lCoKyZ9nnnXbTFR9809E7NoDs5U79Hxk0e0w==
X-Received: by 2002:ae9:e601:: with SMTP id z1mr34011034qkf.1.1600484018738;
        Fri, 18 Sep 2020 19:53:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l5sm3643806qtc.28.2020.09.18.19.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 19:53:38 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 18 Sep 2020 22:53:36 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200919025336.GA3008405@rani.riverdale.lan>
References: <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
 <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:28:30PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 3:40 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Ouch, offsetof() and sizeof() will give different results in the
> > presence of alignment padding.
> 
> Indeed. But from an allocation standpoint, the offsetof()+size is I
> think the correct size. The padding at the end makes very little sense
> for something like "struct_size()".

I just meant that my suggestion doesn't actually work to assert that you
passed in the flexible array member to struct_size(), even outside of
any future warnings on sizeof().

And that it's another source of subtle bugs, although you'll err towards
over-allocating memory rather than under-allocating by using sizeof().

Is it ever necessary to allocate _at least_ sizeof() even if
offsetof()+size is smaller?

> 
> Padding at the end is required for sizeof() for a very simple reason:
> arrays.  The "sizeof()" needs to be aligned to the alignment of the
> entry, because if it isn't, then the standard C array traversal
> doesn't work.
> 
> But you cannot sanely have arrays of these structures of variable size
> entries either - even if standard C cheerfully allows you to declare
> them (again: it will not behave like a variable sized array, it will
> behave like a zero-sized one).

I think you can't do this in standard C. It's a GCC extension.

	A structure containing a flexible array member, or a union
	containing such a structure (possibly recursively), may not be a
	member of a structure or an element of an array. (However, these
	uses are permitted by GCC as extensions.)

