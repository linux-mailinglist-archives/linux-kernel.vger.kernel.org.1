Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E341E28EB58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgJOC6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJOC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:58:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 19:58:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t25so1364811ejd.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL6HuqJW06phVnw3mPFDKmfWuZ0ko+HQIaeKJ1vcwYc=;
        b=BYEBqyoLH1GANcqjolripzDT1wKh68zJ/cc8tX1NQbosRFYNrg6A+uIe8U+q6owKIc
         X+Mx7D3y6mqp46DhWyW9UPln0mLOY0AtRfSjS2fk0d/dklnxzmz+yB6ZCj8Svo6g853p
         UEwtZeaYbviZ9JJcVvRBdY5YF5fww5meEc9vuXyh5lGtyWOWITJhXazW4TlOvTHm7j8t
         k3kQNfw8Ni9cZ1EYunLTCI/fBt1nPoSMm7M4S23aafoioSpLIRnKoz5f36uHYMxIzolF
         3T/PN5FDVWGJnDW0rtSvoVDCaWuLJACqEB3usZgb8LM+VSOE1pI1+H3d0Alj+lyIKoW3
         7YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL6HuqJW06phVnw3mPFDKmfWuZ0ko+HQIaeKJ1vcwYc=;
        b=q3IOlUr3z2BRr+/SaL6k0SdBQgGmDXmEkB7ZHRZHqfnYGU91HZzwo11I616faup9RG
         s9g3PMmJDmlIZO+ZVj9EEUxWHQkC7h1KC7zKjtRVFDxeJmk5617RlS+w85/c4nuvIX69
         3cBF/7f8KzoDwI7cXVa662vhiqeYvd4ZpM5x83tiPCOqkeFeD9ABFyu9pqlgd8VHuc7B
         6RsJI1HMFO1yLHVrYLGIi/G9zr1cfdz1hz4WholT99Yl/gkizReNMKCZ7uzzRHvqgYmV
         dy6jmup+5tz2GLWW+/LTvdxrLDH7W1maAyGZcdnnoGWDmzBx2EiEeeA/ijsnUV4qh2XD
         cBKg==
X-Gm-Message-State: AOAM532x37g9Kky0PJvVv25nqrBVXUtSMj6Ah8raM5/mYaw+PAsTIogw
        cUMoA/ShHcnezk+c3ryc+rpG5FMvtcoAgRpf80w=
X-Google-Smtp-Source: ABdhPJx9bDtPAnw1NcNpEmtyrGVXwwQvIXyQ9tlgU5BeYUKeXJZVCkFDXbqwqmWmdWV8X2Grt0sYVWeidfXyia2dWiA=
X-Received: by 2002:a17:906:3650:: with SMTP id r16mr2158378ejb.419.1602730717888;
 Wed, 14 Oct 2020 19:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
In-Reply-To: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 15 Oct 2020 12:58:26 +1000
Message-ID: <CAPM=9tzyZ3sxM4K40+dpm-eL=+QyN6RTj3HaJgD=HU5MCiKqjg@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 at 11:33, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This is the main drm pull request for 5.10.
>
> Not a major amount of change, the i915 trees got split into display
> and gt trees to better facilitate higher level review, and there's a
> major refactoring of i915 GEM locking to use more core kernel concepts
> (like ww-mutexes). msm gets per-process pagetables, older AMD SI cards
> get DC support, nouveau got a bump in displayport support with common
> code extraction from i915.
>
> There are a bunch of conflicts but none of them seemed overly scary,
> and sfr has provided resolutions for them all. I've put a tree up with
> my merge results, so you can tell me I did it wrong here:
> https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next-5.10-merged

Apparently I lied, and I only built my merged tree on x86

https://lore.kernel.org/dri-devel/20201015134357.0a4e61b3@canb.auug.org.au/T/#t

Please apply the patch from this thread once you merge my tree.

Dave.
