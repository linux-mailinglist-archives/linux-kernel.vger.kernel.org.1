Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0372B0E85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKLTxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKLTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:53:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83907C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:53:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so5532861pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1iBhmRyOD1cXj7AK8WZ6mc3iAS43Zf94bygMHusk1g=;
        b=VD7H2eMaolEM2hAy6QbrMYmG2SMAZvr4V2YF0vvFBOOA+pCrg35xj4TBH0hYECKWMt
         WtETE9ep/pTbK6GLtgdntTy2rCOmZXQEa72PeOULVYBttI/N/dpaIv5uFijvzll6MALS
         jPhWCFan9DlX2baRLytvpIJY5Ci4xCKV2GcT0dOXUCBC9rLBBJJAKd+168mlnGgxPLYh
         oOHGlj+nnDHjTMeX/vwGawzJxCfokUm/+eEbEjrsmr36+j3tJzzhJGq9s+rKofUPbvV1
         cv4O0FqvUsaYe8jI7JVgp3XNPI6BE+vtC9Ovv/hGcgBvkkG/iRElLxxKckSvJzyRVrUn
         OepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1iBhmRyOD1cXj7AK8WZ6mc3iAS43Zf94bygMHusk1g=;
        b=SEywotXq+bmQSUv/etz/bcDT4s1ciffOoqXSeffMCWPCFXz4DXfS+0gdrVE+A02wR9
         6/S+ikf4nw3vIhhSifdn5K52qO1iyZdPzrRa01Hzg6m/EFcAWL5KeexlN6hg96RjHjX8
         6Jj8wqYBXIAFvUl8NMH6CvgOjn6zDBG4P6VV/2zJbDi7M5X3IfW9PC5lLPzzWr7AKGb6
         r+B5HG/Z9pGDOCpoZib0PLyhVJ3p2Zf4yazbXFhHbWkgm3bH4f+JlLIrU1j6oiScrl0G
         jNwOf19M7qmDhj0uaqqyZkgwAq//WUjY1WfdrL4IZZXZ6iPREJ8SJ8qip4xgExn9gcOu
         orDA==
X-Gm-Message-State: AOAM531fpRXrGlpk3oO0dkvxpg19k4gQaqc3To8uqss17DXnB6dumx5+
        YwVboVrpCaKErBrNnAR5mzZ2aQr2Bd7eAh+C8z0KJg==
X-Google-Smtp-Source: ABdhPJxL01n8kb3FhPoY/cSroYBZ2T8yNmnlPc4OiqROq5zV4v83LT8bLUfiz1kIShZ4SP7Ij5O69gyoNXOImDV726s=
X-Received: by 2002:a17:90b:3111:: with SMTP id gc17mr842079pjb.41.1605210786958;
 Thu, 12 Nov 2020 11:53:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
 <20201112113541.GK29613@gaia> <CANpmjNMsxME==wFhk=aSaz19iX4Dj8HBXqjhDg5aG_iR-uk7Cg@mail.gmail.com>
 <20201112125453.GM29613@gaia>
In-Reply-To: <20201112125453.GM29613@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 20:52:55 +0100
Message-ID: <CAAeHK+ycTa2nxg=vOVV_Sfn=w_883VRXYXE6Eb1gE=HXxSD8ow@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Nov 12, 2020 at 1:55 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 12, 2020 at 12:53:58PM +0100, Marco Elver wrote:
> > On Thu, 12 Nov 2020 at 12:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 11:20:15PM +0100, Andrey Konovalov wrote:
> > > > Hardware tag-based KASAN mode is intended to eventually be used in
> > > > production as a security mitigation. Therefore there's a need for finer
> > > > control over KASAN features and for an existence of a kill switch.
> > > >
> > > > This change adds a few boot parameters for hardware tag-based KASAN that
> > > > allow to disable or otherwise control particular KASAN features.
> > > >
> > > > The features that can be controlled are:
> > > >
> > > > 1. Whether KASAN is enabled at all.
> > > > 2. Whether KASAN collects and saves alloc/free stacks.
> > > > 3. Whether KASAN panics on a detected bug or not.
> > > >
> > > > With this change a new boot parameter kasan.mode allows to choose one of
> > > > three main modes:
> > > >
> > > > - kasan.mode=off - KASAN is disabled, no tag checks are performed
> > > > - kasan.mode=prod - only essential production features are enabled
> > > > - kasan.mode=full - all KASAN features are enabled
> > >
> > > Alternative naming if we want to avoid "production" (in case someone
> > > considers MTE to be expensive in a production system):
> > >
> > > - kasan.mode=off
> > > - kasan.mode=on
> > > - kasan.mode=debug
> >
> > I believe this was what it was in RFC, and we had a long discussion on
> > what might be the most intuitive options. Since KASAN is still a
> > debugging tool for the most part, an "on" mode might imply we get all
> > the debugging facilities of regular KASAN. However, this is not the
> > case and misleading. Hence, we decided to be more explicit and avoid
> > "on".
>
> Even better, kasan.mode=fast ;).

Well, it uses sync, so technically it's not as fast as it could be with async :)
