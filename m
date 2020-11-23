Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877B2C196B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgKWX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgKWX1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:27:15 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:27:15 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so26194461lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62XXjbqYUttKDW7QLVDAz8ebJiWeeruFyFjZc2ME1MQ=;
        b=eX0mkSa1IFEx1Crtlq1/XCIc1OeZ/ffiR47s6E2/QiJ6KQVAo4QDhR/CmRczTzALSK
         AvBhlG7pHxY37bFoOnG4De2MWtFKN6YYb5n0cmzEAvkvMrZT7Y8GSRNbi5Pd1zmSDUSe
         MINajG2ZA/qu63TeYlE4kOUf44JaUsAagJlFe8e38VBgFoe0Wvza4f0Ta1fz0MXxvXxn
         4mhJZsihP/KqiY7hqK9CzV+jocAdFhFZGrc9sgMvkuY2uL3cC07Y89kp8HQlK5zn4lcC
         XqFo1mD9yU8DAQYg6K7uzbTS8e+Xu9lyFBG+maKcVeDLegCY7VzcdDzOCOL8qKJXem+I
         c4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62XXjbqYUttKDW7QLVDAz8ebJiWeeruFyFjZc2ME1MQ=;
        b=YRIFwzNrcTYvka5FaZISPPwjHAf0Q4UvERL/3aiiPb0BV6UIPFWmAWVbCwYGTORhvP
         fBXEDDUWVjRTQGjBzDjQ4FVZloQtmH/dCISiHknkJLPdByU7+EgiGQsjJnGddL8e+PBo
         f48up+m75pl3mR9mcQSGQTf7wOFbfJseR2J6DAR+oEP2IFuyZpwFS3B6dGsMEKoNMl1G
         0PqGz5iz/qsHfGfq0zs32Rlc4BVfXOxukfbFvzFsKrIgNsXACiv97qvJG92TYCHT+nNU
         fvcVAPUtS9TAR0O2YZbqq55TiFJ5aTQ4ggr5TWkqKZRtMMqiuhOcNJC5rIwwyEfaQJMt
         O5fA==
X-Gm-Message-State: AOAM5300DZfAK0RAk8yLPSJftig7KvUpOoc0CjO3QiCBeL+0yo6EvJ0A
        95rYhGvb6/Rkn7ejoVIbvWCQgbwTNrA2e5QPXclP6A==
X-Google-Smtp-Source: ABdhPJzGfZCTZBEIZEGFV1gxU2z+T+t5mQtOQkhNOceO/OEzRLYH3IFCYdCd4+jCQ8prtZXhlNnogj9okxaTGvZNiFE=
X-Received: by 2002:a19:740c:: with SMTP id v12mr522681lfe.502.1606174033954;
 Mon, 23 Nov 2020 15:27:13 -0800 (PST)
MIME-Version: 1.0
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
In-Reply-To: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 00:27:02 +0100
Message-ID: <CACRpkdb4+av1sDrQHYXYeyKemnm2a9PFGQbu++UHEe6sspRACQ@mail.gmail.com>
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     Andre <andre.muller@web.de>
Cc:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 9:18 AM Andre <andre.muller@web.de> wrote:

> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
> mxt_acquire_irq() when necessary
>
> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "Samus".

This commit also breaks the touchscreen on the Samsung GT-I9070
mobile phone. All interrupts stop appearing. If I revert the patch
I get interrupts.

dmesg after this commit:

$ dmesg |grep mxt
[    1.967816] atmel_mxt_ts 3-004a: Family: 129 Variant: 1 Firmware
V1.0.AA Objects: 18
[    1.975815] atmel_mxt_ts 3-004a: Enabling RETRIGEN workaround
[    1.982398] atmel_mxt_ts 3-004a: Direct firmware load for
maxtouch.cfg failed with error -2
[    1.992252] atmel_mxt_ts 3-004a: Touchscreen size X479Y799

dmesg with commit reverted:
$ dmesg |grep mxt
[    1.967831] atmel_mxt_ts 3-004a: Family: 129 Variant: 1 Firmware
V1.0.AA Objects: 18
[    1.984195] atmel_mxt_ts 3-004a: Direct firmware load for
maxtouch.cfg failed with error -2
[    2.007399] atmel_mxt_ts 3-004a: Touchscreen size X479Y799

And I get interrupts.

Tell me if I need to test some more approaches.

Yours,
Linus Walleij
