Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4DC2CEBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgLDKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:09:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42336 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:09:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id l200so5551696oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vJmJ6rt51XGfyHKdiHaiaw3R9dpFJvdi4CGbEaDzt0=;
        b=tqNZKnjBbShstXdRbHYKgzXHcsDigib9JO3gmX1/jKZCsOiLd5TWbCC9ZVHkjRa7Hc
         48iecjSk9+5bVvvPQZEY2v0ohxKW1XzJpOQC7J13JHE+QbI4aF4acMKZkIj6Ee5N2R6L
         NBI0Ra2nTmKIXDMtz/mpbj/WrsbGdA9AYo98VEJKqs/RostkIk2uMEYydd4cdiKgT1lg
         MAA97NK7jJn6RWWW+yTrBdiWgCeORYeGE8OQ5Td6XCrjLJwkMJKIsVsMkdxuDbpOtltW
         rtgMrfSfThHmzm1/Okj1zrocNl4xrGXaWgN6mmNgtinfNGj7dq44k+DrIci8BM0SU1K0
         3WGQ==
X-Gm-Message-State: AOAM530gKU5fALBRlzvmX3uuuEVYadFjW7M6BrQ+bLdS41jDApbOYAbw
        QBWAEKsOY742yE0z2r234RLgBj1bXbAwmHL9ZeyO0A3uU94=
X-Google-Smtp-Source: ABdhPJzA2Jell/icS2mx5nSxlBHT0Lu0M6uda7dE4x2w3itTDp6TarggWiWyTkMGUD/a98PKof7GXM0aCuiIqCCT8Yc=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr2633455oia.148.1607076502495;
 Fri, 04 Dec 2020 02:08:22 -0800 (PST)
MIME-Version: 1.0
References: <0f0a25855391e7eaa53a50f651aea0124e8525dd.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <0f0a25855391e7eaa53a50f651aea0124e8525dd.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Dec 2020 11:08:11 +0100
Message-ID: <CAMuHMdX5yUaCWYsM7WgatYSDLZMcSckugOQxBBnBZOB_eJm=1g@mail.gmail.com>
Subject: Re: [PATCH] macintosh/adb-iop: Always wait for reply message from IOP
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Nov 20, 2020 at 5:54 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> A recent patch incorrectly altered the adb-iop state machine behaviour
> and introduced a regression that can appear intermittently as a
> malfunctioning ADB input device. This seems to be caused when reply
> packets from different ADB commands become mixed up, especially during
> the adb bus scan. Fix this by unconditionally entering the awaiting_reply
> state after sending an explicit command, even when the ADB command won't
> generate a reply from the ADB device.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: e2954e5f727f ("macintosh/adb-iop: Implement sending -> idle state transition")
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/drivers/macintosh/adb-iop.c
> +++ b/drivers/macintosh/adb-iop.c
> @@ -84,10 +84,7 @@ static void adb_iop_complete(struct iop_msg *msg)
>
>         local_irq_save(flags);
>
> -       if (current_req->reply_expected)
> -               adb_iop_state = awaiting_reply;
> -       else
> -               adb_iop_done();
> +       adb_iop_state = awaiting_reply;
>
>         local_irq_restore(flags);
>  }
> @@ -95,8 +92,9 @@ static void adb_iop_complete(struct iop_msg *msg)
>  /*
>   * Listen for ADB messages from the IOP.
>   *
> - * This will be called when unsolicited messages (usually replies to TALK
> - * commands or autopoll packets) are received.
> + * This will be called when unsolicited IOP messages are received.
> + * These IOP messages can carry ADB autopoll responses and also occur
> + * after explicit ADB commands.
>   */
>
>  static void adb_iop_listen(struct iop_msg *msg)
> @@ -123,8 +121,10 @@ static void adb_iop_listen(struct iop_msg *msg)
>                 if (adb_iop_state == awaiting_reply) {
>                         struct adb_request *req = current_req;
>
> -                       req->reply_len = amsg->count + 1;
> -                       memcpy(req->reply, &amsg->cmd, req->reply_len);
> +                       if (req->reply_expected) {
> +                               req->reply_len = amsg->count + 1;
> +                               memcpy(req->reply, &amsg->cmd, req->reply_len);
> +                       }

So if we're not expecting a reply. It's ignored.
Just wondering: what kind of messages are being dropped?
If reply packets from different ADB commands become mixed up,
they are still (expected?) replies to messages we sent before. Why
shouldn't we depend on receiving the replies?

>
>                         req_done = true;
>                 }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
