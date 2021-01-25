Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F63028E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbhAYRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbhAYRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:15:23 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C8C061788
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:14:42 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id k47so4682091uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQc6PKJl364Vrp1EanHNeZBMPwrfKXlGnOrqHxfWtgk=;
        b=knfSS5OTZvscjpM6xakbSLdApoN93eamZqe7F4G6G7cQMv7cyKw5tarTwrRJvpZk1H
         KNbIG3EdLmNMkSFR/AjfIBPDxxTw/3MWBxlIyeq/0EsjW5eex2WPfOo9i/wEK5AA/UCM
         poXFNGSOx9LubRJF3xeOPfNVvhhiRai5AF6GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQc6PKJl364Vrp1EanHNeZBMPwrfKXlGnOrqHxfWtgk=;
        b=b0PMFF9j9YrU/5DabYA4mEI8Q2b+v4reaurvRf4XVwUc2ZgUfaMHISPxQ7ygihVZSk
         F8+vbv5KogNFsk8JQLChx0ID7xPegUx9hNnjRD7140G3GkMfUixW0C3A4ucjhNdo4LMq
         oXBp+/26kcCS6jLWxPf4MD61mzwf4tL/rOVNoj2/bkZY2mNYlGOCtejIHO1D3980ySD3
         k7tQ9O/2WJgde6GvPzf2AXPMnVOzyhbCQAejj6zzFNpqDiGSaq9NLWydhZ+xBpwcdwuZ
         D5to1sOUtmfT5wa81Uu+emg/awt9gujGfliul9bv7srvLNk7n0vypF7rPKqvhl2EScxH
         bDxA==
X-Gm-Message-State: AOAM533QTZdT+JEVTh+c8C7NRb5toU4uUnSQWSzPbBz/4AYhBOa8/268
        Z3e1U4nH6lAtLuRJCqqZqEDBwNn/yU9yJQ==
X-Google-Smtp-Source: ABdhPJxnl1jnwNN/yyCVyveFwhJoaxeZLPGdr3dto+kVOaHuOwLkJfF4k45SVlL5qGP9eDiEd7YdlQ==
X-Received: by 2002:ab0:5e6:: with SMTP id e93mr1304223uae.109.1611594881783;
        Mon, 25 Jan 2021 09:14:41 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id d26sm302974vkn.17.2021.01.25.09.14.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:14:40 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a31so4662139uae.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:14:40 -0800 (PST)
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr1315298uad.121.1611594880375;
 Mon, 25 Jan 2021 09:14:40 -0800 (PST)
MIME-Version: 1.0
References: <1611584985-12479-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1611584985-12479-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Jan 2021 09:14:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOGca=QVmGnUCgtTk5ednPnUXiLekqo77LQ3EknrVXjg@mail.gmail.com>
Message-ID: <CAD=FV=VOGca=QVmGnUCgtTk5ednPnUXiLekqo77LQ3EknrVXjg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Refactor env variables get/set code
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 25, 2021 at 6:30 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> diff --git a/kernel/debug/kdb/kdb_env.c b/kernel/debug/kdb/kdb_env.c
> new file mode 100644
> index 0000000..33ab5e6
> --- /dev/null
> +++ b/kernel/debug/kdb/kdb_env.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kernel Debugger Architecture Independent Environment Functions
> + *
> + * Copyright (c) 1999-2004 Silicon Graphics, Inc.  All Rights Reserved.
> + * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
> + * 03/02/13    added new 2.5 kallsyms <xavier.bru@bull.net>

I'm not sure the policy for copying over copyright notices like this,
but I would have expected them to get copied over from the file you
got the code from?  These are slightly different.

> + */
> +
> +#include <linux/kdb.h>
> +#include <linux/string.h>
> +#include "kdb_private.h"
> +
> +/*
> + * Initial environment.   This is all kept static and local to
> + * this file.   We don't want to rely on the memory allocation
> + * mechanisms in the kernel, so we use a very limited allocate-only
> + * heap for new and altered environment variables.  The entire
> + * environment is limited to a fixed number of entries (add more
> + * to __env[] if required) and a fixed amount of heap (add more to
> + * KDB_ENVBUFSIZE if required).
> + */
> +static char *__env[] = {
> +#if defined(CONFIG_SMP)
> +       "PROMPT=[%d]kdb> ",
> +#else
> +       "PROMPT=kdb> ",
> +#endif
> +       "MOREPROMPT=more> ",
> +       "RADIX=16",
> +       "MDCOUNT=8",            /* lines of md output */
> +       KDB_PLATFORM_ENV,
> +       "DTABCOUNT=30",
> +       "NOSECT=1",
> +       (char *)0,

In a follow-up patch, I guess these could move from 0 to NULL and
remove the cast?


> +/*
> + * kdbgetenv - This function will return the character string value of
> + *     an environment variable.
> + * Parameters:
> + *     match   A character string representing an environment variable.
> + * Returns:
> + *     NULL    No environment variable matches 'match'
> + *     char*   Pointer to string value of environment variable.
> + */

In a follow-up patch, the above could be moved to kernel-doc format,
which we're trying to move to for kgdb when we touch code.

I will leave it up to you about whether the new functions introduced
in this patch are introduced with the proper kernel doc format or move
to the right format in the same follow-up patch.


> +/*
> + * kdb_prienv - Display the current environment variables.
> + */
> +void kdb_prienv(void)

IMO saving the two characters in the function name isn't worth it,
especially since this function is called in only one place.  Use
kdb_printenv()

-Doug
