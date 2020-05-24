Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170241E0113
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgEXR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgEXR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:28:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9CC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:28:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so9277970lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zih7ZsMrjYQCqYbEWLRH+G7lEmyVJyvd9Lwb6ZvIrvU=;
        b=SW2MLdRMFXNNvKoP39IhZYrM/Jwz/2mK6IWqwxhVsbS6jINM029QoPrAJgLqQHzbG2
         xlcgITMNNPoP7p26/U1idl/c5YuBk5iyn9zlqKZupxeDu+i0OC2cwqITf0enHiXfVb4M
         Izmh+jmEuOjfvPSu/aXJRvxqJOM7E71BAq0CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zih7ZsMrjYQCqYbEWLRH+G7lEmyVJyvd9Lwb6ZvIrvU=;
        b=dO4F7RrWOb2V6bCIUPb2taSQW7eTbPZ05WQ+jfCSVoCsS2pPKx+r13l5QkwjSIPEWq
         wKWIx6Z+lpxSmEUnjqmh2INdSDQ5O4gaoae/s5qL0xkdSaV391Uw45UJNhezIMhwggaw
         JrqyCpJLDUA8uKY0vYaMrY+juWL/xgEvzHfZrPCO090OhWVV+xuRsKM1f2mwO6vjozpQ
         /vxpKw6jJIV1zA2NLc0pI8KXttx9klJVHwlh2dt12iMMRFidEGxyI1hrcSKvcuYD9e5N
         OTzCUxIAEl5La3kmM8Ri2JM/vTJN4maj386Mm2i4FPHFXJ7ULM7HGBm7M7JaIIcO16ij
         g/dg==
X-Gm-Message-State: AOAM530+p+qUrxVdrXeS54xA5LU2q8GeVzxrjSJw8BkBkh+i/YwtK1TX
        XpD7eD6jOyD0v+bj78rWIk6Jyyg/JKc=
X-Google-Smtp-Source: ABdhPJwPGn79OUXf2c6ak0SnMD7orHWqWvdHGl+ZLAcFqpZOocZTrx7v/j/uXup55V1+LZ20Nj8+4A==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr12755909lfd.29.1590341319509;
        Sun, 24 May 2020 10:28:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id e21sm2677078ljj.86.2020.05.24.10.28.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 10:28:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v16so18393087ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:28:38 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr9700653ljo.371.1590341318199;
 Sun, 24 May 2020 10:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200524162151.3493-1-rppt@kernel.org> <20200524162151.3493-3-rppt@kernel.org>
In-Reply-To: <20200524162151.3493-3-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 May 2020 10:28:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHEt=c2A+xhjKbW_N7DrxH=EV70B1diY8nYHGio0Bf2w@mail.gmail.com>
Message-ID: <CAHk-=wiHEt=c2A+xhjKbW_N7DrxH=EV70B1diY8nYHGio0Bf2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 9:22 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The addition of the casting to __nocache_fix() also allows to remove
> explicit casts at its call sites.

Ahh, bonus cleanup.

Looks obviously fine to me, but it's not like I build- or boot-test
sparc32, so this had probably better go through somebody who does.

               Linus
