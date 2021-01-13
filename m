Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3961A2F5050
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbhAMQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbhAMQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:46:45 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:46:04 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id et9so1028978qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMjUDnqe142kyL4JCtMxq/r9cprLrjt9yzIWhPD32rs=;
        b=ZCXXS7+IQX+b5nnhGPIxaiG4vxWmLBUnCaGXoia/IrlW+pr8JOybw/OiHhirlzQmi9
         1cGmQBedk65vzPaQc7HsJA8sZXvsBMTTjfcZ7HYwobg4U2iZeQQNdNrK9lwSuIqzP+/v
         7o4kRmmI5rBkjwk2xj6ggane7SBrtqSPqtUVUvFylKzHB20aK6Vt5T1fSHRKboJdd5av
         y86XJdr3bNMTCh4AdrCBGxPHJ/icQoJDUSks2+sk0/PW4jmS/AYgzj2sTB6SN0p/c08t
         01k9FoxPcW3uL74WjstRU0BHl1uvtlIDdFJHtalHU1FIS620Ie+sZ7kN8TGK6CyU8Mpx
         l2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMjUDnqe142kyL4JCtMxq/r9cprLrjt9yzIWhPD32rs=;
        b=rNJFN5S2DPJNF3tk0aYN2iwIK90oCNIviw/Gb+qV7A/6n4R3s0Tobwf02yZm7AOKiM
         UUfqo0EE1jVHfW00T0IF/XhPDLu7y9bZZu2Y4busfC/tvnoiVj1EhnYGyjrz0OuGy2r3
         qCoP+mdXz6mKOViYoM+FB/sh8nk+6Wps+fsHnkL0hCZJBboWsSMi+7+IjMqzmsCqLmt7
         ZD97r5lzlC+TKTMEONda5dH7u2p/PiEWYJfck2n/7PLZpFB/ls/3sWgikgDAwtuEGMuY
         9wI0vXEYuXSueSUF6su7Yw7sLZ8Gt/n3tvKskAJKwX13Y/xlMWnMIrLDd9L9zfPuSgcZ
         jl8w==
X-Gm-Message-State: AOAM532HhlkN7P5xiV6y4t2j3jTgcUp9iROqgXoi5NnE+WIePNpQ7k7d
        lhMfzL7tigOmr7QRz1zZ2DCuJk0Y0HgAyntEoUuf8A==
X-Google-Smtp-Source: ABdhPJxzxw8dQlb/DvTgDHgtWbnIpOb5DgpvDx26bl6WZOMm+powQlw+Di/sx50x4LksnyBFB4e9ftV1RG4WgzeRw/4=
X-Received: by 2002:a0c:e90a:: with SMTP id a10mr3297670qvo.38.1610556363951;
 Wed, 13 Jan 2021 08:46:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <0afed913e43017575794de0777b15ef6b2bdd486.1610554432.git.andreyknvl@google.com>
 <CANpmjNMZHiwKDTyBdHzHB6CexJTfN9TUjk=q6zmj_nebtq9=mg@mail.gmail.com>
In-Reply-To: <CANpmjNMZHiwKDTyBdHzHB6CexJTfN9TUjk=q6zmj_nebtq9=mg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 13 Jan 2021 17:45:52 +0100
Message-ID: <CAG_fn=Ur17=N-Unsi4CdSnx-Qnfjuh1d__zKOHPUAC-3RLHV3w@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] kasan: add macros to simplify checking test constraints
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Jan 13, 2021 at 5:25 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 13 Jan 2021 at 17:21, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Some KASAN tests require specific kernel configs to be enabled.
> > Instead of copy-pasting the checks for these configs add a few helper
> > macros and use them.
> >
> > Link: https://linux-review.googlesource.com/id/I237484a7fddfedf4a4aae9cc61ecbcdbe85a0a63
> > Suggested-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Nice!
>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
