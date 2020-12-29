Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF42E6EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL2IeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2IeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:34:07 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4FC061793
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:33:27 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x13so13998281oic.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzL5OPHv3mWjmx1l9cT/jFzRb4YxfwRuJjsIlWyqNWA=;
        b=LKoUXihABs39u/GdX/F6L0eyuhlQLQaUNhTePHZgV9E4Jy/SrhAzXXOxVsSXFLmuop
         XB1iwsytNVbDlZoCKu58Ah4LgTya9paJvC1WnmaF7NOVscO8pVof68sQBO6MjBxdqpDA
         +dWdRXCSfCcps+K3Z/u5lLf8GPHDNA+SkzyIzcsJzoI7MxffZXM7bGWb6Mjnb+f0KQwc
         m4cQFb14q852uj9nsryVrZ0gM7Gw2t76xpnmLNafyR5Wkae5ggGsiZNOZgqrgCuGqusz
         B0iwXnvke4t8ZrMXNK9yTSjmAWOTeG5PDHnN/viEyYh+clk72vDd3f/X3VH/vXvnD+0O
         jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzL5OPHv3mWjmx1l9cT/jFzRb4YxfwRuJjsIlWyqNWA=;
        b=YLumMNeUaUmpDsCMcz5oxUrbRQrrcH49xD0KhJhw+3Y3ZPJQssNVOqu9NGiuG3aEyN
         mz2YkFVYIvoxPowX/5cA9wHq8tvE6adMWB9f7jIcHP72H30ZhlDgqhgzHp/Vw+UJUGVL
         yovDyQwGPZQqDL2w9qHMFdTJ9wXX1NiIVZ7G3z+ZnQDQJThXl9BzTGbv0viDGML3GK4l
         GbQn1cnpT7jGWBKdW4C+r8yYK4RX6Gn+RHsFkjSp8XDqbpaN88MA1ECkp6GS4QGVHrRu
         fxBjQ1+sN4uzTF2Qkj5tCKGzewAAkr2imd2W2kbhQVfZEOXwE0ulZR/Uz7EZ9i+so7NC
         0eWg==
X-Gm-Message-State: AOAM531tZouO8ngI7cr59ITT6bX/VmyDiFSm5gDYNyMMTWcjRFZiuDXc
        x1bJ7ZJOohZRY/b1/3bXxM2jWWDUqLc/OUd1yko=
X-Google-Smtp-Source: ABdhPJyOKK2EHe8CiPVaq5adTOd/dPQEa6D+dktW5VFsB4iJGMmwJNzELBFP9hK2VhKHdjXU/Ml33rkpweGr3Qj+6r4=
X-Received: by 2002:a54:400d:: with SMTP id x13mr1667443oie.81.1609230806510;
 Tue, 29 Dec 2020 00:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20201228215402.GA572900@localhost.localdomain>
In-Reply-To: <20201228215402.GA572900@localhost.localdomain>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 29 Dec 2020 00:33:15 -0800
Message-ID: <CANaxB-yKRpFx+SkushhG2v5=f9J8TFNPMv9YEcsg1=91QyRRzw@mail.gmail.com>
Subject: Re: [PATCH] timens: delete no-op time_ns_init()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 1:54 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei

> ---
>
>  kernel/time/namespace.c |    6 ------
>  1 file changed, 6 deletions(-)
>
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -465,9 +465,3 @@ struct time_namespace init_time_ns = {
>         .ns.ops         = &timens_operations,
>         .frozen_offsets = true,
>  };
> -
> -static int __init time_ns_init(void)
> -{
> -       return 0;
> -}
> -subsys_initcall(time_ns_init);
