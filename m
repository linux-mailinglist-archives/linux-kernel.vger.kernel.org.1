Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0497628FC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404371AbgJPCsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404364AbgJPCsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:48:24 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99998C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:48:24 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a4so671254ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2I1rfmkFMOP1oBiXv7DCTbKbbDoMlArYYZ/2NaslRA0=;
        b=qZBPG1HLxcsJ/PFafPOFhCBa2DqmT/V960xlfvw5MB0aM7SeKfSD7+TS+9Z4Mz8ezj
         vJkz/SzSSRLo3pfNfY6nEeWA5irkDL42x+3mYCsejfG6Pbwdr4zacjvgeM4X+VEc2KC6
         eLZfjK3zSSQlNw96J37iQIsTqlNjgnwNTERIMrsvYxV+ABc3N1u0UUN2audTAqSVCDms
         Ia8bUYLM6NU5UduF7VgzjZgwn0uOqRCN2aqg2LQgYIEUUg397DJjSt3SCSu4++UgdcUB
         Jk+K4cZ20QwGHcozmkcNi/Gk2CEUFkYpC/mLnMlImz1iIe3Jl4w0iL1RffPu2m0n+uPw
         9+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2I1rfmkFMOP1oBiXv7DCTbKbbDoMlArYYZ/2NaslRA0=;
        b=ppi+BQ9f85xD1iQKW6jahitOZIPdIG7g5bN53fJJSEl8Dg/oW5ujbBAAQ2XqT09wch
         g2mAvAQayqLDlYwtuyQi3yjkBL7yTV3a8UpPrm+4QwGIDb3YXwO1AiNxuFALLF3tVYGC
         O9TU6sOxjUU9Qit+Kmz959A6dpt7u7P6w6ahELqxyFg3gNLEs7yNaRylyeFBA9OO3erA
         CeisHcCFH3/yh+7U0VarNWIxgnnOVNvWh8qLR1LBmzIxMzKuMqMRz9dSfNjPN6yTqUHv
         UyViI/JZHoOzPwcnNJmXL5gUWFCv27EQQI4SXYOVoqLidhAgJ/TFLg90wpUEyYfaX1Gk
         RfkQ==
X-Gm-Message-State: AOAM531duB3W2SUtevo4P/9vDLLnG87rk8MkFCD+eeKX5kYrQzdqEtJh
        e1XMFboX2oy7qC1YIjNBdVr5hwPhI+MN5T55ZHg=
X-Google-Smtp-Source: ABdhPJxyMYPvorSexxCUDHNnM++SseBEWYMluhTdbueT2uTAr0e95+Zvci5uulYhm4j4ozRV9s7qoUnWO+YqRqw+GdE=
X-Received: by 2002:a25:d441:: with SMTP id m62mr2024568ybf.422.1602816503934;
 Thu, 15 Oct 2020 19:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de> <20201005122732.3429347-3-poeschel@lemonage.de>
In-Reply-To: <20201005122732.3429347-3-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 04:48:13 +0200
Message-ID: <CANiq72mgR5vXE1hFepN-vTQ0m1b9Zay2A29S6-si+3St4bj_fQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/32] auxdisplay: Introduce hd44780_common.[ch]
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 2:27 PM <poeschel@lemonage.de> wrote:
>
> diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
> new file mode 100644
> index 000000000000..073f47397f7d
> --- /dev/null
> +++ b/drivers/auxdisplay/hd44780_common.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "hd44780_common.h"
> +
> +struct hd44780_common *hd44780_common_alloc(void)
> +{
> +       struct hd44780_common *hd;
> +
> +       hd = kzalloc(sizeof(*hd), GFP_KERNEL);
> +       if (!hd)
> +               return NULL;
> +
> +       return hd;
> +

Typo: spurious newline.

> +}
> +EXPORT_SYMBOL_GPL(hd44780_common_alloc);
> +
> +MODULE_LICENSE("GPL");
> +

Spurious EOF newline.

> diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
> new file mode 100644
> index 000000000000..767bbda91744
> --- /dev/null
> +++ b/drivers/auxdisplay/hd44780_common.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +struct hd44780_common {
> +       void *hd44780;
> +};
> +
> +struct hd44780_common *hd44780_common_alloc(void);
> +

Spurious EOF newline.

(All already corrected in my queue).

Cheers,
Miguel
