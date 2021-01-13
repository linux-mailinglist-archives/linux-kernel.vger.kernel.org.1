Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468022F579D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbhANCC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbhAMXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:22:24 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2845C0617B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:21:09 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id b23so2095220vsp.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNpul3TmNz217TlWaHrp655cA39WwM3OTc2qb1ao4wM=;
        b=EeWkeggv3kpf3wVa4+9KYipXjBKs3vj3zoCRJ6i1ClC8nN99P+Amx2t+UOy+5OVEZu
         xdCMocOGmk7YLVYAjUx1f1N2i6M82Piiuw2PybHXgHjg5WG3jpiYL2+Le0loq6zMwcRJ
         l5Pr7Vs3rIJ8zssw08oofEJspt8rTUjIIENuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNpul3TmNz217TlWaHrp655cA39WwM3OTc2qb1ao4wM=;
        b=SPKYOBlhU2JJYZcbAYuMK+0ySd7Qe2+t+Q2RqksH3T1A84nrYfnnRsWQF3CfAa4XwS
         sw4bd6m8syX2d9TnGj+z+y35OL1IDqfzKsR+6P51rDfu0DwD9cztLze+s8Ww6Qr29uPi
         8EeATFOVUxYxT34OEBwi4j0TT/jHqqN/9k3D0d2ibheWEQzQMYYlQ1v5tOkYikRIHpwu
         EYM6Shxp4s4Xls/Tg2hzngC4nhQdH7RlhbnNWW8IqWMYw8CqrLgNbMpb2tL9c0+BPmC4
         FzCRXv00o26P7A4bUhAhqXK/1zSH7WINWML2KbXv8Z+D04fUKOhqJYg/e0t0/LMocIe9
         /sSQ==
X-Gm-Message-State: AOAM530XlaAzGRxUg/foJPteC3ahESagH8LXuBqyt9Zv8uAPi7ZHX3vD
        fBX+5Ba9TBF9xF1HD3BlonPjp+q00f6tHg==
X-Google-Smtp-Source: ABdhPJzwABDzPqmLCrlPr19pIq1XY7t2GFb/wAcYb9jq666Spuaf1Wbe5Q70lMQ0rl6IuOjrCsaWdQ==
X-Received: by 2002:a05:6102:34f:: with SMTP id e15mr4397174vsa.21.1610580068589;
        Wed, 13 Jan 2021 15:21:08 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id i30sm439212uai.9.2021.01.13.15.21.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 15:21:07 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id w187so1118021vsw.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:21:07 -0800 (PST)
X-Received: by 2002:a67:ed09:: with SMTP id l9mr4227683vsp.4.1610580067037;
 Wed, 13 Jan 2021 15:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
In-Reply-To: <20210113112052.17063-1-nsaenzjulienne@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jan 2021 15:20:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
Message-ID: <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
Subject: Re: [PATCH 0/3] usb: dwc2: Fixes and improvements
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Minas Harutyunyan <hminas@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 13, 2021 at 3:21 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> I'm picking up this series by Guenter Roeck as he stated he has no time
> for it ATM. It was found to solve some unaligned DMA access issues on
> Raspberry Pi 3. You can find the original discussion here:
> https://lore.kernel.org/linux-usb/20200226210414.28133-1-linux@roeck-us.net/
>
> I removed the fist patch from the original series as it turned out to be
> contententious and needs more in-depth testing. Following is the edited
> origin series description. Note that extra testing was performed on
> RPi3:
>
> "This series addresses the following problems:
>
> - Fix receive transfers with 0 byte transfer length
> - Abort transactions after unknown receive errors
>   if the receive buffer is full
> - Reduce "trimming xfer length" logging noise
>
> The problems fixed with this series were observed when connecting
> a DM9600 Ethernet adapter to Veyron Chromebooks such as the ASUS
> Chromebook C201PA. The series was tested extensively with this and
> other adapters.
>
> The observed problems are also reported when tethering various
> phones, so test coverage with such phones would be very appreciated."
>
> ---
>
> Guenter Roeck (3):
>   usb: dwc2: Do not update data length if it is 0 on inbound transfers
>   usb: dwc2: Abort transaction after errors with unknown reason
>   usb: dwc2: Make "trimming xfer length" a debug message
>
>  drivers/usb/dwc2/hcd.c      | 15 ++++++++-------
>  drivers/usb/dwc2/hcd_intr.c | 14 +++++++++++++-
>  2 files changed, 21 insertions(+), 8 deletions(-)

It's been long enough ago that I've forgotten where this was left off,
but IIRC the 3 patches that you have here are all fine to land (and
have my Reviewed-by tag).  However, I think Guenter was still tracking
down additional problems.  Guenter: does that match your recollection?

It looks like there are still bugs open for this on our public bug tracker:

https://issuetracker.google.com/issues/172208170
https://issuetracker.google.com/issues/172216241

...but, as Guenter said, I don't think there's anyone actively working on them.

I'm not really doing too much with dwc2 these days either and don't
currently have good HW setup for testing, so for the most part I'll
leave it to you.  I wanted to at least summarize what I remembered,
though!  :-)

-Doug
