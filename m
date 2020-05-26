Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16AB1C6369
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEEVtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 17:49:31 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:57167 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgEEVtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:49:31 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4f07e1f6;
        Tue, 5 May 2020 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=xJmIgem3iFg9PKowp51fvvm73lM=; b=xveQVo
        XP8CDkXw3mj19M9PuSNWOQq9aVnuvgEfUbMlUvLjBQd+7H3lNrYCTNt2OGkyhUav
        OEJe30XmzyFAM1rrsJqN/jxkmPkyiZTFwghfXLClBUYda52Qmdgrv2CuPEVPCjIl
        oZFr6HPWXeyE1v1HtOu8HoC7ESNe5dbS2cW9MBvZKfV1mHRgPMhAHK4tKHjBvdpe
        knFFIN866Oa/mHKV4fHEFdgCxXWm2uFPzqgTkrX3p9FYlR810e2mWo/p8ZaOgari
        9Pkj9b45JSJuZqHW58/gN9GGg1tJGsTleGVceJHuiIyGjYjXBNMUSvu8+ZBGQhRl
        1vIhk5Wh7ZoOcczg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 07102e04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 5 May 2020 21:36:50 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id f3so108017ioj.1;
        Tue, 05 May 2020 14:49:25 -0700 (PDT)
X-Gm-Message-State: AGi0Pubv8AoPBm45U8DEWNB6JrCSnYnD54K7gOla6w+N+xr9pDl8OKJu
        dCEMQtGsJVGDw80AyNhCNL5KYCrBs+AoGZoU+tw=
X-Google-Smtp-Source: APiQypLo3XgcIJGosEVxIb+WuXoR7LYU09mDs2FBkSoKeYcH3eVTaAwCmCzgHKeuwQrsnOF//Fc4ahPqoN2BKgZ9ux4=
X-Received: by 2002:a02:7f12:: with SMTP id r18mr5706843jac.75.1588715364406;
 Tue, 05 May 2020 14:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135947.216022-1-arnd@arndb.de> <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
 <CAKwvOd=OiMUfbNVzQ-Z-bLrsqvPKgG867NBX379rzop62TB0-g@mail.gmail.com>
In-Reply-To: <CAKwvOd=OiMUfbNVzQ-Z-bLrsqvPKgG867NBX379rzop62TB0-g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 5 May 2020 15:49:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9q70DdyOBQTbG5RhYrXVF6RysZWNqVFmETqA1QtSn59rg@mail.gmail.com>
Message-ID: <CAHmME9q70DdyOBQTbG5RhYrXVF6RysZWNqVFmETqA1QtSn59rg@mail.gmail.com>
Subject: Re: [PATCH] crypto: curve25519-hacl64 - Disable fortify-source for clang-10
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 3:48 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> + Kees, George, who have started looking into this, too.

I have a smaller reproducer and analysis I'll send out very shortly.
