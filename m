Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E62D8CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 12:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394592AbgLMLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgLMLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 06:31:06 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E600C0613CF;
        Sun, 13 Dec 2020 03:30:26 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n10so2506029pgl.10;
        Sun, 13 Dec 2020 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5s7X/nOjA4XrKpMEKxmbe1OfV83VHJMvDQxbv5LSaFA=;
        b=c52Gl7vGI6Xi0WjdktyI+AdNDCVuPehAzLeDAE0c95ZGdhDhVkq8yO1w/3p05ycZQm
         P8blzUYiWGopU/toreASmKceu7aGu7032QgzGivwF8fEFrW6zlHUNtgRNGtP/JB4rHzr
         jh4jbRTbJbIJ7l9S7TNAuE7b/j/GCsSjg0AupwkpMXd4yscT9mrC93AHARYN3JJZ0Al+
         srGgg7pIlmPfiPwmgsGWX7qH4o76vwsADQfPdDnBIFUxnbkuH/BTMUPKVO/HA1uQjq9O
         Ml+7eMrZqnuiLqkGXMGhdYD10Ov1vAfJsKKswzGS40t8MIkUCjjV+aU7Xa0URWgvzfxs
         lmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5s7X/nOjA4XrKpMEKxmbe1OfV83VHJMvDQxbv5LSaFA=;
        b=eooWznTaI3RJhBTr7SiXhQtnFN4B3+664j+4StPiyGeXX9EXPEYkcE700F/gqTWmsC
         JDJEXbM5A/aZ00rtEp04v+UWFPApyvhFryfKkjcv9wxMplcGHYgELGHLSqMtcCdWAk7p
         OnOM3O0cuuHbHpNIbTjJuGK1Ewmt5yiuJNOGtGPImqnJf7cFOqgRgkoVtMcDw+vEFBz6
         mpjFwRjYL6UxFaT2KhWrdxeg8EMCrdIq05hcZFv2eM1G3OzwIrenj7zdG/xoyKO7PCSJ
         G4Nre/TzgfsA74gzj5eyYBkMzqWGkf8iCYIez6qL8jrfzB+um3eUFdy+VZAgDr7ESdR0
         EUIQ==
X-Gm-Message-State: AOAM533/oz8hic0vSTU83XEed/frm1WQ+yv7VQ4nKxM6temMtJH+2/Bl
        d4P9GAb2wd+fonFFjJcWZmU6rZU/Rdf22jxRcgI=
X-Google-Smtp-Source: ABdhPJytQCwPAj1ShBk9yeAGvSYBYdSUGcAaoXRKXzBKiD24pHCK5dy0jA3QpOQL1y/iJLb63NuayFR48VoiJPudVc8=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr19205388pfc.7.1607859025920; Sun, 13
 Dec 2020 03:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20201211211916.6259-1-semen.protsenko@linaro.org> <20201211211916.6259-3-semen.protsenko@linaro.org>
In-Reply-To: <20201211211916.6259-3-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Dec 2020 13:30:09 +0200
Message-ID: <CAHp75Ve9Yuyi4vqs3rLSA=Vtn6gBqyEyLsz7FDQ3SBbp_WxC8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: dwc3: drd: Improve dwc3_get_extcon() style
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 5:27 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Commit c73b41955ee4 ("usb: dwc3: drd: Avoid error when extcon is

The previous change ("...

(because we don't know the actual commit id)

> missing") changed the code flow in dwc3_get_extcon() function, leading
> to unnecessary if-branch. This patch does housekeeping by reworking the
> code for obtaining extcon device from the "port" node. While at it, add

an extcon

> the  comment from mentioned code block, explaining how checking the port
> availability helps to avoid the misleading error.

...

> +       /*
> +        * Try to get extcon device from USB PHY controller's "port" node.

an extcon
the USB

> +        * Check if it has the "port" node first, to avoid printing the error
> +        * message from underlying code, as it's a valid case: extcon device
> +        * (and "port" node) may be missing in case of "usb-role-switch" or OTG
> +        * mode.
> +        */

To me it sounds like this should be in the previous patch.

-- 
With Best Regards,
Andy Shevchenko
