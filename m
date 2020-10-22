Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B160296164
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895284AbgJVPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894695AbgJVPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:02:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C5C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:02:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so1707648qkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+m1UPja2DtoudA/ILdxkbDDyCOqxZ6QYeC54vUwf94=;
        b=JzgkLntJtddfrInFlm/sgjQLu1IuqjTWWy3cBno0A6VYT3Jk8Bgnu6QMBtc+1iegK8
         ACemAdTefokZxErQh7cZWUljSbsxKYZp8b6hifvScBhYSkbkBJgHyUmVhg7bem9hvxnE
         mePqu6hJBHAX7/7LcVzbCbGOl5FFWtsQMBCBA/pi8MrIpNTM+ZVJsuPLRdoUdZCmuJZG
         iHTTMmgRjYvOXSFjs6IwyKEYXYEDxoCpY39arxXkQY4kSfAAHqihTIUAOiYVNteYTWEZ
         LR/8ppTZnPrVJXRykM8Vn/IZUDtvXYK+NHCvNu3QgsSjw9kv5OBvCzoKT6m1VBg+B50/
         5COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+m1UPja2DtoudA/ILdxkbDDyCOqxZ6QYeC54vUwf94=;
        b=CfXtUQheGJR/jpKgEDMqCEkiit3kmsYZnGJeoNT46u35wiBSaNeH2jjM+x06L1oKgo
         JXcPtAGiqCBXQFVtHQEbbEjC8dXdpRAWBVTL6DJU97qHQqZ/ELCLcwYzU9kMk2ct0WoR
         0bpV5qAeZqEI/e+BWqOt1efhp3HthfL+qFhTpwzdqyqDVWQ7QP5xPhenQsh9UbVWeBEz
         7BWciHv6jtkEJuoV3uXutY7JvURY3xzluDzZW2/0HULvE5qH64FPPSkF0KYUOV5qBrma
         75vD7QMXcyalBIMDlxmQvL5BrZWbZ9lWhbRgGRwbfYAcZZYs+0xqlqe41aITgWDdaGHK
         G9Xg==
X-Gm-Message-State: AOAM531INzgVtkf2zflSMHJNVS0ymgvm24ETmfHCQPhbYTlh6MIcvnVv
        lZxRzrzkxmX/LCkfNj7utujxUrP4fB+hreETiyBnWw==
X-Google-Smtp-Source: ABdhPJxAmRUG5eB3xXn8zhcNc8gHWuihbJ/awM7yRA9wNoFSSWLGZZ2M0EzAIJbXGwoFan5zBzUqI4UYbdvTYZQPFpM=
X-Received: by 2002:a37:9301:: with SMTP id v1mr2908065qkd.350.1603378940363;
 Thu, 22 Oct 2020 08:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114553.2440135-1-elver@google.com> <20201022114553.2440135-2-elver@google.com>
In-Reply-To: <20201022114553.2440135-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Oct 2020 17:02:09 +0200
Message-ID: <CACT4Y+aY=Z4D+FzMUL2f0gda-PP1t5-HNXBcc22KW7OTYuZh4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kcsan: Never set up watchpoints on NULL pointers
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:45 PM Marco Elver <elver@google.com> wrote:
>
> Avoid setting up watchpoints on NULL pointers, as otherwise we would
> crash inside the KCSAN runtime (when checking for value changes) instead
> of the instrumented code.
>
> Because that may be confusing, skip any address less than PAGE_SIZE.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcsan/encoding.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index f03562aaf2eb..64b3c0f2a685 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -48,7 +48,11 @@
>
>  static inline bool check_encodable(unsigned long addr, size_t size)
>  {
> -       return size <= MAX_ENCODABLE_SIZE;
> +       /*
> +        * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
> +        * pointer deref inside KCSAN.
> +        */
> +       return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
>  }
>
>  static inline long
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
