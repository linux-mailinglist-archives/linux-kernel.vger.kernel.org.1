Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2F300853
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAVQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbhAVQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:10:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E561C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:09:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id md11so4007918pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVquU/fnEPX2P2H0t7db3gVL7KbgnWZmVefN2ofYxhw=;
        b=ohn/q1odta7PKZJTRpAF8sL+Z1qFGFUS7x1rUrJ1WFMy9sSaUxjjskM8OBGpEFYNmT
         gtyL+Ko/HbCrokOM5JhmGwpywOK/Emh+EVMYemZJxmuv/7IhPPM18qetJHNNmiAVEkMj
         TsGVMHlXEpzlW5tuc3Sdt/LX/rmDS9qzLeEFtQeYj7HuEEXsl6qrb+08G5PYZCL4Qrgg
         HyPz637EdPg71cAkPhPOsS0Cc1Gx6t+nbVxmaIL1Z+/1X4HBq2TyeaOJrmisGEFNXwN4
         /QcG22ipEdnDcoZV2fcFRzcRYlEm+rDTgcmC7VsZod/hYqQm1wlmcC9f83eKoJqZ0TCa
         bmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVquU/fnEPX2P2H0t7db3gVL7KbgnWZmVefN2ofYxhw=;
        b=Px/UUzOhoeHTktEl77y6OpipwV+jv1tUDQjmAwaASfq1ce/nuQzpAb0uCZ9ciaGnM0
         732Ea3EPyD9uHoqtZKgWEANJL/ZdaIdr8y72CxXbUnIIPcxD92HvU1KP9dbqxVP2GjuA
         Hz/ULEUBI6h+izQ82Bxk+0NvEUT4mbOUrtZkBLfsZ14JlQJwqSPEpvnork0qolSDuEXq
         FClEISiKyhN1EnmfYQz4W7OafrvofCg2AzY2K5hg16x/MBOQUsfe1gnkIPTFkLf3J1lb
         c7i0/JDACR8Y6V0Cn1WycypnBvtqfxERudYbLsIFjc2vaAdd7Hq20J9jh1qHwueTK6zF
         6vEA==
X-Gm-Message-State: AOAM533NH/lkrrLNv2RHpzlVbhsRxRKsZmikivHH7H0k3VsIC3Qnqb7u
        3yxhnZmiV2KUu68Hbl6So/fH3bRron5j/2MKYXVZFQa1lyG12g==
X-Google-Smtp-Source: ABdhPJzxr/v+uG/3f2InBptc3YjQo0wlQpC8zpAyX32esLNuhznzV8qnnwNa2ErFaDn79mkuOcQZflfRdN/t4kzsqbw=
X-Received: by 2002:a17:902:ff06:b029:de:362c:bd0b with SMTP id
 f6-20020a170902ff06b02900de362cbd0bmr5282054plj.13.1611331794468; Fri, 22 Jan
 2021 08:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20210122155642.23187-1-vincenzo.frascino@arm.com> <20210122155642.23187-4-vincenzo.frascino@arm.com>
In-Reply-To: <20210122155642.23187-4-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 17:09:43 +0100
Message-ID: <CAAeHK+wzgy8UFBMzRFKUchSekURm3rkaJsOLe=VSE9D-6BAtvg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] kasan: Make addr_has_metadata() return true for
 valid addresses
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 4:57 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Currently, addr_has_metadata() returns true for every address.
> An invalid address (e.g. NULL) passed to the function when,
> KASAN_HW_TAGS is enabled, leads to a kernel panic.
>
> Make addr_has_metadata() return true for valid addresses only.
>
> Note: KASAN_HW_TAGS support for vmalloc will be added with a future
> patch.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/kasan/kasan.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc4d9e1d49b1..8c706e7652f2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -209,7 +209,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>
>  static inline bool addr_has_metadata(const void *addr)
>  {
> -       return true;
> +       return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>  }
>
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> --
> 2.30.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
