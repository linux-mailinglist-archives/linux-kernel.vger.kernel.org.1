Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED22DBB09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 07:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgLPGHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 01:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPGHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 01:07:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:06:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q22so13289189eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9AP4hw+wrttYBnxzNOz611fczoKnvpoptmLkl3njAc=;
        b=uCkxp1DtDR8O38TsTawozwXfHW0r0UfgemU5OYPTGeEoXsHQcs6LNadpYloE9x/u5f
         UzoB0w61uo/f5r0fQD75m+h8ymUZ5cBJfnfQXSm9o70V7rL8ncPX+xEuy+l1eRTdGFut
         iDa26evduTsVNkktkgOfTBS2qquBvk/BPIOJqyAr8txqpLT7gqT98eTLGrNaCMYeyRy7
         TTlDUh9J9ZTIcMjMOFawduh7QAJqo+kB7z350mwq3ZCI+QDjFYQ+FOlR2xXG5ZuMc7LI
         4CZ1LViaJARDUg0Gkc7kT44AvyiYfSS+MXWu9vPk5DmY+jnsNa4VkxKu3WKxPNYjIo7i
         gShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9AP4hw+wrttYBnxzNOz611fczoKnvpoptmLkl3njAc=;
        b=k0Jj4cQ2+ABr4ngnMBsQ1tRoNfECMLtpmFvis3yZ4a7ZsEw7LrqkqpDs6MIb3CC0L2
         QgcZsHcYpVtyYcxOcqlQHMlGusDVqXXSrAQpYZExygQ5W2ERcKr8jU2RGZ0u780al+iE
         GJvk9+yvcUfj63aPbHywVTtWCssDXfimZz61kZ3ytmCMAKnfDnESXhHEqLXSw7lq53vV
         L9pkJhjJIAsIyWKnld2HG2MO3Vg2zsVpJe3s0SGy63TIaqOJvxPs/7nk70iNdjVFw+Mc
         Vyse7L7f643gIC59td9w6MLu85qprZqsQwSa7wPiZDxsGaAo3X+jeVNKBAUKicStTExA
         gG7A==
X-Gm-Message-State: AOAM533ezDhwCVm0sJb1skYRJ/6mUF5jIsJa9+9/RO2Fk4Z9tKoFIjal
        NKFItuhbhu1IdXfTunvBQfx10AgD2Gv4xsm7srogaQ==
X-Google-Smtp-Source: ABdhPJzkiJK2xyrc2QwSC8CVZIupa2XWCcT1uQyhVvTVyuCsU8VdzP96S9LSL2lvAk84LlpkUpqQHdEZw7zDznsaLQ0=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr29965062ejc.472.1608098801569;
 Tue, 15 Dec 2020 22:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20201201135929.66530-1-wanghai38@huawei.com>
In-Reply-To: <20201201135929.66530-1-wanghai38@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Dec 2020 22:06:30 -0800
Message-ID: <CAPcyv4gAmPLQnNwenDoaGQ7Ah9-eEkuL2xSoqi_zyg1waZYg9Q@mail.gmail.com>
Subject: Re: [PATCH] dax: fix memory leak when rmmod dax.ko
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:54 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> When I repeatedly modprobe and rmmod dax.ko, kmemleak report a
> memory leak as follows:
>
> unreferenced object 0xffff9a5588c05088 (size 8):
>   comm "modprobe", pid 261, jiffies 4294693644 (age 42.063s)
> ...
>   backtrace:
>     [<00000000e007ced0>] kstrdup+0x35/0x70
>     [<000000002ae73897>] kstrdup_const+0x3d/0x50
>     [<000000002b00c9c3>] kvasprintf_const+0xbc/0xf0
>     [<000000008023282f>] kobject_set_name_vargs+0x3b/0xd0
>     [<00000000d2cbaa4e>] kobject_set_name+0x62/0x90
>     [<00000000202e7a22>] bus_register+0x7f/0x2b0
>     [<000000000b77792c>] 0xffffffffc02840f7
>     [<000000002d5be5ac>] 0xffffffffc02840b4
>     [<00000000dcafb7cd>] do_one_initcall+0x58/0x240
>     [<00000000049fe480>] do_init_module+0x56/0x1e2
>     [<0000000022671491>] load_module+0x2517/0x2840
>     [<000000001a2201cb>] __do_sys_finit_module+0x9c/0xe0
>     [<000000003eb304e7>] do_syscall_64+0x33/0x40
>     [<0000000051c5fd06>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> When rmmod dax is executed, dax_bus_exit() is missing. This patch
> can fix this bug.
>
> Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Looks good, applied.

...with some fixups to the changelog to add Cc: stable and change the
title to "device-dax/core: Fix..."
