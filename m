Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35F72F6C50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhANUik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhANUij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:38:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:37:58 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so10134518ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnkY8VhBKX7fyLymuaOgh7Kzhqo6/ffCUUZ+3TB9sfk=;
        b=S1qEdtllkI9bbC4WyizIHS/NrI01+t4naYpVzKo6U7uIUZGgZvp4ipWMMorZBf2JI8
         xh0YtKXQ2E0LYHNKr7uLeqY96YGydw3iS2kK1XqzqieZedhOVpAHmjk1Tc5+JAQm7Uje
         Rt5/6I4aMe40Yahclk0iBTPNB+efQ7/HzM/Im7N1SNU53kBndrBGrf2Wj/w4/QkQjBto
         NNRNWNEOqOsFJV7Nt37Dz5+QR6vVpkpiqqcNCdFeffIPgpHHGYc4PlfMJIQnZYxNITcr
         Ipfjh8gfcpTz8xWWZhanhRNzDxR8Zu3Oo9J+pq7/oZ6CcU8MEBWVUHpqv41ydH+3ErYy
         erSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnkY8VhBKX7fyLymuaOgh7Kzhqo6/ffCUUZ+3TB9sfk=;
        b=l+PMmk6UAggOte7jiXsDXIzZaAyHBfb6vmlxwFe4NHr2CMYSH0Hr7/+P24LXrF3NLx
         1CgfvcF5amVEzvZzs8BOTLJU+2odReo3LwYcu1YzRYTsXv/MeOb/2oJMi0vr8Is6c4Rq
         mmzovefkxEe/mWSRjgcq/khGwPZ3WhfOCz0D7l2CW49edzGvM8kpiojlM/ssbHrsP1HK
         Ack2u5c379i3lwlTZC1rJ2umslG8PfzsI79SzGX36Ar31ccP/Abv636h7x8hIxmJGB4i
         hFjr0fgnCks/q6PTGlHa+MKbTRAgwEItiCwKXRc2NkydAa5ryJplw911RPJEFYONDqbu
         oKyw==
X-Gm-Message-State: AOAM530JXLzqR1ZjmvclkFkXgh0ZuQ18KrXjhyoatwFh0EJMvhs6U2xW
        c+C7r3iQkte1UEJ9yW4uQ3LS2qvXJfJ26TibPWM=
X-Google-Smtp-Source: ABdhPJwLcgK8nT3QnZuXEL5YzyE4ftItoCDBCpkwUddDRrwlLOcFty5eY+Uv/uYvGGwiA/tT70apTQ8ot7KpJF9Cxig=
X-Received: by 2002:a17:906:690:: with SMTP id u16mr6536886ejb.186.1610656677483;
 Thu, 14 Jan 2021 12:37:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610622251.git.viresh.kumar@linaro.org> <193f2f177d23eef62b54b48f80e62fb0169c1db9.1610622251.git.viresh.kumar@linaro.org>
In-Reply-To: <193f2f177d23eef62b54b48f80e62fb0169c1db9.1610622251.git.viresh.kumar@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Jan 2021 12:37:45 -0800
Message-ID: <CAMo8BfLoMhH67ref+uVV4yb22B+c61ewvJaaCsgJgOPc+JWUyA@mail.gmail.com>
Subject: Re: [PATCH 16/18] arch: xtensa: Remove CONFIG_OPROFILE support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 3:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
>
> Remove the old oprofile's architecture specific support.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/xtensa/Kconfig                         |  1 -
>  arch/xtensa/Makefile                        |  1 -
>  arch/xtensa/configs/audio_kc705_defconfig   |  1 -
>  arch/xtensa/configs/generic_kc705_defconfig |  1 -
>  arch/xtensa/configs/smp_lx200_defconfig     |  1 -
>  arch/xtensa/configs/xip_kc705_defconfig     |  1 -
>  arch/xtensa/kernel/stacktrace.c             |  2 +-
>  arch/xtensa/oprofile/Makefile               | 10 --------
>  arch/xtensa/oprofile/backtrace.c            | 27 ---------------------
>  arch/xtensa/oprofile/init.c                 | 26 --------------------
>  10 files changed, 1 insertion(+), 70 deletions(-)
>  delete mode 100644 arch/xtensa/oprofile/Makefile
>  delete mode 100644 arch/xtensa/oprofile/backtrace.c
>  delete mode 100644 arch/xtensa/oprofile/init.c

Although I still keep userspace oprofile tools that use this interface,
I haven't run them for ages.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
