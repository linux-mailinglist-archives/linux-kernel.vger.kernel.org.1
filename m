Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638F72B853C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgKRUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgKRUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:02:36 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97133C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:02:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so2142596pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H+tmepDnq6DBc68vTahmHQnx6N0Pdc/Kk4lEzoMPqek=;
        b=TLIJt22hJMxwAyYp7eCk44Jn/nQmii447dioukzZNOwnB/HGBCBxwpjvahSlHkpCbY
         2mAWCW2R4D7onpZOsurPBeg0BN5X2oz7nndc1ER9chHZPBfp0cV+JLQHtq87/ekKWCVL
         UDOU9NTQoNwUHleihcvSX2wH8EmSSCEDbCVMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H+tmepDnq6DBc68vTahmHQnx6N0Pdc/Kk4lEzoMPqek=;
        b=q00wh2BeINNXeUngW0DrbtgH29RXF3lTO2kcxeWNH2gnO2pY5SFyefsfqR8+cg83k8
         Yb9eN/FgNcCYjPTPSNaqQIJO5IUGTHT3L9GriuUckomEz/ZMFa4OJqbpmfFKipZmKt4J
         4pQ819fGXNJ9qm4QuqBJWYAsXuHeyDEgcByoJ52raK1iuOwWQRLeKQtCaYxOsWoe1yce
         uXunWv+pcHNoOFtn9Tl/gwnh7Ay3Ga/BK528SQGKszuf+gYeBg2dleSAYHOLbLe2E55+
         5Vh/Ka+3r9sTQACY4c0EkhE1+t6xiXsl/02c2bkzsZjyUGE4sNMXw6PTWCUkcDZ+Fgfy
         A5AA==
X-Gm-Message-State: AOAM533ku4Dbn7JIHLYp/XSCr1EsXHDL2wTIVcSiRTJjChQBmV6neSWw
        lSOECJd02w1CXs6Hc75CnI5hvz9Lb30DesF5
X-Google-Smtp-Source: ABdhPJyux3EiuAWxVk5az8ePfzPNMAe2MjTHT/rgToYWfrkEyrXaXeaaSWzsSHQvU4wbZ7YvVjrKYA==
X-Received: by 2002:a17:90a:1b6f:: with SMTP id q102mr663689pjq.9.1605729755040;
        Wed, 18 Nov 2020 12:02:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9sm3272357pjq.46.2020.11.18.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 12:02:33 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:02:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH v5 4/5] Add new file in LKDTM to test fortified strscpy.
Message-ID: <202011181201.59B1B947A@keescook>
References: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
 <20201118110731.15833-5-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118110731.15833-5-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:07:30PM +0100, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This new test ensures that fortified strscpy has the same behavior than vanilla
> strscpy (e.g. returning -E2BIG when src content is truncated).
> Finally, it generates a crash at runtime because there is a write overflow in
> destination string.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/Makefile             |  1 +
>  drivers/misc/lkdtm/core.c               |  1 +
>  drivers/misc/lkdtm/fortify.c            | 82 +++++++++++++++++++++++++
>  drivers/misc/lkdtm/lkdtm.h              |  3 +
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  5 files changed, 88 insertions(+)
>  create mode 100644 drivers/misc/lkdtm/fortify.c
> 
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index c70b3822013f..d898f7b22045 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
>  lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
>  lkdtm-$(CONFIG_LKDTM)		+= cfi.o
> +lkdtm-$(CONFIG_LKDTM)		+= fortify.o
>  
>  KASAN_SANITIZE_stackleak.o	:= n
>  KCOV_INSTRUMENT_rodata.o	:= n
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index b8c51a633fcc..3c0a67f072c0 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -175,6 +175,7 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(USERCOPY_KERNEL),
>  	CRASHTYPE(STACKLEAK_ERASING),
>  	CRASHTYPE(CFI_FORWARD_PROTO),
> +	CRASHTYPE(FORTIFIED_STRSCPY),
>  #ifdef CONFIG_X86_32
>  	CRASHTYPE(DOUBLE_FAULT),
>  #endif
> diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
> new file mode 100644
> index 000000000000..790d46591bf5
> --- /dev/null
> +++ b/drivers/misc/lkdtm/fortify.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Francis Laniel <laniel_francis@privacyrequired.com>
> + *
> + * Add tests related to fortified functions in this file.
> + */
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include "lkdtm.h"

Ah, I just noticed one small nit here during build testing: lkdtm.h
needs to be included first to get the correct pr_fmt to avoid a warning:

In file included from drivers/misc/lkdtm/fortify.c:9:
drivers/misc/lkdtm/lkdtm.h:5: warning: "pr_fmt" redefined
    5 | #define pr_fmt(fmt) "lkdtm: " fmt

-Kees

-- 
Kees Cook
