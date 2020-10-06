Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968372844FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJFEhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJFEhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:37:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D40C0613A7;
        Mon,  5 Oct 2020 21:37:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a5so4051951ljj.11;
        Mon, 05 Oct 2020 21:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1Ui7AeYdmvfqVpFDAqv3wK+Nw0lnT10o1RG3kNWsCE=;
        b=sil+lNL3s6dQgxzwTPIOjQmmrEI5tLh7HEDg0zr22N7ZqjI2ErYDGt6Wj06ePCJFA3
         4Lu3n3YfacZ9+qKgHhKBWhXAUdDWsxZEhXXAi998D/4B99ko/Imzkqk9GNdWfbtU6eO1
         4Al4U8rcG47YdwGeLsddpjAZWbzg1TMHh96i5G6LMnjycwo6zsq1JvFVSupPKDZqewBE
         QrGPHwRIQuMPAyGU5mN7iPerCSjoeoVeFENXHWlxhRAy7GZT8nNdomao1IRJ7F7Jstki
         eK9/URxUk9R3r77YinlbK/gZRDH3nkQWSt+aUGolSKj4i9nmmKFmDJV3uPpD8Z2ECp04
         B2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1Ui7AeYdmvfqVpFDAqv3wK+Nw0lnT10o1RG3kNWsCE=;
        b=OOeU2memkbCTkKUkPspVrLH66+/RryiaqE7eSHA5DIGlovw8TAo1dnR0P2j8MBq66Q
         P65CPdQWDlA+rn6aWYmC03hLaBr9UdcZXzfHQ/XKOFJRwAh9SdsZ2/pDVmpfeaMaaxkU
         QU2td8N5InDpwirYCxceMWsnSYCfKE+DJyWnzIjmzpOselwUqD7m72kR0u7Ba/day6v7
         DHxelME4EZMO93TDfE9UzZWDtiSMFsjZim6D/HfOjCqr3u4hO1Mm5bNkcSnCNwrbYKp0
         5ZLhptad0XDkqS2IQbf5LwW1BvIpuIPK+1Qh5ByoLYOPe6xV7vbF7t7JPXHS+KVagcA5
         BdjQ==
X-Gm-Message-State: AOAM530xeATqCTdmyPGe1v1y8TEwhtN2Ez1nOz20OlJV9+sFccjr5tyH
        OL7quYRN7E+c1F8sV2M/TGgXAlaDcHPJCJQdRFnXQ6gvwsoGYA==
X-Google-Smtp-Source: ABdhPJwYsHG+/E/R7zGiINSRImu9KKjzJIUV/oAEMgmhcZpLucwoIGZTKURf6tAr5dNeTKa9pyvRPVUzVTBgIaWPDZc=
X-Received: by 2002:a2e:9709:: with SMTP id r9mr907813lji.119.1601959038233;
 Mon, 05 Oct 2020 21:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
In-Reply-To: <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 6 Oct 2020 12:37:06 +0800
Message-ID: <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 10/5/20 4:08 AM, Greg KH wrote:
> [ ... ]
> >>> What ever happened with this patch, is there still disagreement?
> >>>
> >>
> >> Yes, there is. I wouldn't have added the conditional without reason,
> >> and I am concerned that removing it entirely will open another problem=
.
> >> Feel free to apply, though - I can't prove that my concern is valid,
> >> and after all we'll get reports from the field later if it is.
> >
> > Ok, can I get an ack so I know who to come back to in the future if
> > there are issues?  :)
> >
>
> Not from me, for the reasons I stated. I would be ok with something like:
>
> -       if (tcpm_port_is_disconnected(port))
> +       if (tcpm_port_is_disconnected(port) ||
> +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc2)))
>
> to narrow down the condition.

I have tried the above comment and It doesn't work.
How about to change the judgement like as below

-       if (tcpm_port_is_disconnected(port))
+       if (tcpm_port_is_disconnected(port) || !port->vbus_present)

The hard_reset_count not reset issue is following by the below order
1. VBUS off ( at the same time, cc is still detected as attached)
port->attached become false and cc is not open
2. After that, cc detached.
due to port->attached is false, tcpm_detach() directly return.

And that's why hard_reset_count is not reset to 0.
>
> Guenter
