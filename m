Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003F12BA458
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKTIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:09:24 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40746 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:09:24 -0500
Received: by mail-oo1-f65.google.com with SMTP id t142so2024320oot.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InNbA7CRjLYtLhlk26DHO/uIWWNOi+DN6zjuKNiE/Ks=;
        b=QmDATsJ95zDrnlMT7cKf3ewGAsErRNMOOgNiYtjzuLG0mA1FnWMzeV0NAmcBOIhEi/
         zF/T8FddAc8KJal6z6kMFr8U8HmJn+9RcmPtYJApa8GuQ8d2EsG5XphB8GcFa2CsgU/v
         O5mwt66vzzmCrhbBbHY8gISmY5M/lrZx3Cu8TbGbyoA+EYjaUqR6fYx1F5IVjXZB91ex
         z5tEqfw64Z1i3DzpaQhW4ryZQdBtwsLlVxb/4SnUc1k87NV8xOSZMmWB0by9++1nFX6X
         +vX49J90iBhNcPNQ0+2CGyO+p+diyIOu2V0KL2MofiN2JTNbpR4dR4MI4M8FjYlqcZtq
         Ioiw==
X-Gm-Message-State: AOAM531WJmpfsvHaNO75zYS31lYhtjwTmbiArjADTxuiiExJ/shOkyQa
        PbUMYrJeLdksM3VUI6ymvwAQ88mP6M1hrE8MQjkAcQo7Qoo=
X-Google-Smtp-Source: ABdhPJxGwm7/S5ctN8aQPOK7rG35tOPLhSt3z2MThLsdzZA1IkYeZDNG+QHEOYf8XzjUIIBm2N3HdRGurzA1HWWneiU=
X-Received: by 2002:a4a:e5ce:: with SMTP id r14mr13347126oov.11.1605859762129;
 Fri, 20 Nov 2020 00:09:22 -0800 (PST)
MIME-Version: 1.0
References: <1605852474-23446-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1605852474-23446-1-git-send-email-tangyouling@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 09:09:11 +0100
Message-ID: <CAMuHMdUq4ghBczAXOb8pdVc5=Uv5kUDmBdKW0O4VCkeQ7pBnuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: Drop redundant NOTES in link script
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:08 AM Youling Tang <tangyouling@loongson.cn> wrote:
> Commit eaf937075c9a ("vmlinux.lds.h: Move NOTES into RO_DATA") after
> should remove redundant NOTES.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
