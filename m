Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39326F982
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIRJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgIRJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:44:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D77C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:44:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so4868415wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LO/JMXpkI2PbHh8j0Ay5k/YAYJdyl7P+uRkiEmvpGOA=;
        b=sgJDFSBwBWkR4r6tUV31bj4R0AUbSy0wtklvn5xEw2vvcYwAGXSY7CjqOcb+me2W2E
         HCjXlUeYMSLimOkA2DEmMxyh0g+7IIaeABsxVKExMTdqDQnJZ9fhb2ZmkECu2vSrqjRC
         LxgRp5gHjRnvdrKtIG+sr5IQdoMwok9Q81IbIx3QMEHyTbM34Uu7uwUnnG99BfXU+36W
         FHQnUz4PaqJZRkwxq62zpdcYvkXSH8w3lqER26ZxkIzi5SGkKGYDf5cbsOxpvVuaAr8h
         rZRqv137Xt2xILlIP553KGh4xeG81xYMb/c6h299ZX/wlKeT6q80w9EoxZnDY7NeaAS5
         lwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LO/JMXpkI2PbHh8j0Ay5k/YAYJdyl7P+uRkiEmvpGOA=;
        b=qOBSH8vlE1lPE1osmpyL3k9Ngul6VdauftmbJJ/xIWAbrQZLdrmubwsCKfWBIbWbzR
         IQH9hrB6hApG9DdtgkJeFEOfXqGzbMgpjbW4M6sJjhKxvKkGKsjJy8df3wRyFiK6k1fu
         WrZeJOXnHvbxTJTKP6DAtPLVOaTzlP7OEtVhBxnN7eAmNdzSTylm8RegS2gpyBpuw463
         d6PgJxgOIqWez4gfqOLZUGjy1oDPCE0I04S8/RPSGVxxV5RJop1mVrEzKqX4+yMN0Kq1
         UQnIUs83dRIxaCQrCmF9KE91tsgY9xzdcO9iwOB+OI/q8TUOeHcGXkh53SniQAeEAWcq
         SbiA==
X-Gm-Message-State: AOAM530Lph6dj3G2YzqpAiQ5VcIOi0fYjtweNmaCtzwdascL0s0FTKDm
        FR9eE5MLoij14ooFCO/TqcPSvbXb2V9KK1qmsJnsog==
X-Google-Smtp-Source: ABdhPJxPu/JsT3aBHGWsZ+LNZb9BB6Ax2CHDkSAmGDKE0bo1brBQseXtrCYgLaGeTibTZojfKGrx0Dsz4otWuJoOhps=
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr15304732wmk.165.1600422294758;
 Fri, 18 Sep 2020 02:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <28d17537bbd029104cf7de4f7ca92246449efa50.1600204505.git.andreyknvl@google.com>
 <CAG_fn=UACdKuiKq7qkTNM=QHcZ=u4nwfn7ESSPMeWmFXidAVag@mail.gmail.com>
In-Reply-To: <CAG_fn=UACdKuiKq7qkTNM=QHcZ=u4nwfn7ESSPMeWmFXidAVag@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Sep 2020 11:44:43 +0200
Message-ID: <CAG_fn=V2MT9EfS1j-qkRX-TdH4oQxRbRcBYr8G+PV11KJBO26g@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] kasan: rename tags.c to tags_sw.c
To:     Andrey Konovalov <andreyknvl@google.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 11:41 AM Alexander Potapenko <glider@google.com> wr=
ote:
>
> On Tue, Sep 15, 2020 at 11:17 PM Andrey Konovalov <andreyknvl@google.com>=
 wrote:
> >
> > This is a preparatory commit for the upcoming addition of a new hardwar=
e
> > tag-based (MTE-based) KASAN mode.
> >
> > Hardware tag-based KASAN will also be using tag-based approach, so rena=
me
> > tags.c to tags_sw.c and report_tags.c to report_tags_sw.c to avoid
> > confusion once the new mode is added
>
> I find it a bit excessive renaming the same file twice in the same
> patch series (tags_report.c -> report_tags.c -> report_tags_sw.c)

Also, as we are going to have CONFIG_KASAN_{SW,HW}_TAGS, won't it be
better to call the files {report_,}tags_{sw,hw}.c ?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
