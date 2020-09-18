Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EB26FAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:42:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82040C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:42:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so3221917pgo.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyCshTFjDIofsUJ8ZxHei4ByPrM8q28xDy+Y4pUMZwI=;
        b=HQLdYPkqoY7K2S5IBuxqdsVTewZZQJ4Ds28hOdnNdWl04OKsnUg3zZrlRkE9IA5xVR
         nXxB7V82SN5Z/xRHWNR8C87xGv5zecItvYeH8InqPETlE/YWa4702cmV8vLSgFOvLyQO
         i9n6yPPun9zF2L6b5tFbMyUqBk9kPaQzqDW7LP2clRn7oXKs4Uo6h6v10y+cVDSHDUFe
         otR/IP48BAc+Xz+HD8Nld99FDxznV64pX0c+ERdyYTvyMcByqWOusJwRsDtG/b2JPR03
         XtILvqfKh8LHIgCPHsxsPmIefSsWaPkfYL0DtRx9uidwBkhxIMUSr3GT96+Cnf6Z6H0g
         hFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyCshTFjDIofsUJ8ZxHei4ByPrM8q28xDy+Y4pUMZwI=;
        b=oFtUC8ro3apHT1KwqzsmpeJIrtwMIYMIX0i+huJ167EtEW4Q2VJ2KNmfN+MD/X4xZo
         uGzA02xCASyZdmAEQP5/xfjp37LGT9OliA9MTNXEXvbXMdChFsDk+UwYRsqd894E5xk1
         faP6T2wHgVTE91fYQodW14huALjw1omxnZqjrf09xlVAzsTO25yqivY9OiRSLmaF1CNg
         wYqbegGkcwsvP+a1Sf3t4/SqlQkOBzpmWQ+Colz8uicAM0JxTr+fAXQPOT5eZ7AxfMkV
         CbAWIkAeoi4bDleEf1bbJLySzbowyh6PsfGAgpnzAf6SCLD2K7odLFbM9xvBn0DGs3UJ
         0zqA==
X-Gm-Message-State: AOAM530XievpQaMdJpiRScurMGXrtzgZYfaEnj0Ujuyb8hRunUH/OGOC
        2+tYNq2/Truh/rY6EGv3089/NHi2K3CEzFoGHdvKkA==
X-Google-Smtp-Source: ABdhPJwY1J3Bu6wu/lCfq/F4Kpenneqddqj6TWLs4iupPBHItJRndVpm2K20+GsYv9s6MavZ73OvEdFKGdY8I6ot4W8=
X-Received: by 2002:a62:38ce:0:b029:138:838f:dd53 with SMTP id
 f197-20020a6238ce0000b0290138838fdd53mr29677349pfa.2.1600425733832; Fri, 18
 Sep 2020 03:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
 <CAG_fn=UACdKuiKq7qkTNM=QHcZ=u4nwfn7ESSPMeWmFXidAVag@mail.gmail.com>
 <CAG_fn=V2MT9EfS1j-qkRX-TdH4oQxRbRcBYr8G+PV11KJBO26g@mail.gmail.com> <CAG_fn=WpOoAf4t1iKrWcD+LBaCvL6tf_QYeqoX65UWPi92h=6Q@mail.gmail.com>
In-Reply-To: <CAG_fn=WpOoAf4t1iKrWcD+LBaCvL6tf_QYeqoX65UWPi92h=6Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 12:42:02 +0200
Message-ID: <CAAeHK+yHUXphDsgA=BT8GZNNZ_RQTe95dZo3jDGHm7_LrSw4Ug@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] kasan: rename tags.c to tags_sw.c
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 11:46 AM Alexander Potapenko <glider@google.com> wrote:
>
> > Also, as we are going to have CONFIG_KASAN_{SW,HW}_TAGS, won't it be
> > better to call the files {report_,}tags_{sw,hw}.c ?
>
> Sorry for the typo, I meant "{report_,}{sw,hw}_tags.c, mirroring the
> config names.

The idea here was to have common prefixes for similar parts, therefore
I put "tags" first, so "tags_sw.c" comes next to "tags_hw.c" when one
is running "ls". But I can rename them if you think it makes sense.
