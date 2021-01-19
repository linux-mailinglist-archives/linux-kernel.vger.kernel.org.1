Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB02FBEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392483AbhASSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392569AbhASSNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:13:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:12:23 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so10958999plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGbRgtl+Xd7NnNyvzbFz33TQ6zZwYmuEBrx6vdWmM7w=;
        b=uTCh6cTUQ3XE47LM0eMIuoE/GdPoJeTZ45hU0Bpqt8WbI8TJkaMX+XFhiGPVV/gE5Q
         bGnBAI2ROPIZ58VKuh+c0xvYKjQZ53sB8OzLoqhag/9inhgyOo0NVB8vOzweiYB9p+4J
         W6whNIGREJDN6AcX03G09m3vXbE4JK0edcSCWXD+rco9zWJpolWlNg/ZoTYn+xilq2as
         gho4LGra0Z2+J1Fv8GUM4bJ/gRDZGbCQxWiT9cwkzRI5QnINnDh+XoEWFNlp6e5nbviU
         NcgqVh5ivwErJGv8xs8ekw0bcKBacl0iaZ70qTcw9IEfT+h8a18Flix0rL4ZslVyX/p4
         ef6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGbRgtl+Xd7NnNyvzbFz33TQ6zZwYmuEBrx6vdWmM7w=;
        b=K3I5HnJ+UgTnBcMOoXhQi4j0EXG472vz3uQ7yxj520fSsNM7OM2Bves5pmm7dJyeR7
         aaOk91PK2d0UC518tYZ01C0oQvCbfdrbQWeUkNENerVkZ/BuSoNzwFJxwJl+c0+KY7NY
         UUqL8X1s1LkdEX15SONz4LUdg9eEcEjUs5IYsbhcJW/m+ekbJ1Mc+pz38/+UJLkfAmPa
         8bVRFV7oJ8hD4bdmTTW+WwTOs1rQwEXvNfz14kZwF1I0aWG3pY59IdDn+W31dqZI++Ou
         mNahX3tIFzywizGTRs28DZaw5LOLa8DmkZ4NEdqTsYm1yga7yKeAF68x7kWSufYQ6xVI
         mrmw==
X-Gm-Message-State: AOAM533WYoWI+ToVeYX5SIXCsW0NlD/jErVmR8MKDVzoGNFXexfD132T
        SPUFSDS4I/lk7PxY2fbCLpj3i+6KbZyV8DFpCERGHA==
X-Google-Smtp-Source: ABdhPJzBasDVEG6vdysTxWNctZueWMzAYRygGHyEkpY748jJPjW7ukdkNgObxdsRFxvPhYSz1R4jbuYeShW3H3ks1V0=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr6013728ple.85.1611079942969; Tue, 19
 Jan 2021 10:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-4-vincenzo.frascino@arm.com> <20210119130440.GC17369@gaia>
 <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com> <20210119144625.GB2338@C02TD0UTHF1T.local>
In-Reply-To: <20210119144625.GB2338@C02TD0UTHF1T.local>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:12:11 +0100
Message-ID: <CAAeHK+wcWk_URtGROUc1VLR4PjVQChCUpSLFya9DNTytQP2mVg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] kasan: Add report for async mode
To:     Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 3:46 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Given there's no information available, I think it's simpler and
> preferable to handle the logging separately, as is done for
> kasan_report_invalid_free(). For example, we could do something roughly
> like:
>
> void kasan_report_async(void)
> {
>         unsigned long flags;
>
>         start_report(&flags);
>         pr_err("BUG: KASAN: Tag mismatch detected asynchronously\n");

"BUG: KASAN: invalid-access"

It also might make sense to pass the ip, even though it's not exactly
related to the access:

pr_err("BUG: KASAN: invalid-access in %pS\n", (void *)ip);

Up to you.

>         pr_err("KASAN: no fault information available\n");

pr_err("Asynchronous mode enabled: no access details available\n");

>         dump_stack();
>         end_report(&flags);
> }

This approach with a dedicated function is better. Thanks, Mark!

Please put it next to kasan_report_invalid_free().
