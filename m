Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5E2F4D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbhAMOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbhAMOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:47:05 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F6FC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:46:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z20so1221739qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfGUinF7cIPTVWbvopOeCfPw7+d2tiRR9kb2ydRYjts=;
        b=J4/q39rXLtLSsirgM/gp1ycmF+EZoU05U8LXkrMPwtg4txTNhNhQnlC2qYlKMce0oe
         +ZdYlec0FYkjTXfKKU6QDihEXaFhAZqO49Zs7BW2uz2Dji4aTKNSgwmmcM6klgcdazVH
         77e45GEIUaThtehfmed1GqE5qIu5QIWqCf3cMtp/9Scg+5Qff6/rmi2FIe6yr2K7QyPv
         osxiCBsEs2VWHrPO8zB7NauGwnEJQquo5ZxK5UEg+8TSwyiO9/ygO3WjtIkgFK2jdi0i
         Ecu/jlSSCeRJOpAZ9O88Ki4nY7cQW3aDWL9t1FfU3w/B8Al+Euiv+9jcJ/SEWCjsETQw
         04lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfGUinF7cIPTVWbvopOeCfPw7+d2tiRR9kb2ydRYjts=;
        b=YS2saLPssJXi5gJqP+MsEBauP29KWEsvuAUR4LZZQkYu4/SFt67NBawAm8FcQRtIKD
         2LQ5vZqloN9ycPSJj2/UOgAkBpfRF2Hiv8FE0Ra8byO1HvH4nSfixm9IctLla5c1/juP
         qDBddJ74KqPSOJyetF9DDNcvUC4MPtqAj6XhFnq1kunv02WE4VbO85PG+G6Wwq62vPG5
         Z11jBTUQHAY6XJu3nGnxTLRuvBHQFnTfHoQI0x+eDW/CCEkFCESriShijEGUML5Okh+Y
         WqaCURK1h2vYpSqkeH1QYdDI1xnoGm2j/4zpowWRk5GdIsLt9vNTDMwgG4vfiV6DtNdh
         bwEQ==
X-Gm-Message-State: AOAM530d4+UzzCjTZwmfNXOUancXo5qsVGq81L5n+beHmzZtmL5SjWEb
        VWUO5Tb3JoBeiu3LLnPtDMRx7hmU/zSqW9Mx9ZN5DA==
X-Google-Smtp-Source: ABdhPJxCZUYFPKRkRp+8ZnKVitwhmKl8Ad+YqI2IDh2gNMAeAXwAQCGaocnlgrViF6jLN+wp7Dc8WXRz9Zl4mReX83U=
X-Received: by 2002:ac8:877:: with SMTP id x52mr2584682qth.334.1610549183656;
 Wed, 13 Jan 2021 06:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20210105163927.1376770-1-kyletso@google.com> <20210105163927.1376770-2-kyletso@google.com>
 <20210112132925.GC2020859@kuha.fi.intel.com> <CAPTae5LLtjQAt4db+ZVttEGxnueydmEZ4eu+gQSEOaZE4B=u0A@mail.gmail.com>
In-Reply-To: <CAPTae5LLtjQAt4db+ZVttEGxnueydmEZ4eu+gQSEOaZE4B=u0A@mail.gmail.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 13 Jan 2021 22:46:07 +0800
Message-ID: <CAGZ6i=2cQywq82QrJg=t-KVMqSdjME-dkd-8aH3au_RTju2zTA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] usb: typec: tcpm: AMS and Collision Avoidance
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 2:11 PM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> Hi Kyle,
>
> Do you want to handle the FAST_ROLE_SWAP case as well ?
>
I forgot this part....
Thanks for catching this.
I will fix it.


> You would have to fix up in two places:
>
> #1
> -                       if (port->state == SNK_READY)
> -                               tcpm_set_state(port, FR_SWAP_SEND, 0);
> -                       else
> +                       if (port->state == SNK_READY) {
> +                               int ret;
> +
> +                               port->upcoming_state = FR_SWAP_SEND;
> +                               ret = tcpm_ams_start(port, FAST_ROLE_SWAP);
> +                               if (ret == -EAGAIN)
> +                                       port->upcoming_state = INVALID_STATE;
> +                       } else {
>                                 tcpm_log(port, "Discarding FRS_SIGNAL!
> Not in sink ready");
> +                       }
>
> #2
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4449,9 +4449,14 @@ static void tcpm_enable_frs_work(struct
> kthread_work *work)
>         if (port->state != SNK_READY || port->vdm_state !=
> VDM_STATE_DONE || port->send_discover)
>                 goto resched;
>
> -       tcpm_set_state(port, GET_SINK_CAP, 0);
> -       port->sink_cap_done = true;
> -
> +       port->upcoming_state = GET_SINK_CAP;
> +       ret = tcpm_ams_start(port, GET_SINK_CAPABILITIES);
> +       if (ret == -EAGAIN) {
> +               port->upcoming_state = INVALID_STATE;
> +       } else {
> +               port->sink_cap_done = true;
> +               goto unlock;
> +       }
>
> Thanks,
> Badhri
>
>
