Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4892C86A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgK3OZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK3OZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:25:36 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E7C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:56 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so8217412qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtTypiwsf0b9h5jTKeoPZdzRf383vhVBjq0t5nKnT9o=;
        b=gkPAxAaZEIQNxwC3qfhkhbZu51bLASRjL6EV64Ve6HKXFAM/eAKZxG/IFuwsOvArZi
         Jvv7h1FEFBNo5DNVGRshX89NtVXrKWJUgzv31aQgs3k0Yncl+FGjyfU2iz4A6xSIA+59
         w4t36i7gRBO/9UYFiXCENuEaZghaE+qa64fGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtTypiwsf0b9h5jTKeoPZdzRf383vhVBjq0t5nKnT9o=;
        b=RWxl/YPfVFpgW8nHyruBAb/VQRHgt3nEgVbH7SbPRCJ1lFHTmcilSBkV8iTon4rU+9
         dBjQ1gVrpp7MQLN+Ek6lsho7ygiDkYAWZiMDo/p3vi9OquefSN1dKAp1EFOUWA4uLAXR
         EJciSLEBdUQjKbY/B0pI75beDysLMNuRQsreHqa3+RC637KrN9yNWyVPqochYK+fRHR1
         ChRHbbe16BogTqEk2MJnIiqo7UMFr77t9TbPMmBOk6RzoE3gj4SETyuYMQAydFCQCkym
         a/ThHALGStW9Opz61cGcIr+Z9wXvXJvIsBqJUpJZeXfkVhkIEBjiKUub/wksj6XcPn4H
         Xq/g==
X-Gm-Message-State: AOAM532t4HK1FhU/28AYzF/1uzMBQkDyNgxRFerjJtLKle+ZVLHJGIhu
        cIQmwIqLZEND3JdusC34ck0r0Tu1RyAzItu3Wn37zQ==
X-Google-Smtp-Source: ABdhPJweAxZBEyKvSQYjSEhxJN5I6EcODhRQ9HZcX2u3vWR5NSG1RO4581rg3zI/UnOnlenPlgNaJESBlWwVZlnGY+s=
X-Received: by 2002:ac8:5450:: with SMTP id d16mr21799317qtq.33.1606746295526;
 Mon, 30 Nov 2020 06:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-10-daniel@0x0f.com>
 <CAK8P3a15Q=97iWyGu6=2aKfVtrYNL2BgmszHqoqYxFT_uHoP4A@mail.gmail.com>
In-Reply-To: <CAK8P3a15Q=97iWyGu6=2aKfVtrYNL2BgmszHqoqYxFT_uHoP4A@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 30 Nov 2020 23:25:34 +0900
Message-ID: <CAFr9PXksWa_u9TSz6FpTvB0fFMQvpTua7EVKKnfUutmZVtWq6A@mail.gmail.com>
Subject: Re: [PATCH 9/9] ARM: mstar: SMP support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 30 Nov 2020 at 22:42, Arnd Bergmann <arnd@kernel.org> wrote:
> > +struct smp_operations __initdata mstarv7_smp_ops  = {
> > +       .smp_boot_secondary = mstarv7_boot_secondary,
> > +};
> > +#endif
>
> So no hotplug operations?

Not yet. There are controls to power down different bits of the chip,
assert internal resets and so on so it might be possible to add that
later but I haven't worked out where those bits are yet for the second
cpu.

> Or better, use CPU_METHOD_OF_DECLARE() instead of smp_ops.

I'll do that for the v2.

Was there anything else that looked fishy? Every other platform seems
to have a lot of code for moving secondary CPUs from the boot ROM into
somewhere the kernel can control the order in which they come online
(vendor code has a copy/paste of the vexpress code) so I was worried I
missed something.

Thanks,

Daniel
