Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9EA2F63AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbhANPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbhANPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:05:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A55C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:04:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jx16so8590729ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcbbwuTIw0XOxXbx1OMAv/zQ0f55cTFOH0Nbkr3v9jQ=;
        b=yEQItAvigUbfYWEhi52aXuHAPZ6tuAT+qCXXEz38nS35ib8OcfO7+gDDF4v51PSdqO
         yK6DXZVx+k8ENzwUIBM3pCe8Qm5RXLMR99pctX2BGhzzUafnl2uPG9GR5xhVL5+iqTK6
         psk+q8hQ2VVxs1H+G6MVFLuMxpX5BkoJoyngpGmNxk6jWom4qSIxmJMywtK5LW+OehTn
         UoMfUhx+FUVFS0hHg91ARMaZMgJodjBwEVItDiQaF9Yd19jROYtqMzANthaPc1a39tmu
         C7iDgYdZ9RgcNAwyDDxoJ56VIfbn0G8cL1pEgiN0QBjCgtrB08+wDIFoHccqiGHTuDbR
         wJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcbbwuTIw0XOxXbx1OMAv/zQ0f55cTFOH0Nbkr3v9jQ=;
        b=Or1adciZLm4invkWUMe77tFEhfdi214LoIw7rEGsoIsMXJ+6sPM6S5oiWJ3XbHSoJK
         aHAtvbDw4dNGXxtAl8ouFEJVnjtmTgYSsvgmGZ102TXF+ypPCl1YdQ+M4LaKU4GZcBcG
         6l1Ui60e3jPGtXmI/rr9PNXvVasTqjZWW3IYWnLTORejuQq8lin7swyuJKWnvbcTGzt5
         VqrPPslynkrZ4F7aIomPE6R8stlIRGGJPYcHMAHdi36fkUH97XkaJOwQbLS4QPDboC1s
         XPcCc9Sokm82K2CgwGDp6e0xQ6eIMH9Ery7OyGm05lrSXx+mCGl9BV68Xj5t6SnbNn3g
         7Lbw==
X-Gm-Message-State: AOAM532unDT0uyiSg95Q4PpLhYD1UL5K5lYKSFEWDYXYEOBsbRI0W6MH
        KgvwAcvcqJqviSsapXNjd+qVNxSLvtb6sCKTSukpAA==
X-Google-Smtp-Source: ABdhPJzfhHY7ArHTAP1cnKCI9FVF1ePtOXIVFPGTJb4hX8UeuqKZq4J5eTmoMo9wmuacHVDMDI66XIwVLCYvcqL1JVQ=
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr5543469ejd.429.1610636673865;
 Thu, 14 Jan 2021 07:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-2-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-2-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:04:23 +0100
Message-ID: <CAMpxmJX151+boZkX8SJ7s66GFOfcRvBAvGVTs96Ce2J4ETmFpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] selftests: gpio: rework and simplify test implementation
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> The GPIO mockup selftests are overly complicated with separate
> implementations of the tests for sysfs and cdev uAPI, and with the cdev
> implementation being dependent on tools/gpio and libmount.
>
> Rework the test implementation to provide a common test suite with a
> simplified pluggable uAPI interface.  The cdev implementation utilises
> the GPIO uAPI directly to remove the dependence on tools/gpio.
> The simplified uAPI interface removes the need for any file system mount
> checks in C, and so removes the dependence on libmount.
>
> The rework also fixes the sysfs test implementation which has been broken
> since the device created in the multiple gpiochip case was split into
> separate devices.
>
> Fixes: commit 8a39f597bcfd ("gpio: mockup: rework device probing")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>


The C part looks good to me. For the shell part I would probably do a
couple things differently but since we don't really have a coding
style for shell scripts in the kernel, I don't want to block these
patches, so:

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
