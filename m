Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4B2F8233
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbhAORZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbhAORZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:25:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0560C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:24:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q4so5033291plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/oQc+fGp9Tgi9OIr+D+9WYXKC5p7WbIvQ4IDqg8DjM=;
        b=SLvWXReUJFuA19tseV8iE4fsyrPy95PTrmhjMMB2cMKMt3YUXhL+k72+wlz5u70/wk
         sVZ+z+719R+QeUEcaz9hkR/l/vjUXUu7WFRHGW5ULymOu0TF4VGyPLc0jpj6vZJ3cdD9
         sN8ETxn1bt424to2KC3xaEzlzuL2+Rd8+GWeMTbYMCkkbtyWvJZCp2QmirawxFwi3xym
         uvjFez/zwyhwDmoEsXUoaJ4j/x2TYn1w86zzbNYTQCm1oQ/GKK/lgdTWSP3gd+KuVA3B
         20FjxGdcs8vUf/GgYVgZZhO1A1L7RucplTN6UT4ufUrPEDDsJbBe/cHk31xMg27SqQmO
         kkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/oQc+fGp9Tgi9OIr+D+9WYXKC5p7WbIvQ4IDqg8DjM=;
        b=qDlWu+/e4RlV4ZvRhEFbQ6UnzcdL/SrdOP/6ChpRIheiQgWggo2egzvUqG1f3Xf946
         IRvUhNMXNGdl0YnzjnvkY24BvjU0lj2WD/cMhhkYTvE/MNRZPeDLC0URYVndaLz4s4qu
         /o6M+L8ldFBK2NsuBEd6EK1PBeiusixQQBX3A9NWI+M3XBbVXeWRgenblvXKmLsCk079
         L5q0IA9JeSoxjKGirVnYJ/SN/3B8MkzFauDkWlKKzYFgUBg6RiGvfAm4CAeOAzkdQgVJ
         toBjd/xmIwqVcR8lji2UEsZnFtUqim7/PzjUO84lv4Mio1D30ERpoFLI4Of8bu61v9Zb
         +Dkw==
X-Gm-Message-State: AOAM532ifBPnw0qBaCNbwhRanVN+HtNFp7ZjdjtEi9rl1Xbhlmh+r7MS
        7vaVRGV6ONa1J9FlIiSYx5t+JQwAMDiQFwkpmV7WSA==
X-Google-Smtp-Source: ABdhPJyfi32Dmk+jhyBuYTt6XEyQJW1LIILK9kDmM7xC6t+DsBpWdpWTg09eZ3U/YuqSTmYaTWfiUEV5C4yWhN8V6vk=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr11401064pjb.41.1610731473330;
 Fri, 15 Jan 2021 09:24:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <b75320408b90f18e369a464c446b6969c2afb06c.1610652890.git.andreyknvl@google.com>
 <YAGVqisrGwZfRRQU@elver.google.com> <CAG_fn=XnF1GmOsJbHNtH0nn3yXq5bghYDXDkeqawEXTzom8+sg@mail.gmail.com>
In-Reply-To: <CAG_fn=XnF1GmOsJbHNtH0nn3yXq5bghYDXDkeqawEXTzom8+sg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 18:24:22 +0100
Message-ID: <CAAeHK+ykOaVSETLAZD_EzFf9Q=REGTMfwQtEEVMg-NE62EGogg@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] kasan: add a test for kmem_cache_alloc/free_bulk
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:49 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 2:16 PM Marco Elver <elver@google.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> > > Add a test for kmem_cache_alloc/free_bulk to make sure there are no
> > > false-positives when these functions are used.
> > >
> > > Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> (see a nit below)
>
> > > +     cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
> Looks like there's a tab between "test_cache" and size, please double-check.

Indeed, thanks for noticing! Will fix.
