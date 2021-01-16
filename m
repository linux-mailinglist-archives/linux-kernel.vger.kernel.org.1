Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BA2F8DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbhAPRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbhAPRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1DDC0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:09:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p18so7917088pgm.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFVX+DeCBEJmZ4NDpg1ld7xFOp/fCxGCVOO/JOHrLKI=;
        b=vYrM/XUA5E/W7pTWUsoSVJZGO0cH0ZnaciHWyRWJDJnfdHau8ffPSBso/eSffHct1E
         XFhhsx0QmaUjUB5pMsbeKN3Dc/xLN+ich345UnOPVQ4vrU0qU9pKOB3YgQszKRhMNuKZ
         YDcgLEn8a9x9+U+EOt6a+3dIybtRhHUCvGMDS0dTGbtgCoZALsfFm3/6AqzUlfvCODjz
         0ftwWXYiAByHd4DPex8y2xCgG4CF24ALF0gLvhAotT9UjQL4S+Y4ct55YWLdQglXwqXb
         i3uuKtvhD67M/g3MB0Q0mbcwVBBs3TJD6x6pr19fSZhqFDQ70vyWnmrg51vmuJ640+xB
         i2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFVX+DeCBEJmZ4NDpg1ld7xFOp/fCxGCVOO/JOHrLKI=;
        b=G66mxBpWW1/6tUCY5/Vuet4ZYHj1Uz54V+hZnaHbnzedtxMux8YuwRIGjkki9a4pKj
         vMInIcZBzBHwzqnWZDfEokTLGGEbYsSAOsfAD3d4gNfhJcxQK6sO8a17ZMbPViYOFFlS
         nIor+rHk9Rk2ne3R23WOEIcw1jD61midwS2hWAraAxnZ/QQouxmHuhJFDPzN0HXGLYjm
         uxRn3be1a2/lyyCer1FOAi3qUVfWuGCfKe4eaC7uO6Yopi0zjKMEtn3t1vZYojGHsxHg
         3razkZvieBfdYzvy6H6+Z9WhKsxmVM9jtZho55osazKubktZCPNenklb/rd4TkURrAi9
         VCTw==
X-Gm-Message-State: AOAM531yoJMy7mne/bGLA8EHti1w/q1WRqyFhDRoH323JY3TETBfq3Ck
        o6cneCCDVMnwLyOoq4EN+gWB+4Nz0CQoAQuM4eUtKw==
X-Google-Smtp-Source: ABdhPJzxdtpsdiFJAHgXDYTuSblCWSFnVEpEbMOPFJdf5Wj8VoBnnbuidyYX7xTzXxq3AWASW42S//c3dmTwPZiuj8o=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr17504790pfh.24.1610806182375; Sat, 16
 Jan 2021 06:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com> <20210115150811.GA44111@C02TD0UTHF1T.local>
 <ba23ab9b-8f49-bdb7-87d8-3eb99ddf54b6@arm.com>
In-Reply-To: <ba23ab9b-8f49-bdb7-87d8-3eb99ddf54b6@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Sat, 16 Jan 2021 15:09:31 +0100
Message-ID: <CAAeHK+x36J6a4GOpEpff0BKwCKgFTuRsGiyXyScRek3hVAbSJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 2:43 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 1/15/21 3:08 PM, Mark Rutland wrote:
> > On Fri, Jan 15, 2021 at 12:00:40PM +0000, Vincenzo Frascino wrote:
> >> Architectures supported by KASAN HW can provide a light mode of
> >> execution. On an MTE enabled arm64 hw for example this can be identified
> >> with the asynch mode of execution.
> >> In this mode, if a tag check fault occurs, the TFSR_EL1 register is
> >> updated asynchronously. The kernel checks the corresponding bits
> >> periodically.
> >
> > What's the expected usage of this relative to prod, given that this has
> > to be chosen at boot time? When/where is this expected to be used
> > relative to prod mode?

Hi Mark,

Sync + no panic (what is called prod right now) + logging is for the
initial MTE integration stage as causing panics is risky. There's no
way to know how often MTE-detected bugs will happen during normal
usage as the kernel is buggy.

Eventually, we're hoping to switch to sync + panic to allow MTE to act
as a security mitigation. For devices where the slowdown caused by
sync is untolerable, there'll be an option to use async, which is
significantly faster. The exact perf numbers are yet to be measured
properly, I'll share them with one of the future patches.

Thanks!
