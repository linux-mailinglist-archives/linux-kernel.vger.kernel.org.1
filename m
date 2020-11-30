Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BC2C87CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgK3PWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgK3PWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:22:32 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:52 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so10257558pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m8hVr8GdgFLwTXrn/Iee2wivZsDYaXNlqxZl8NLWHAA=;
        b=ELCVyhVM6SaW91j8X0T1x2UIsCrbdsPfOzAPliYSuaSwrnxOgX+SGX/jxM06Q/7H1C
         UKoG+k9klQH9j3UYUXFA6vm3mUC/4tFo7zJNy1sXNIBKCHuosNmK6rk+Ne/Iieo8IEMo
         IzybfXR47403rLvDqYVieF5tWzDTzefIOd8N/MYCl6ky6SknBiaX8AD9u3eif2omo6tp
         HuTm/5oHQx5kPHLQsxJDJY12zZF5xxnQsaWTVY4GNj1m/adZnZ3lDHHoT9cnJBh4olpf
         nYN9tAj4yMMbUVA0LkuZ9KgOXlTIouK7sNatmTCAOcJP65lR5sdbh4XfcYTAbiR0DYfO
         Dajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m8hVr8GdgFLwTXrn/Iee2wivZsDYaXNlqxZl8NLWHAA=;
        b=JjNC0w8ijCL5eGLmXDJDMmlsFHM7aSbjVBGIcl3fFbs7YtPhdeNg4ArQr/sIXKKR13
         66wggZu6V10FlONm0YvfN8rvd23OCh+8iL9F54MM6+3/rPzCSobDEOLyHOdGRnGORw5P
         aYQRtSuPG/lIdSWaNgLtTQyxKb5TCQM2k+p/OCxUnmw7ybZPeMZGJOVzNWg2AagO2aSg
         HaCytD1NEFr+hjVhsjS1W/RDoZ9dGouExKPQEXotRzZfkJCqfgsBSd8ptRaUCC220yM6
         CAvcRUuEcJYLENJOkl98sqxeLzuf84i7lmVVvINszehI8qmpX0J84EY7NmjlcsIl+HiE
         S2lA==
X-Gm-Message-State: AOAM531pV8cPi+Y/8ptVdXqPfutf3I5xzP1wHIeU1w1nD7jxOiRG41BY
        AdRiHnpbscX8O4jUBc+nKdbUYlTubcb/UnYKTEkTjg==
X-Google-Smtp-Source: ABdhPJzU/MrnRtxJJNJyu6XlEnOSNTW5b2zEfe3H4NnqIbhz2tnX+Nm7+Ed6eye3wcI8N83Qi0MqVwutv4qxGR8rNCM=
X-Received: by 2002:a63:f20:: with SMTP id e32mr17954621pgl.130.1606749712100;
 Mon, 30 Nov 2020 07:21:52 -0800 (PST)
MIME-Version: 1.0
References: <35126.1606402815@turing-police> <CANpmjNObtKCG3PPdDRrFczHU3wUnybTqp-F2tMx4CB1T+bThwg@mail.gmail.com>
In-Reply-To: <CANpmjNObtKCG3PPdDRrFczHU3wUnybTqp-F2tMx4CB1T+bThwg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 30 Nov 2020 16:21:41 +0100
Message-ID: <CAAeHK+xn=aOq7vU0FKNDj8txU6y05g-5=mnkcn3RsWJsoPCfFg@mail.gmail.com>
Subject: Re: [PATCH] kasan, mm: fix build issue with asmlinkage
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:46 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 26 Nov 2020 at 16:00, Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.=
edu> wrote:
> > commit 2df573d2ca4c1ce6ea33cb7849222f771e759211
> > Author: Andrey Konovalov <andreyknvl@google.com>
> > Date:   Tue Nov 24 16:45:08 2020 +1100
> >
> >     kasan: shadow declarations only for software modes
> >
> > introduces a build failure when it removed an include for linux/pgtable=
.h
> > It actually only needs linux/linkage.h
> >
> > Test builds on both x86_64 and arm build cleanly
> >
> > Fixes:   2df573d2ca4c ("kasan: shadow declarations only for software mo=
des")
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Probably want to add
>
>   Link: https://lore.kernel.org/linux-arm-kernel/24105.1606397102@turing-=
police/
>
> for more context, too.

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thank you, Valdis!
