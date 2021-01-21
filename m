Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55692FF6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAUVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbhAUVLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:11:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20245C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:10:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v67so4584570lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNDrIesQBMT+L7yI5WzMZVksP2sWpDQawNGFxdnXsVc=;
        b=YH89x/0HgEErWXoTAUXprkP3EHdeEN46kljJDNBHcff7MrXy7u4CRasLq//STK5KYg
         NiErWYVfHmqNO+Ee5yf7schI12GFshlJ1YfEvUy5R4K9gVQJxXQaiMsviiyQQd2RgENj
         orniTEbi/3tc2vtYG8Va0woM+RDTwwca2RihY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNDrIesQBMT+L7yI5WzMZVksP2sWpDQawNGFxdnXsVc=;
        b=TErUAQBN5xuPL1c8Usu9Noy7+c1iQ5m0vlnOtEcSsPL66r+Mk/Jh4Lzcyf00yYqALK
         Afa6bOnXr/dIad/cVYiVKNbVT2JraBjWt7dnBdAwrV7N+KOc1u5rAc93ckjLQZIXEx2x
         PSXE0BVWFow13I98wvwFFVESXNvD1GGSyt2/SuIUDBa07QMuf+XQKaYwvRU3K9K4fQbb
         wO+ZP+A+K+PcWGkmeEZclyCKgqJw6pDiLAKngwOQ1jUCVaZVILKkb4nElPYXoJTchj9y
         L9xRxL99oQzhmoPGtxuFkl3MArmbE1788/PNLDBtlR5JoUiE/dgvKjdfqM00km/1Ighd
         1b7A==
X-Gm-Message-State: AOAM530a+uM6266SoA1vTiRSkNJvicy/PZ2uCwYRHyvOrRpPLEadZ5kc
        nDyXiQENxuojJEjCqCyt6yaDTmlFGkbjDw==
X-Google-Smtp-Source: ABdhPJz2jmtcAlqEw9AtwYk3TZ4ZuDqFPsCGywnENJJnePeVZmxCwtXem4sVv2zwV0LD/7cwZVpy9g==
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr540927lfr.418.1611263409866;
        Thu, 21 Jan 2021 13:10:09 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d21sm419528lfl.199.2021.01.21.13.10.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 13:10:08 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id v67so4584387lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:10:08 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr124334lff.201.1611263407882;
 Thu, 21 Jan 2021 13:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org> <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com> <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
 <YAnZaYj1ohUNinaf@kroah.com>
In-Reply-To: <YAnZaYj1ohUNinaf@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 13:09:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
Message-ID: <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This works, thanks for these.  I'll wait for Jiri to review them before
> applying them to my branches...

Let's hope Jiri sees them, since he had some email issue earlier..

I'll add his suse address here too.

           Linus
