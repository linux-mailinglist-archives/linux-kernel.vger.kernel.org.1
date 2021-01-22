Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0683005CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbhAVOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbhAVOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:42:56 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF6C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:42:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 11so3836205pfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDW0uo0U4I8F8s+gzPDSjcYPS9epJOiCg4X2p7A7eF4=;
        b=VswbVDlWLOpcZ32hSYINsQeKvp4aICDDhmjx2WDwPSsC+blSNkZAGtgq+vsZVIcRjR
         AT0gO2Nf2f2mb3VLFeyxAFfOWEf2pGrlB3EuiEKQtixdGpsxCOlmGORV0eGsHc+StOWO
         WUgguwnb8qkDiugN5ZeJQfle1EVaYhlC4aNL5DiTRW1AqdxUxPXGMz3JynLlW9oCY7xH
         3sqiXHU+J5u0LdbbrW75Gxh/CQsLqdMhyBfrCDnJESrC/hRY0I3Pi99t85hbNg+elmiL
         Go22xae3WIqWMXSlhU6HdD/uBxLCTXGNda6Wmz0+7xH/wo9CWY06v7OEj/uPQbmtXAiT
         L1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDW0uo0U4I8F8s+gzPDSjcYPS9epJOiCg4X2p7A7eF4=;
        b=CXHjpWFl3fgqM6G1nDgPRwa2N95RYZmjcQFXCkffe02xscJ8vz5mSwBobmFrldzrVU
         p/PeHAUePDt2CyJUngb/vtRBAe4RI05/yytwh+9+1O0fMQavJkZZ2kPkTEKeRlejq7Gq
         PrFP8uMg8YQ14yGMkmZwCJSLcKnIvar3ihx1FfQWeUZds7ypCPtqbmXQTob0PNP8tRf/
         QSncTlodOiI/2px12I3eBokOEpyjjJMVXarm2Z4sSiU7re4RAzGoEsJxhZcMMw59owHY
         oF+jC2CjLuH/UwXatgsPndBsPo1P3GStLsPPjwL5k3xy/QU4jXC6SCATBurnTEOK53ds
         Z54A==
X-Gm-Message-State: AOAM53180uCEecQyDO2aXPQ7MWOoqU803zYpzv2tUvBkMRLv7nZMVPbE
        eUIZRc5NJC9Gh+5MZlUtOsPm3QD2qvNTgRz7VWNGzg==
X-Google-Smtp-Source: ABdhPJy7eF4qouYDgxFSogoAOjI/HoTypMGg98Lxr/e9DPp0q6sNb04A342nzyC3elmXD5aj1J3p6AnGZ88Yvqi9eNM=
X-Received: by 2002:a63:4644:: with SMTP id v4mr4977707pgk.440.1611326533664;
 Fri, 22 Jan 2021 06:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20210122141125.36166-1-vincenzo.frascino@arm.com> <20210122141125.36166-4-vincenzo.frascino@arm.com>
In-Reply-To: <20210122141125.36166-4-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 15:42:02 +0100
Message-ID: <CAAeHK+ydhzfrdrPbjok20rgMEYykpfmjcRASm_bTfhuTVXF_VA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:11 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> KASAN provides an asynchronous mode of execution.
>
> Add reporting functionality for this mode.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h |  2 ++
>  mm/kasan/report.c     | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bb862d1f0e15..b0a1d9dfa85c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> +void kasan_report_async(void);
> +
>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline void *kasan_reset_tag(const void *addr)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 234f35a84f19..1390da06a988 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -358,6 +358,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         end_report(&flags);
>  }
>
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)

This looks wrong, CONFIG_KASAN_SW_TAGS doesn't use MTE, so this
function isn't needed for that mode.

Let's add an #ifdef CONFIG_KASAN_HW_TAGS section in
include/linux/kasan.h after the HW/SW one with kasan_report(). And
only leave CONFIG_KASAN_HW_TAGS in mm/kasan/report.c too.

> +void kasan_report_async(void)
> +{
> +       unsigned long flags;
> +
> +       start_report(&flags);
> +       pr_err("BUG: KASAN: invalid-access\n");
> +       pr_err("Asynchronous mode enabled: no access details available\n");
> +       dump_stack();
> +       end_report(&flags);
> +}
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>                                 unsigned long ip)
>  {
> --
> 2.30.0
>
