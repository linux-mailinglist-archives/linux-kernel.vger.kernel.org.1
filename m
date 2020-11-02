Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE42A2A73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKBMM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbgKBMMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:12:25 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5C2206DD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604319144;
        bh=nGTVuUBTENpQ2A0moLT+om0wH11rswVZVeBCaRVHUeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nRirczYoS7bx9xC5/5w5V6gJBg3fxs54JXJRCk4iJ4Smk6V+9go6AXAelRW8KewAi
         UwtPv3nMbmL+aX4c1Yaj3w7DHJGDCFV0p/RkfYIGHCeW9HLbU0+LBCOzFPZQW/Zt8J
         w7LAlHP77be4tfqBuRv3KDwE5W4ye733iNvFnFFU=
Received: by mail-ed1-f52.google.com with SMTP id o18so14139729edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:12:24 -0800 (PST)
X-Gm-Message-State: AOAM530O5k0DXr5cGNe7XNa2fp2dD//jkl1ssVxzivFu6ari1XmgaoPt
        /8brZapeQKjcsjC6zNptiW5TUQ/GrONaCunw2rc=
X-Google-Smtp-Source: ABdhPJzJ/0zYgptPoddLHxtPRo4Sfqolqs4YqPB75SaMb70qUkw2cXYwxUpX1PMfP7ZHD1C2mZmg30MkMMedqG1EG4k=
X-Received: by 2002:aa7:ce04:: with SMTP id d4mr15788401edv.18.1604319143048;
 Mon, 02 Nov 2020 04:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20201029132720.13962-1-krzk@kernel.org> <20201102120311.000078d8@Huawei.com>
In-Reply-To: <20201102120311.000078d8@Huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 2 Nov 2020 13:12:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPenxcGTZUT0E=VBaknQ=imEAP-ExXdrEPP-mkTaNPP-FQ@mail.gmail.com>
Message-ID: <CAJKOXPenxcGTZUT0E=VBaknQ=imEAP-ExXdrEPP-mkTaNPP-FQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] MAINTAINERS: add Dan Murphy as TP LP8xxx
 drivers maintainer
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 at 13:05, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 29 Oct 2020 14:27:20 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > credits and add Dan Murphy from TI to look after:
> >  - TI LP855x backlight driver,
> >  - TI LP8727 charger driver,
> >  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Dan Murphy <dmurphy@ti.com>
> > Acked-by: Dan Murphy <dmurphy@ti.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Sebastian Reichel <sre@kernel.org>
>
> Typo in patch title unless I'm missing what TP means!

Thanks, this should be "TI". I will send a v3, unless Lee corrects
this while applying.

Best regards,
Krzysztof
