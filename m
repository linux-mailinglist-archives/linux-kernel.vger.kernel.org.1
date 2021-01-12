Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F12F29A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404329AbhALIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbhALIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:05:49 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD764C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:05:07 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 143so1136446qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BO9LKMYm6WLALY7iBHQnXtdADoInL5KOrbTeEAsVWyI=;
        b=YlV263n9tQpbBt9fnNBpy7Qa2HIPPIYUSnUvNbLEDrYwVNxX7ckWG3jSQ76sjL0JtW
         lbwVttNbrBHqTjUZcF5soBSH5wQbg65dZg83dq7YFsi09CLZqXpSbRYUDIwkjNS0Cbd4
         JXqv9fo4bW6zfG88NRnCEYX41fgpnmHHTVSkIsu+snmHRoE73B2cTyUuNQSZUmfcYmld
         pKQ13QosGGuoDL/HUbK4+TGUMghPluqwdlDtM0fCbtOVUQ4dUdmlpnsPHAX+J4ysHOEj
         oS6qQ5b/21tUVcWmgV4ivS1gHVM8B2Qw57AqK6A4afHthAuxaOlnib5OnhsXshRBmicy
         jt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BO9LKMYm6WLALY7iBHQnXtdADoInL5KOrbTeEAsVWyI=;
        b=ZCkO/mZvdRXCWIlTjEg9jOALYgruIbupKoYOqZhTPIwk51RXMLqJJ3jTEMgJxMqaFA
         4h4lWZw477c9GliLcYwFSGR4dFpA6bmontXYXSvpCvGp8A3NblG7Pbhx4aFCTjfmi5N7
         i2N9DdL33SZ2lAsSrLTpNwmWELQ3znpM8StKhFgQzdeK5DMH2FwCloYn39K67xCTjJ/B
         KJgxRonaAmDCev5xU0ANCkp8YTKIvq0oHekIEi/f89D3aZo9V46CvkXEnv8Bxm/dq8ZQ
         tS+vF55tw5Ic/t14rDAydikNl0eBRcXUQ8u7a8vYCB5GH/Kml9b5r13GAgjBHICn+WKF
         OzGA==
X-Gm-Message-State: AOAM532uUK82scYYD16TnXyOiKHS6SY/01OG6UkxtB7CScqB+JF/Gw6W
        jmcpju8zK/90fJsoKNnq2NX5OViGFGLRZLRDQerC9g==
X-Google-Smtp-Source: ABdhPJytD4AOfbdRca3VhmhiAQah4iu6fANU1SAhqXePfE31XsBQ0cGQMkpRI2P0lsUBLRJoPGMc5vyUmKWLTdteiSc=
X-Received: by 2002:a37:a747:: with SMTP id q68mr3277569qke.352.1610438706711;
 Tue, 12 Jan 2021 00:05:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
In-Reply-To: <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:04:54 +0100
Message-ID: <CAG_fn=WX5rGMHKPrDVCUoTNFwygW9AP7QrVwrco1R70sZ6MqQA@mail.gmail.com>
Subject: Re: [PATCH 04/11] kasan: add match-all tag tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Add 3 new tests for tag-based KASAN modes:
>
> 1. Check that match-all pointer tag is not assigned randomly.
> 2. Check that 0xff works as a match-all pointer tag.
> 3. Check that there are no match-all memory tags.
>
> Note, that test #3 causes a significant number (255) of KASAN reports
> to be printed during execution for the SW_TAGS mode.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
> ---
>  lib/test_kasan.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h |  6 ++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 46e578c8e842..f1eda0bcc780 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -13,6 +13,7 @@
>  #include <linux/mman.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> @@ -790,6 +791,95 @@ static void vmalloc_oob(struct kunit *test)
>         vfree(area);
>  }
>
> +/*
> + * Check that match-all pointer tag is not assigned randomly for
> + * tag-based modes.
> + */
> +static void match_all_not_assigned(struct kunit *test)
> +{

Do we want to run this test in non-tag-based modes? Probably not?
