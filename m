Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A744E2AF709
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKKQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:57:19 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33974C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:57:19 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so2330303qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yelVk1suTz9Rsjb1IsDRFFlgbkKWxRF4BCpHMaeax1Q=;
        b=HRDAD/hwvyIkLs9O92jQy1ebIlVvj7AwMGQ0bMDuIV4Dl503LisAS4YBPMPhy3r1WB
         mJlFWIxHF9UekWRCFB53z7P5yzslWML0qEx2ruBqpQWVCHTG7+waZGENx5am5oxZr8mU
         rtVUdDzhb3IpyIKrU7fbNrfJxdnE3NWIAFY5X94KeD4lDpHRiuv8qEsIKiCDruBZKenM
         UJs+9CnM2AJe8Ti3+yUfb6CO5O+t2W/j16dPEdW07XooSZkOSoOvdp4kiqdFHHNjdSFL
         vlVIg46LpwuMbaP8i7/+xIBF+0f4eZ/Kx1Z2KsDmNO4nwrcvZOoxwA7U2teB+Fz7HbQE
         1YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yelVk1suTz9Rsjb1IsDRFFlgbkKWxRF4BCpHMaeax1Q=;
        b=nwwhoRiru87oPW3qYF0gJjMhDHU3eU/v15FLuSJOi98r8Mj7xCkGebRjyvViuxULZJ
         g4fFrV1ayo0XmXDfj0HoYQ21O+ntUM4gBZVXdnn/2r0XjX5zR5Jyg27heG7Oa8e2xAIA
         qpTTWGfi1bnebe5BhQgxE7G5eT9qpFDuOsZdrsbm/P/JDMdiJ4BMfe42vuGhiE81s/EN
         YsO7EW4TXE8ej8rVWJ8f1qya4oXbzF+FImVoUN6pStkHnqBBeLh0SXlH5dT9KERQ8WDR
         RXSV0Y5sJyKQAXa2dCfelJUaIvx4YjqFG0mL1+utcsKJTNaGatf09NlGZ3ngdZ294VrB
         mzbA==
X-Gm-Message-State: AOAM531re1ETPCBvbxn6ZhkNPlgR328xrEBTWWWbVR+w1NZmOO6ZSkCV
        XVj6yKiLvKfo1JTJPCAU13yxRMRrvBIAUauMNZ7adA==
X-Google-Smtp-Source: ABdhPJxndKMi/FA4Znj7VU7gRvh5FzJ9G9CfB/hInEMsEX0Z4OkJcmKqAxBh60fIwmUyuHxDhYfNf1yKoyii0Zfu4bk=
X-Received: by 2002:a37:4552:: with SMTP id s79mr19890977qka.6.1605113838237;
 Wed, 11 Nov 2020 08:57:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <e9077072bcdd4ccaecb1c84105f54bac5dc6f182.1605046192.git.andreyknvl@google.com>
In-Reply-To: <e9077072bcdd4ccaecb1c84105f54bac5dc6f182.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:57:07 +0100
Message-ID: <CAG_fn=XvXDe=+wuBNBq=fmidZkghNx_g6RbHRjgMMa658_1LXA@mail.gmail.com>
Subject: Re: [PATCH v9 43/44] kasan: add documentation for hardware tag-based mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Add documentation for hardware tag-based KASAN mode and also add some
> clarifications for software tag-based mode.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: Ib46cb444cfdee44054628940a82f5139e10d0258

> +
> +Software tag-based KASAN currently only supports tagging of slab memory.

I think the reader may confuse "slab memory" here with "memory
returned by SLAB" (as opposed to SLUB).
Maybe "heap memory" is less ambiguous?
