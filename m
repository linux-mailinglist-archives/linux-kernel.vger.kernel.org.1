Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108A2BB179
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgKTRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgKTRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:31:31 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:31:30 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so14628494lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lItF3xfzrkMwAcEP2AiG8imrdLGggrsmJi1buDvkPRQ=;
        b=BFMI34mCS8datX5bZPIO32Ia6Z0khqyvljC/F2ipby+FA8y7zjtEPDzufwkKCXsjGY
         0SEsiwdU89ifjQNP6kPAg5YDmJ1pPYqqdG3Ywcja1hlPVrYYsR7s+pMKUtp9768p9l63
         Pt/TtziP5KCnD3DRevsTzPb9SNDDLTK2uFSEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lItF3xfzrkMwAcEP2AiG8imrdLGggrsmJi1buDvkPRQ=;
        b=WhZcfOFdzn4JT6maTOoh1qib0wRKndz08+W3b+60ycxEtzdyKWcSdgf5IXWKHhOypb
         VeSZhsGNcyU6+6RSLNa5+Bf+FfS0ayG35djg3ABclpXwqwVeVltH/6o9GaDMecLoSVsT
         yH4BevVFVXp9R2Dy2P9o8abVYnawAwR/Lr5ZrpJ+dc/0A2ex5cAZsWvEOxQ3z4FCvIVr
         XExMEuxOFAkZIe1mrUe/9biJtmreaYjKGvzZ6KSaBntyNot8RBUePSaxlLe5C3B+ddvC
         iyTDGajVu6DCfpjHuMPng9qR/6+xMuZDMxYeL4iFuaemf0hOsz5giBHG3H4s4MeWbyMC
         68AA==
X-Gm-Message-State: AOAM5315KqrxiktCeZlJSJ0Kc0fK1iZZ3go6etD7EXf6JEPyuYtc5hSn
        Vcwk8Fin+Q/bVtc+ku5cJQQHgL1oRQC8Fw==
X-Google-Smtp-Source: ABdhPJxo8RlwuDvP8dz4QJz/Zl5XAdMU4qCQGPHuxS+221+3Ad2padURPFSxM/IlkoMLM/0I9aLk7g==
X-Received: by 2002:ac2:5199:: with SMTP id u25mr9353629lfi.438.1605893488506;
        Fri, 20 Nov 2020 09:31:28 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id v2sm411065lfn.163.2020.11.20.09.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:31:26 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 142so10843971ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:31:26 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr8866461ljj.312.1605893486061;
 Fri, 20 Nov 2020 09:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20201120143557.6715-1-will@kernel.org> <20201120143557.6715-6-will@kernel.org>
 <CAHk-=wghWFQCW83Xr16C3q+y5xZNM9frH4V9AqauedMEJ1V4wQ@mail.gmail.com>
In-Reply-To: <CAHk-=wghWFQCW83Xr16C3q+y5xZNM9frH4V9AqauedMEJ1V4wQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 09:31:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
Message-ID: <CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com>
Subject: Re: [PATCH 5/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh - wait.

Not ack.

Not because this is wrong, but because I think you should remove the
start/end arguments here too.

The _only_ thing they were used for was that "fullmm" flag, afaik. So
now they no longer make sense.

Hmm?

               Linus

On Fri, Nov 20, 2020 at 9:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 20, 2020 at 6:36 AM Will Deacon <will@kernel.org> wrote:
> >
> > Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
> > entire mm and WARN() if tlb_gather_mmu() is called with an 'end' address
> > greated than TASK_SIZE.
>
> Ack (but with a spello note - "greated").
>
>           Linus
