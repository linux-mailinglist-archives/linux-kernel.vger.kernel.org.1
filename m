Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9B2832A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJEI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJEI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:57:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DFC0613CE;
        Mon,  5 Oct 2020 01:57:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so5158289pjr.3;
        Mon, 05 Oct 2020 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Wkb/gsUUJg0uSTXNPX2FwdTcSv/wN7B8zB0kaks3Do=;
        b=G0dy0w5nw754YXEobdB1ZHKxTtIJK7mg4wWXpYDtbAIwPzYRdW103fDTC0PhTwS1f6
         5NXpTXkuetNT0OAHtxPV1+0zAHjnXK73/lf6BqdAYawa8ZNia/mMPAHm1BrNyR/6WBza
         wwvTH/q5wNkgCb5ph95IRXjBidP68uPbfO5xTtEf9L89/p7yNQdD23ZKIKgQT62f/R0E
         jnQqglnFsYRGhLuENJpGQKsSHdNrb2/bEwWsTCaeNZ+eYpqVLqlS5QO4U3uz07s3BS6Z
         utqFCwlxJU6rgUchPea8LMIFNzugoi5bdxxZivAJ/sZ8N3+iC2SNhFtZFDDkdFFsaS0x
         gK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Wkb/gsUUJg0uSTXNPX2FwdTcSv/wN7B8zB0kaks3Do=;
        b=bgBl2k9/HCjsYfcOwKmY5hCL0wKRXUgqrQx/iZboX3zK7hIHp6OMRS62e7iOIwsMtR
         UScqKLIvVw0ONl77qBWt3ETT4SMvPqwvYrddo+sqk4/ES247UKtbVHgXwQGMiyxZ3gh6
         /ojeVAt1gajmmXm0niX6BfaxAlMSuck3LZv/7XIp0IKvBCHsdCOSn5H0kHlgrl9YLD4R
         qRm2pDe4A0uCEU7+KEcuf0+4crwYUipGJOR6hH86Er+MBfSTECrwYs+m4GgaD1OCOIwf
         ovVfxbLXiVUsamoUUpIscRFvbpwktqVc5gmXbjwRhgzWuPWML6h+r45BczGE3vYX4WKS
         YqLg==
X-Gm-Message-State: AOAM5337MswwH1N9406lWcIm79w/hdJk2zKYAZ721rHVrJQC5i1ey5aG
        SWz3eP2FUJdGzvqOLINWXAWLyA9tfA671wWQ6u8=
X-Google-Smtp-Source: ABdhPJw69TKbzIGpFJRgreZdsHHaXx1kZnupOVJ1oZ8T/0/jXsqGMe9yySkcJFVgQetjT1bGP4fFMG/LGV4n74I3KNw=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr16404962pjb.129.1601888245998;
 Mon, 05 Oct 2020 01:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200917214957.GD29136@mtg-dev.jf.intel.com> <20201004211305.11628-1-eliadevito@gmail.com>
In-Reply-To: <20201004211305.11628-1-eliadevito@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Oct 2020 11:57:07 +0300
Message-ID: <CAHp75VfbK226a-SsNj=Bnpfc3wWyT9K_D4XzAMOu9of1_g+8-A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: hp-wmi: add support for thermal policy
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 12:14 AM Elia Devito <eliadevito@gmail.com> wrote:
>
> HP Spectre notebooks (and probably other model as well)
> support up to 4 thermal policy:
>  - HP Recommended
>  - Performance
>  - Cool
>  - Quiet
>
> at least on HP Spectre x360 Convertible 15-df0xxx the firmware sets the
> thermal policy to default but hardcode the odvp0 variable to 1, this causes
> thermald to choose the wrong DPTF profile witch result in low performance
> when notebook is on AC, calling thermal policy write command allow firmware
> to correctly set the odvp0 variable.
>
> Signed-off-by: Elia Devito <eliadevito@gmail.com>
> ---
>  drivers/platform/x86/hp-wmi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 1762f335bac9..6e448a79caee 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -81,6 +81,7 @@ enum hp_wmi_commandtype {
>         HPWMI_FEATURE2_QUERY            = 0x0d,
>         HPWMI_WIRELESS2_QUERY           = 0x1b,
>         HPWMI_POSTCODEERROR_QUERY       = 0x2a,

> +       HPWMI_THERMAL_POLICY_QUERY      = 0x4c

Usually we leave a comma that next change won't add any unnecessary churn.
I don't think this comment requires a v2 right now (may be satisfied
when applied), but if any other comments come and need to be
addressed, then this should be included as well.

>  };
>
>  enum hp_wmi_command {
> @@ -861,6 +862,26 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
>         return err;
>  }
>
> +static int thermal_policy_setup(struct platform_device *device)
> +{
> +       int err, tp;
> +
> +       tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
> +       if (tp < 0)
> +               return tp;
> +
> +       /*
> +        * call thermal policy write command to ensure that the firmware correctly
> +        * sets the OEM variables for the DPTF
> +        */
> +       err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
> +                                                          sizeof(tp), 0);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
>  static int __init hp_wmi_bios_setup(struct platform_device *device)
>  {
>         /* clear detected rfkill devices */
> @@ -872,6 +893,8 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>         if (hp_wmi_rfkill_setup(device))
>                 hp_wmi_rfkill2_setup(device);
>
> +       thermal_policy_setup(device);
> +
>         return 0;
>  }
>
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
