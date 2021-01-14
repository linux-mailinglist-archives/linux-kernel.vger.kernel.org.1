Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D046A2F6CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbhANVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhANVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:12:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:11:33 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f17so8039418ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZbWNTyCdiUNNLsPZb0uOA1PP4wQXROq46k1F1yytJw=;
        b=hen/WPHdi8Ht1TwC4P1EMLL6ADt5dJQsfTqWvojSe7pq3AVL/qQ0ufNnDDHPKoOGSi
         MYVjA4WG9Ppv9qI7iT3VnsqoeJWQREPL+moru7JOkpLRprs9K6Jiq0aRVURVoY5lfYVr
         jLkCnNQivZmx2z41fetvafqYYGLGeUBOPuu18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZbWNTyCdiUNNLsPZb0uOA1PP4wQXROq46k1F1yytJw=;
        b=MiA7aPUxzcK1idHQ5nrb94WNnzzDxT8o4ynwoUKWzzkftlgSrGPJ3hLQb2uKiWtXFB
         QyfIAg1q8mmTa9c/7Gwm7c+O3MlxM4yun72MudAm+34ve/VeLUy4/OLqJSZ/Faa0sQPN
         u3QDuYH/t3coH9XYHqDfVXOg7NnqXpkv9u7YU26ePt8zKEIlpD93ovaxuG+aIE4TmwGf
         UpSVPbIJ9eengJwIMfPxiwFL+KCGxUMgqIBMa0+OpYEgVkdlbRXql3/vxpneRUbiZnXS
         DkaxOnhoG18RxoOZvxRQezqSbSGSBpk4rARSyrDF85v1SebFavvloSWMdEO9uIK2vrp+
         EZkA==
X-Gm-Message-State: AOAM531PE1Q1Mr84OCv3wyXxrbSMN6DGlUVpBvUNFB53/CH/jwwUNocM
        KY6svdYeqpUeyfjMtXKXZZZlixm4Sz75+w==
X-Google-Smtp-Source: ABdhPJwf1Wjd2UtK9NBe+nsIE6tpdodyxX+LqOSSwt2wYEghHTHc2uKXhQYy5kZ22RyML39gO402yQ==
X-Received: by 2002:a2e:80d4:: with SMTP id r20mr3827190ljg.495.1610658691392;
        Thu, 14 Jan 2021 13:11:31 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w15sm660920lfd.95.2021.01.14.13.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 13:11:29 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id e7so8064113ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:11:28 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr3837756ljc.411.1610658688595;
 Thu, 14 Jan 2021 13:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck> <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
 <20210114194129.GA13314@willie-the-truck>
In-Reply-To: <20210114194129.GA13314@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 13:11:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
Message-ID: <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:41 AM Will Deacon <will@kernel.org> wrote:
>
> Sure enough, an arm64 defconfig builds perfectly alright with that change,
> but it really shouldn't. I'm using clang 11.0.5, so I had another go with
> GCC 9.2.1 and bang:

Ok, looks like a clang bug, but a reasonably benign one.

As long as we have sufficient coverage with gcc, we'll get error
reporting in a timely manner for any new incorrect assignments, so I
think we can do that constant anonymous struct even if it does mean
that clang might let some bad cases through (I personally use gcc for
build testing, and then clang for building my boot kernels, so I'd
catch anything x86-64 allmodconfig in my build tests).

And keeping it unnamed it would avoid a lot of noisy churn..

             Linus
