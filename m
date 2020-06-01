Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE391EAE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgFASui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 14:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgFASue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:50:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:50:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so231663pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJ32dP6pEPy8+R/UnBJ4cyCvu4+9TA+9JMxiy00UtL8=;
        b=NbD9KuMByD3tvJQWenkpsUT/S9iizgWtdqckOpX4RW61x3eiiA7G9GZ+wkf9ZaRaaT
         DTA35hxEHl9dfMtbwSuhzRUjyZ8rBiGdxbfhS8o1dJ98mS5GjUHHX/wboGlSwf7ZbqJ8
         +xM6/lf+WRnIf/3gHEOy6R8Xyu/1YBhxC64YGGWmTztLBZGMoOJPMAMguTe+vDmCQrvM
         rmnI5fCWwK0I6nzrGMpnODZLrPhAubf+x6fDyMEB5Q73avnWQDNFM6t4dqf8bxo5Sq01
         IhZ7Z51osyMiG5MCD72EvFt87toVYurQv1/auWEz7EY8g5rzcdsLdJJ5xxzf9urWiEq6
         po4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJ32dP6pEPy8+R/UnBJ4cyCvu4+9TA+9JMxiy00UtL8=;
        b=HWk7kHpFsISJzJagAKo+y8HAJTP8HI/D8u4yzqb8mKhxnd6rKxNM7MjeNJdd4T8Q54
         LC0EY26FAAdfqK7f3f8RIjmYPBi8WcOlwsxJbWHDsUMe5+1AqFLlBqEHYujBjU31UjcL
         9w4XVrXlOSUByUeGYmstgWrsLNQL0xGDfn87DgdxoJA7fws+ZXwT/CS36Ma98/dXup+k
         y/wt2SlGYvWIEJi3sDAqFOUxDByZcW6LKtABs/anGx3EhuLjNIc01fDCXQYyrbGy2Gxm
         zV8tSAKPLejruf4n0V7k4QXbjkAb1n4uIVVxXSbr9Dsh14KmONkX6kTu3P66IQzPQdRb
         2tpw==
X-Gm-Message-State: AOAM532vA6mO2tA1FeyuTwsWSHBrAwo8bQ7leC0FyVDPn31xGyVL/icd
        1IHJZ0HrJ7gvP0E/+NUpACvh+m2Bb3CP/uIEy9DFKVE3
X-Google-Smtp-Source: ABdhPJyjI7c82kJz0jWkaD/WOyRaSKFF+LmDkSBkgdRPnN/xkJJZHGBEEjMnLOuzvW5mF12iF5hv2GyPWnHlD7wstAw=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr21172819pll.223.1591037433882;
 Mon, 01 Jun 2020 11:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-6-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-6-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 11:50:22 -0700
Message-ID: <CAKwvOdkB0J8oMjG-NsM6O6BCnodmY8UeYqCyeR-c6NSa5paYfQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] x86/percpu: Remove "e" constraint from XADD
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> The "e" constraint represents a constant, but the XADD instruction doesn't
> accept immediate operands.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Yep, as we discussed in v1.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 2a24f3c795eb..9bb5440d98d3 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -220,7 +220,7 @@ do {                                                                        \
>                 break;                                                  \
>         case 8:                                                         \
>                 asm qual ("xaddq %0, "__percpu_arg(1)                   \
> -                           : "+re" (paro_ret__), "+m" (var)            \
> +                           : "+r" (paro_ret__), "+m" (var)             \
>                             : : "memory");                              \
>                 break;                                                  \
>         default: __bad_percpu_size();                                   \
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
