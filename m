Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7214F300A99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbhAVSDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbhAVR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:26:42 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C20C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:25:58 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id o19so3425921vsn.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmG3ReoOA+nFPdXtaVvEXKSYJ1hlcICvB+O+sBZ8Rxs=;
        b=BPbc972+YUig5NQtxOSZg1EHCRcGGhpBv63PGBCsP3/QeXaDnBsC/61eMD37MX0uMN
         ZhmDjYDXz45huhioduettk9AW1GqVp0JBbK15z7BRc2ri7dbK9F+6g4UBens8NOAJm/V
         w48k13PY+LsADehsNNoI1EOXdrCmtQAA4E0HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmG3ReoOA+nFPdXtaVvEXKSYJ1hlcICvB+O+sBZ8Rxs=;
        b=GxAeNE6n+uWqkMQwu/W9eHhbH9HcT+ZUJsUhN69k8XoS4w7TrKby9+Zh3EJy+36CkK
         bCWsf+ehamoRV1QSIRzKSb0sl5nAbffy81YTNQ6VN6gcoWUXiL3X+xt3N7YTvoHtLD1N
         l6M9sjjG77Z0vBHuAN3+kzxgVhCUlp3EMCHsHi3/zlM8BrQvi5LXw65IQWEa7+fCjC/O
         AmtOE3+Ios65DY9jkx3Iqk9hlEWAGnbFBhRCVkTU+9yj7AxkiaKI7LT9MYqzYuHrI103
         57Vv872KRKvm1H9SmkEBWqvReQhKOUv3r/EO/hyaNo9ZXzPr33t7XqF5UAb8SV5pxXdV
         Dgog==
X-Gm-Message-State: AOAM530rMMjAabRjc03YHOFx2HbyXVKBfrFiiYEBxm+J56gte3cw16A8
        ElhbVx1dgPNtYTlK2ssXstsr4nN+mzbIVw==
X-Google-Smtp-Source: ABdhPJxGJyZISujjxZOYUCxj4lOf8m+mL5VOyUg4tncpqk9rfzvw6evDWo4tMH0AaXw76y4mrnd6VQ==
X-Received: by 2002:a67:f4d6:: with SMTP id s22mr1637895vsn.2.1611336357611;
        Fri, 22 Jan 2021 09:25:57 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id l20sm1186404vsr.29.2021.01.22.09.25.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 09:25:56 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id o19so3425879vsn.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:25:56 -0800 (PST)
X-Received: by 2002:a67:ed09:: with SMTP id l9mr789858vsp.4.1611336356103;
 Fri, 22 Jan 2021 09:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1611313556-4004-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1611313556-4004-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jan 2021 09:25:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V8HwhdhpCoiZx4XbTMWug0CAxhsnPR+5V9rB0W7QXFTQ@mail.gmail.com>
Message-ID: <CAD=FV=V8HwhdhpCoiZx4XbTMWug0CAxhsnPR+5V9rB0W7QXFTQ@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Make memory allocations more robust
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 22, 2021 at 3:06 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently kdb uses in_interrupt() to determine whether its library
> code has been called from the kgdb trap handler or from a saner calling
> context such as driver init.  This approach is broken because
> in_interrupt() alone isn't able to determine kgdb trap handler entry from
> normal task context. This can happen during normal use of basic features
> such as breakpoints and can also be trivially reproduced using:
> echo g > /proc/sysrq-trigger

I guess an alternative to your patch is to fully eliminate GFP_KDB.
It always strikes me as a sub-optimal design to choose between
GFP_ATOMIC and GFP_KERNEL like this.  Presumably others must agree
because otherwise I'd expect that the overall kernel would have
something like "GFP_AUTOMATIC"?

It doesn't feel like it'd be that hard to do something more explicit.
From a quick glance:

* I think kdb_defcmd() and kdb_defcmd2() are always called in response
to a user typing something on the kdb command line.  Those should
always be GFP_ATOMIC, right?

* The one call that's not in kdb_defcmd() / kdb_defcmd2() is in
kdb_register_flags().  That can be called either during init time or
from kdb_defcmd2().  It doesn't seem like it'd be hard to rename
kdb_register_flags() to _kdb_register_flags() and add a "gfp_t flags"
to the end.  Then the exported kdb_register_flags() would pass
GFP_KERNEL and the call from kdb_defcmd2() would pass GFP_ATOMIC:


> We can improve this by adding check for in_dbg_master() instead which

s/adding check/adding a check/


> explicitly determines if we are running in debugger context.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> - Refined commit description and Cc: stable@vger.kernel.org.
>
> Changes in v2:
> - Get rid of redundant in_atomic() check.
>
>  kernel/debug/kdb/kdb_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I would leave it up to Daniel to say whether he agrees that a full
removal of "GFP_KDB" would be a better solution.  However, your patch
clearly improves the state of things, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
