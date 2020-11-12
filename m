Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D342B0473
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKLLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgKLLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:54:10 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB609C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:54:10 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so6096574oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1o9Kbu1VGM16HQ/aEUEXh5dMeJ0YbhrbAtdFyS8sHt8=;
        b=qyNRVH7uRoGzThfKw483bERogXvPswmjZdEz5MJBQOAA8C1JUzh65WV1lhObwodn73
         suo5Yk0UnhRryemiUBMfN6y6/HUGHEHda0SV/CsOo5SR5XONFZ1F5GNNqL5jm4BcKL1B
         8gYZAG9ef4GSkHW4Co/gIBaBefKRGAJpesJ2IH4rX7EQ76gaclcRcNFMOp/zEcZkv3Kq
         yppNW/4xzLclkPK7JYaeDxEtKHHslLCdoJMgyxbuPOAPQr/sDdYtgOQHFcKPBkV8W6LM
         ozxpOka/pOr7VY0UBS3tl5PGcqaJhljMlLL0Okb5srW7n9Xs7ygh024NH1UCzeNuiNnD
         PpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1o9Kbu1VGM16HQ/aEUEXh5dMeJ0YbhrbAtdFyS8sHt8=;
        b=QNOeyqjx7CrZ+2IrPQ9YBK3XOpzdd0G5D9KxavMCy2rO4/S8HQUJmxEcryHPoV5KYo
         YsNCHa49CRwj9YqckauK7J7kM3gKVCJMm02r7MsFIl5NLG+SYZyaZbT5YOn2YOBHLu2F
         Zz/N2gLCxhRW0+ATsxPXHP9xCy04wbgrsm9YPrZGR/GwZSX+DHurU6mmN1mVx2ZTv9iz
         uunaWtL7M2yZp0p4FkQSBFc8euofyMaaWTKVJb++YlyWWz0oT5YkzwpgPGEru1lNu3Jd
         vp1nEpylSGGie6+VCSfLYek1WnooZDME++YwBh4FROO0orbwnHcUJK/mEE81SQIoqV9F
         ZpBg==
X-Gm-Message-State: AOAM531fwIzEj0ISusyg4D9bs5a73989J9KEit9zoD1POg+QMms+c6ne
        xlcHMdmJBuwraGOuNpNXAMJUv73MHH1v2SvF+J9Z7w==
X-Google-Smtp-Source: ABdhPJzw0WWPF3x4VWyvJ/ZtTENi7KPBKfvDdxy5eksYbb8mHqBCAuDM5Y0bFcDPklnH9Xhdo7Aj5DJw9dg6jSrxzrc=
X-Received: by 2002:aca:a988:: with SMTP id s130mr5397138oie.172.1605182049579;
 Thu, 12 Nov 2020 03:54:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
 <20201112113541.GK29613@gaia>
In-Reply-To: <20201112113541.GK29613@gaia>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Nov 2020 12:53:58 +0100
Message-ID: <CANpmjNMsxME==wFhk=aSaz19iX4Dj8HBXqjhDg5aG_iR-uk7Cg@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 12:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20:15PM +0100, Andrey Konovalov wrote:
> > Hardware tag-based KASAN mode is intended to eventually be used in
> > production as a security mitigation. Therefore there's a need for finer
> > control over KASAN features and for an existence of a kill switch.
> >
> > This change adds a few boot parameters for hardware tag-based KASAN that
> > allow to disable or otherwise control particular KASAN features.
> >
> > The features that can be controlled are:
> >
> > 1. Whether KASAN is enabled at all.
> > 2. Whether KASAN collects and saves alloc/free stacks.
> > 3. Whether KASAN panics on a detected bug or not.
> >
> > With this change a new boot parameter kasan.mode allows to choose one of
> > three main modes:
> >
> > - kasan.mode=off - KASAN is disabled, no tag checks are performed
> > - kasan.mode=prod - only essential production features are enabled
> > - kasan.mode=full - all KASAN features are enabled
>
> Alternative naming if we want to avoid "production" (in case someone
> considers MTE to be expensive in a production system):
>
> - kasan.mode=off
> - kasan.mode=on
> - kasan.mode=debug

I believe this was what it was in RFC, and we had a long discussion on
what might be the most intuitive options. Since KASAN is still a
debugging tool for the most part, an "on" mode might imply we get all
the debugging facilities of regular KASAN. However, this is not the
case and misleading. Hence, we decided to be more explicit and avoid
"on".

> Anyway, whatever you prefer is fine by me:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
