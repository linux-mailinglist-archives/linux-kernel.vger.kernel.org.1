Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5740A27A180
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI0PB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 11:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgI0PB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:01:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601218917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hs5rdUJVOmzg99SVlEBJlBQFGXQLPQJ2GLdFN3MjFs=;
        b=ZqnMTfgAjasze6mCvo/28IVH7A5gf58YIwpj/Oo2oiBprfFaoumtJcq3dsrtyZpeJuDNXh
        rVHom251RK3ICJWXR5PN/ULHma36fUzuxe+FDivwQ/S09fL8Jr2hDAPrji7xwB7rz7R1pe
        6csiYIKWuaVASfcONKcJWXhjLp/ZHNg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-VmXtMD4VNIa27Wxrs5CI5w-1; Sun, 27 Sep 2020 11:01:56 -0400
X-MC-Unique: VmXtMD4VNIa27Wxrs5CI5w-1
Received: by mail-ej1-f71.google.com with SMTP id md9so2187297ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 08:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0hs5rdUJVOmzg99SVlEBJlBQFGXQLPQJ2GLdFN3MjFs=;
        b=pwchudv/7QZnz3RyTMmxVF76bY96f/X3l0JOSLH3P2Iyf3gwk0N1+Q4PrIJe0Fd9Fh
         SJ7qLflX9m/W3A0Thh+nhVSk9VWhHelw0aa0Cxc5RrIW3jeKaocCl+zJkewf6avIrHwK
         VoOSz2V3HFEwriSvGFdAEWpW8KdhlJ+DPTfoFMUqo13nc3uHpJpTRYqEAnPVq/JyfAOQ
         8IsXrMmbAfhRI2KH6MwMhUXO9mWx9uzsZ49ZmezfQ5IwfE4eBiyri0hQ3/F6zwyb7Fxo
         mhPe6zOWUtrZXEEeq7v6IlQAxIHdhLA/bThjBNfWvJv9vPO045iQWvm88D6c9Ntj1G3G
         4a6A==
X-Gm-Message-State: AOAM5303jWXQzjmKSqgjpGsqKiJxAEvGgAjjeeR09JziUTSLgiqQF5pg
        MN2ugCvcarhYprufa+J0QYFBDheUAzg+xD2kxyfRNCC0XAW2K8mFIzYppA5LAkCeAzo1YFneyBj
        gQ3pwkM0hzCm9QAwpacIMN8DS
X-Received: by 2002:a50:bb65:: with SMTP id y92mr11310108ede.53.1601218914414;
        Sun, 27 Sep 2020 08:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9xBEE4fL9o6SH/mCyn1ClksiNMLfDL1ho7Cw9z0Iz424ysBl96z0clzUKT7OhlnwXh9r6fA==
X-Received: by 2002:a50:bb65:: with SMTP id y92mr11310082ede.53.1601218914188;
        Sun, 27 Sep 2020 08:01:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y14sm6602549eje.10.2020.09.27.08.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 08:01:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] serial: 8250_dw: Fix clk-notifier/port suspend
 deadlock
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e508b9c8-bcc4-00a6-0ca0-0b4a0c34f626@redhat.com>
Date:   Sun, 27 Sep 2020 17:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/23/20 6:19 PM, Serge Semin wrote:
> Hans has discovered that there is a potential deadlock between the ref
> clock change notifier and the port suspension procedures {see the link at
> the bottom of the letter}. Indeed the deadlock is possible if the port
> suspension is initiated during the ref clock rate change:
> 
>      CPU0 (suspend CPU/UART)   CPU1 (update clock)
>               ----                    ----
>      lock(&port->mutex);
>                                lock((work_completion)(&data->clk_work));
>                                lock(&port->mutex);
>      lock((work_completion)(&data->clk_work));
> 
>      *** DEADLOCK ***
> 
> So the CPU performing the UART port shutdown procedure will wait until the
> ref clock change notifier is finished (worker is flushed), while the later
> will wait for a port mutex being released.
> 
> A possible solution to bypass the deadlock is to move the worker flush out
> of the critical section protected by the TTY port mutex. For instance we
> can register and de-register the clock change notifier in the port probe
> and remove methods instead of having them called from the port
> startup/shutdown callbacks. But in order to do that we need to make sure
> that the serial8250_update_uartclk() method is safe to be used while the
> port is shutted down. Alas the current implementation doesn't provide that
> safety. The solution described above is introduced in the framework of
> this patchset. See individual patches for details.
> 
> Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com
> 
> Hans, could you test the patchset out on your Cherry Trail (x86)-based
> devices? After that we can merge it in into the kernels 5.8 and 5.9 if
> there is no objections against the fix.

Done, I can confirm that this fixes the lockdep issue for me, so you
can add my:

Tested-by: Hans de Goede <hdegoede@redhat.com>

To the entire series.

Regards,

Hans

