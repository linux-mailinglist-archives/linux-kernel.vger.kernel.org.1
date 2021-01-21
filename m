Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCA2FF24B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbhAURqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbhAURpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:45:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A876C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:44:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o13so3721262lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U81V49ur3dHeNfR2mGmxG8g2lxIGYuZqdyDFav7Wwus=;
        b=acVqVBvFfDkHfeYSjKNJ6xB8y93f3kYfkMTXljxH7MyxPeRHY0TsRnB7hCRJfyB1/q
         ODqjEM7rcckOjtzdAhrWVHfMEqBPH3j+jZUgBGmPd381zNTat4Xucm95Y7pQ55wC/mlb
         xyRRvPQ+uPWM07UC+J/SoxVCBsDpkTC+4Ynbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U81V49ur3dHeNfR2mGmxG8g2lxIGYuZqdyDFav7Wwus=;
        b=hF2thXJkWgFSymHL0f2D/GcNpplwDOXMnE0su0CSudrhiSQrWVEv0OekjW8xbbbARB
         PUINWixi1oAe7zFMF4g6Y+WhYKHsZh3LCt4kBwRcbTXB28+rycJTxK2L960CIVTXmMmW
         9eE/spVuriYcpruzBjg+D3gRf26Y3PBTRHjx0hVl3RXygOp6sn2s28x5BpL+A50BIgCL
         Racb6YnnvX5aZfB17C6skQpZ9cQ5DdIzQY+LzT7+ChTmuTCqYIoe1YkJ140LuQvY/TPl
         H9ce4QpBxk/DAY7b+tDntecgEoGq2rGXRZqym75WSkoLx0UvJl1+MYBmDAQneX2EWilL
         p06A==
X-Gm-Message-State: AOAM533xvtAqlelRi83Zjeuv+aYshKGRwmDppnyV8B92BX7vBRkn9ItH
        AUWnyLFkjAJ0zS5yTxzFgWNmnPvxHekDmw==
X-Google-Smtp-Source: ABdhPJwLaExJzxpv81mm5/iqEXBcrt2F2tJa8011+MiVB17mqBbADgqCncybiSbCwU+K5KpUC0mvbw==
X-Received: by 2002:a19:f60c:: with SMTP id x12mr149527lfe.564.1611251076152;
        Thu, 21 Jan 2021 09:44:36 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o138sm591494lfa.171.2021.01.21.09.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:44:34 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id o17so3717080lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:44:34 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr163317lfu.40.1611251074190;
 Thu, 21 Jan 2021 09:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org> <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
In-Reply-To: <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 09:44:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
Message-ID: <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:40 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Ok, here belongs my earlier note: "if ld == NULL => crash here." That is
> if hangup happens during the ldisc wait, the kernel will crash in
> tty_ldisc_deref.

Right you are, good catch.

> Is there a reason not to convert hung_up_tty_fops too and leave the
> return hung_up_tty_write here intact? This would also solve the comments
> above.

No, no reason. I started out just changing that one tty_write, then
noticed that I had to change the redirect case too, but never then got
to "yeah, I should have changed the hup case as well".

Greg, do you prefer a new series, or incremental patches?

               Linus
