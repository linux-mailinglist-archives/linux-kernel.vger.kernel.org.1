Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CE2AAB4E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgKHOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgKHOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:05:27 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB4C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:05:27 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so7181692ioo.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s9iUnuvzMr0jTxtP7UBZvtqnmf/dn3a+7ZhpOxSMBg=;
        b=jl/88X5Tm/SCl72iV4CXU3VFZxsPW/YJjetxZG8Eluyh6AttyomUmF5MBxdQWUSYuc
         CbPp6NraHhMHHl3ZKL7ucZZxZGt/JMt76jD6Pfe4OAyBviar1cshn0JBQcFUoz1VrhGz
         hEm2nqcvU3tdilLOPQ6KyE39QJQP7mi1zVMir8Elrt1GEgy6opE+H/EjzOWVL6GWXwJt
         thEEAx9JKJa44Dp9r+JhPi9UzyGzcIvdPYkSRvAgJPQu7wnWYnfCzLT1THAI9j/hxavh
         pG4QlX5QTHk2t4+0wV/snB68LPu6rl4o5AoDN+68Ee2Qx7DrKYEPjcwBA7TGeEtplCAD
         Alkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s9iUnuvzMr0jTxtP7UBZvtqnmf/dn3a+7ZhpOxSMBg=;
        b=iW0c5pnJQEOtMqSRGP199X0q/b0Wakyg6tl3c0agiEpGBHoiRCcybgcbvKh2eVa54G
         w5+Ix76Yp/hAnGfI84UDzSCZ9lG+NRyuBC5x2/MvxX2GugkCdGFoybivMUEdT2tVs4kl
         aDwY2UdAmdwuBkmp6ohCAxIR5pK2OMlRQD5sQgJIX4BADQS/lXxPnG1Qe8TtD76THHWA
         8vVR4rKoxl0qgN8pxGWeNGskX31DSFIohABQSTKhZFT3ElLGS5Xtyh1pl6L7+a2s4kve
         dd0Ob2lafq6/Mj8BJUK6Qni0j9UABvGuSuLI/3zY4F5FiAJfsU+xTePwO/CoIsXInW+E
         FZZA==
X-Gm-Message-State: AOAM533XP57Y/vjrSOY8Gjx4JwfBeW8G3O2h9kQ/Hg0GOTIik/HL2Ud8
        sCGzmTuT1Ydq7wuwjb03ocAJbYt/vZQqTTh6rCI=
X-Google-Smtp-Source: ABdhPJwQVLHeWujannU7dCZFejWHeD7gmYjCsahqcgYQ9VqkTjI42ESskbno3vxCqdSgfBp8sC+c8v9ZRIrVLa5ourg=
X-Received: by 2002:a6b:4401:: with SMTP id r1mr6978212ioa.78.1604844327200;
 Sun, 08 Nov 2020 06:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20201016132047.3068029-1-hch@lst.de> <20201016132047.3068029-2-hch@lst.de>
In-Reply-To: <20201016132047.3068029-2-hch@lst.de>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <gmpy.liaowx@gmail.com>
Date:   Sun, 8 Nov 2020 22:05:16 +0800
Message-ID: <CAL3PxMr+Y2Jn1KabmqATWqq+EUJf1YN0_rKU+rQydbu9FiAvAQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] pstore/zone: cap the maximum device size
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 9:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Introduce an abritrary 128MiB cap to avoid malloc failures when using
> a larger block device.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/zone.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index 3ce89216670c9b..5266ccbec007f3 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -1299,6 +1299,10 @@ int register_pstore_zone(struct pstore_zone_info *info)
>                 pr_warn("total_size must be >= 4096\n");
>                 return -EINVAL;
>         }
> +       if (info->total_size > SZ_128M) {
> +               pr_warn("capping size to 128MiB\n");
> +               info->total_size = SZ_128M;
> +       }
>

Reviewed-by: WeiXiong Liao <gmpy.liaowx@gmail.com>


>         if (!info->kmsg_size && !info->pmsg_size && !info->console_size &&
>             !info->ftrace_size) {
> --
> 2.28.0
>
