Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06E2854DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJFXQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJFXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:16:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E877AC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 16:16:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so235409pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7o/CXL35n3q1tS8fZfpwpPjPAJl1YgQm83TtnqAjAg=;
        b=AA/BV+8J+6kUMjPSqrFIdHqpEWCNp8cjc4WVcuem10F8+hKVbVTwRbQHALuumnlvf/
         /oPmjPp/Y3JPzjOvzYhcHBFTBaR6Jtor0NAWZTDa99M3D3Whp4ep2fT6rF2Rs4bV8Flf
         GGtaS/5QbuB0EwnjZ4gnvlhCpeTLXOnwVuzAA019jAUjTJtXx7tU13yYl8PD8qwcXdB5
         4+BHuXYiGs/Gqd0ivw9j8jFahWniuUOElVVR7G/fG+hw/e8ilG1cyZsz5478H4iRylnE
         QOvHxxxg3Ur6zT2as7QJn0Paurw5nNepkSnZLoD+mK2tgkcJc3WbYTzj8B/cnvKW0eyl
         EgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7o/CXL35n3q1tS8fZfpwpPjPAJl1YgQm83TtnqAjAg=;
        b=m0fs33vCNMYuEC+HTLiNcDsqsFmr6wP8qQMl7KKvsMOUtHeluYY4jkOdRrzU0tQ9Kh
         9fb+sfD2KROlMBPnyYtq6Fr7o4nNd67cko4cY5FJRCIMB4QkKf1jWXOvDxx0AM1KkA6/
         emuCA/HqNUAxXABDXDbSsxfMSA4TjroebCVgZa8yQwwtK+iezYAchKPSTXNAZF8Ka2BD
         ZIel4RaHrhHmCnlbQ4xcbodZSQFoY2+M4+GHe5kwAARaz7TIBST6a6xhCzWhWYo2EpZe
         /nNpXjyLdM4F8CkknzAYZna8zptiND1LafvXoxlpNhqlrSkfv8D7fWTZpf9YNdLF5Jj2
         bStg==
X-Gm-Message-State: AOAM533r5SMSaBk5rpXhoq3f4UXt4NeSdptAF5M22QoRVuKUTIYuk0zy
        Y2XkfSkk/Yk9hzrr3idode/DC0Rtg/P7ImUHb0I8pA==
X-Google-Smtp-Source: ABdhPJz9ptOCBriEK7ye2ZndSNQV7OsfEkk7WvofTp/ABQ12ehLRFvgeIDtYX8aKNuiU6rcjrrlU0ZvqTdP7KRDp6Bs=
X-Received: by 2002:a63:d56:: with SMTP id 22mr477369pgn.286.1602026172239;
 Tue, 06 Oct 2020 16:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201006223914.39257-1-skhan@linuxfoundation.org>
In-Reply-To: <20201006223914.39257-1-skhan@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Oct 2020 01:16:01 +0200
Message-ID: <CAAeHK+zb=ieXi1ug_+OskcOLaWPAq2HSfxkwEmd=d1P0DfJx-w@mail.gmail.com>
Subject: Re: [PATCH v2] usbip: vhci_hcd: fix calling usb_hcd_giveback_urb()
 with irqs enabled
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 12:39 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> kcov testing uncovered call to usb_hcd_giveback_urb() without disabling
> interrupts.
>
> Link: https://lore.kernel.org/linux-usb/CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com/
>
> usb_hcd_giveback_urb() is called from vhci's urb_enqueue, when it
> determines it doesn't need to xmit the urb and can give it back.
> This path runs in task context.
>
> Disable irqs around usb_hcd_giveback_urb() call.
>
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

Thank you!

> ---
>
> Changes in v2: Changelog updated with correct information.
>  drivers/usb/usbip/vhci_hcd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 1b598db5d8b9..66cde5e5f796 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -797,8 +797,14 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>         usb_hcd_unlink_urb_from_ep(hcd, urb);
>  no_need_unlink:
>         spin_unlock_irqrestore(&vhci->lock, flags);
> -       if (!ret)
> +       if (!ret) {
> +               /* usb_hcd_giveback_urb() should be called with
> +                * irqs disabled
> +                */
> +               local_irq_disable();
>                 usb_hcd_giveback_urb(hcd, urb, urb->status);
> +               local_irq_enable();
> +       }
>         return ret;
>  }
>
> --
> 2.25.1
>
