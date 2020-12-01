Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758FE2C9454
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgLAAxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLAAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:53:31 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF33C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:52:51 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so390576lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FDA3bzcAl1VMiQxZ+Tn6nV+nyrVbhZqsOS0EUcBps6E=;
        b=bLQaMJp1qQC2KOL2I6iL1GherOgjFJfBauri2nka89tsNPt5Bh0ecQCRIoct402Cs7
         Su5Gs4RiGbxFERFqE5RCRUWxh7aFlJ0S446GaWbu7Kw53RgeCFPT09Wu/AZDJTsXp3V5
         /aIZLhU3LLq3xHel5jKUJJXVOM3MO7/JHfShzzgM5WboFoxnJwXusDBup9KAqYSe+h+s
         LA08X+6JzTUGQM/swNkWp5b694LZoQ6PVIJmmK3INu4e9g+vIOpr38xmv3Si50p69yQQ
         YmT/LCZ0wo0b/FrgoxCy0hwewI9+kbr5qJbcG4cc42ugUbR8RvbUSEudlW8i+3NF1K7p
         zXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FDA3bzcAl1VMiQxZ+Tn6nV+nyrVbhZqsOS0EUcBps6E=;
        b=EzSR2QcVqWZ+PdTb2B/rZBbSyZXpYgJeUd0/bPZIlVOjYIg3npXEsnYb1rYeEcFXJn
         2e1oW2zAEm/Yl+gtM29POGiuihcVrYeEOy7MVawJg8LEIaafnhN2GEJltWsR+Q456ZNt
         sQ4X7M8rZiCz8AlHtKgltiZHDHXoapvo3QeFdZZyP47/+tsDeM15nqFyYK15a0reTUpq
         Bgh9KJIN/KPL4Trq90x9unGIqWMo58d4DkUcRhiOMXdqDWFUHhc8OhGj7m9zkC5Lg/RX
         nDr5NP4gkhn/JLCiBHPhY9Q27z9TprTFZ/ZN3y1cyEG4jInjvAmd5KTx0O8A3RY/Ec6U
         dUZQ==
X-Gm-Message-State: AOAM533l6JM9fsvxZpbX9GPZBAQTgghgKbr95zak8Zf33sXsFlcm1lyk
        9MgPQbO/HC8QjHLSkfju0/leHLoA9Vgk1RA9O0XDyA==
X-Google-Smtp-Source: ABdhPJzq9H+ulDA7HSm4XAl+g6++hub/RzXE0knh2b5khTcbijWgrKakyXfzTYuxxP0WOJ7OIDGk9qh8pS+P4H9FSe4=
X-Received: by 2002:ac2:530b:: with SMTP id c11mr80736lfh.185.1606783969610;
 Mon, 30 Nov 2020 16:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20201201003118.2219422-1-anders.roxell@linaro.org> <20201201004900.GA48095@roeck-us.net>
In-Reply-To: <20201201004900.GA48095@roeck-us.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 1 Dec 2020 01:52:38 +0100
Message-ID: <CADYN=9JiKQTPbdGFpA1oe2p_yA0eGmiLj=sTpbEyz41+ngir_A@mail.gmail.com>
Subject: Re: [PATCH] drivers: hwmon: pwm-fan: fix warning unused variable 'ctx'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     b.zolnierkie@samsung.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 01:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Dec 01, 2020 at 01:31:18AM +0100, Anders Roxell wrote:
> > When building hwmon/pwm-fan the following unused-variable warning shows
> > up:
> >
> > /tmp/drivers/hwmon/pwm-fan.c: In function =E2=80=98pwm_fan_is_visible=
=E2=80=99:
> > /tmp/drivers/hwmon/pwm-fan.c:167:22: warning: unused variable =E2=80=98=
ctx=E2=80=99 [-Wunused-variable]
> >
> > Remove the unneeded variable declaration 'ctx'.
> >
> > Fixes: 439ed83acc19 ("hwmon: (pwm-fan) Convert to hwmon_device_register=
_with_info API")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> I already folded this change into the original patch.

That's great Guenter, I missed that. I'm sorry for the noise.

Cheers,
Anders
