Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A452E0593
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 06:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgLVFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 00:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 00:10:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C34C0613D3;
        Mon, 21 Dec 2020 21:10:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b26so19554676lff.9;
        Mon, 21 Dec 2020 21:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozs7BMuAEYjcVfJbeL4pPaJJwtnzLYWPn6aofHqsU38=;
        b=r3uIIzPs8/MFaQ+pgmCI25CayM4gPjoh0ZOYkz+EJI2b1vhkIo/LTk/FSFsGV3+xAQ
         JNrDu19pN2ZqyINCWcj0aGESWizLDzG6nafx1gzwkjEvKKOU4rqe1hSEXIti7PscHgb3
         WnD1lsr1Sl+UqYMogd3g14UAH51xuln5In5qkMNPmMDTl6uTxfEVk4QicXMJXPJIcEYz
         aLO1DuYpX+YCeSrJ4p6TyNXCd8eSLTpBFBbG2iuxncUqb6Gj3s744yKXJAlUowqEzmCp
         CfkMKlhUycMsgzBU2lIIh8sn2RVjexJFMmKvsb/exxOYmmX98TfZtr5aRfvBS62l5dtP
         NwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozs7BMuAEYjcVfJbeL4pPaJJwtnzLYWPn6aofHqsU38=;
        b=RXhxo36Dd2GNeQTArH43MXVngHPIOaTK04Y6jwQLx2wkBuOv+EZ9KXaY9Qktd8K3uA
         S++NIe4suNFfueGZ+csSQ2ijsY/7R8/adxydDBsQjTt1+s54KYIvoSLGhP07soRQ832T
         A7xPTRwuWjvcTCVPTUZo86LoNIDRKiyRpEyMxCaiqvTl63wuqZl3d9HfZ3klrxw/yhb4
         ++LL91JRXyM6pkG4yFOa9icqu7T8farHqQxpaz5Me2gpFnLokyJ8w0LFAuMNbNcuqXnQ
         sts63KLuAnsKKsPczW2cNZcN4Am3ZAVYqwRrbXyGYl2we/P5GErZTQA4iuLp9mHlw7Le
         DP9w==
X-Gm-Message-State: AOAM533NJ0DibDNVCIR+/7cpTzoXdQYAGbaM6kBvbwAt2WQzFt/v0+N1
        exZfU+aqQ4/q+l0WsIc6/wEBGeozK/PGG2w2tpqeYo5E8A==
X-Google-Smtp-Source: ABdhPJxOqNCYHUdgeb46vxHhDLYWWaqXYiiz6CgzwDCNJ2Z/uoXDJcc736xMvDm6dcNZUYpzoS/tvGwLUmbtPQfmaDk=
X-Received: by 2002:a05:6512:491:: with SMTP id v17mr7790315lfq.148.1608613807175;
 Mon, 21 Dec 2020 21:10:07 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net> <9d551bb4-0bd8-937c-f1c1-f6a86a24898f@amd.com>
In-Reply-To: <9d551bb4-0bd8-937c-f1c1-f6a86a24898f@amd.com>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 22 Dec 2020 06:09:41 +0100
Message-ID: <CAEJqkgiE8VX9AHRokevVWghPyNcKCpSPH83TpomkHZZvaQAD0Q@mail.gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Wei Huang <wei.huang2@amd.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 22. Dez. 2020 um 05:33 Uhr schrieb Wei Huang <wei.huang2@amd.com>:
>
>
>
> On 12/21/20 9:58 PM, Guenter Roeck wrote:
> > Hi,
> >
> > On 12/21/20 5:45 PM, Gabriel C wrote:
> >> Hello Guenter,
> >>
> >> while trying to add ZEN3 support for zenpower out of tree modules, I find out
> >> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
> >>
> >> commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e added:
> >>
> >> case 0x0 ... 0x1:       /* Zen3 */
> >>
> >> however, this is wrong, we look for a model which is 0x21 for ZEN3,
> >> these seem to
> >> be steppings?
>
> These are model numbers for server CPUs. I believe 0x21 is for desktop
> CPUs. In other words, current upstream code doesn't support your CPUs.
> You are welcomed to add support for 0x21, but it is wrong to remove
> support for 0x00/0x01.

I figured that myself after seeing what was committed to amd_energy driver.
Would be better you as the author of the patch to have a better commit
message to start with.


commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e
Author: Wei Huang <wei.huang2@amd.com>
Date:   Mon Sep 14 15:07:15 2020 -0500

   hwmon: (k10temp) Add support for Zen3 CPUs
....

Which you didn't. That should read:

"Added support for NOT yet released SP3 ZEN3 CPU"

Right?

>
> >>
> >> Also, PLANE0/1 are wrong too, Icore has zero readouts even when fixing
> >> the model.
> >>
> >> Looking at these ( there is something missing for 0x71 ZEN2 Ryzens
> >> also ) that should be:
> >>
> >> PLANE0  (ZEN_SVI_BASE + 0x10)
> >> PLANE1  (ZEN_SVI_BASE + 0xc)
>
> Same problem here with model 0x71. 0x31 is for server CPUs.

Yes, is why I split both in my 'guess what the eff is this about' patch.

0x31 is TR 3000/ Sp3 ZEN2 , while 0x71 is ZEN2 Desktop.
>
> >>
> >> Which is the same as for ZEN2 >= 0x71. Since this is not really
> >> documented and I have some
> >> confirmations of these numbers from *somewhere* :-) I created a demo patch only.
> >>
> >> I would like AMD people to really have a look at the driver and
> >> confirm the changes, since
> >> getting information from *somewhere*,  dosen't mean they are 100%
> >> correct. However, the driver
> >> is working with these changes.
> >>
> >> In any way the model needs changing to 0x21 even if we let the other
> >> readings broken.
> >>
> >> There is my demo patch:
> >>
> >> https://crazy.dev.frugalware.org/fix-ZEN2-ZEN3-test1.patch
>
> For family 19h, the patch should look like. But this might not matter
> anymore as suggested by Guenter below.
>
>   /* F19h thermal registers through SMN */
> #define F19H_M01_SVI_TEL_PLANE0                 (ZEN_SVI_BASE + 0x14)
> #define F19H_M01_SVI_TEL_PLANE1                 (ZEN_SVI_BASE + 0x10)
> +/* Zen3 Ryzen */
> +#define F19H_M21H_SVI_TEL_PLANE0               (ZEN_SVI_BASE + 0x10)
> +#define F19H_M21H_SVI_TEL_PLANE1               (ZEN_SVI_BASE + 0xc)
>
> Then add the following change:
>
>                 switch (boot_cpu_data.x86_model) {
>                 case 0x0 ... 0x1:       /* Zen3 */
>                         data->show_current = true;
>                         data->svi_addr[0] = F19H_M01_SVI_TEL_PLANE0;
>                         data->svi_addr[1] = F19H_M01_SVI_TEL_PLANE1;
>                         data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
>                         data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
>                         k10temp_get_ccd_support(pdev, data, 8);
> +               case 0x21:      /* Zen3 */
> +                       data->show_current = true;
> +                       data->svi_addr[0] = F19H_M21H_SVI_TEL_PLANE0;
> +                       data->svi_addr[1] = F19H_M21H_SVI_TEL_PLANE1;
> +                       data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
> +                       data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
> +                       k10temp_get_ccd_support(pdev, data, 8);
>
> >>

You are a really funny guy.
After _all_ these are YOUR Company CPUs, and want me to fix these without docs?
Sure I can, but the confusion started with your wrong commit message.

Besides, is that how AMD operates now?
Let the customer pay thousands of euros for HW and then tell
him to fix or add drivers support himself? Very interesting.

And yes it matters even after removing these.

case 0x0 ... 0x1:       /* Zen3 SP3 ( NOT YET RELEASED ) */
case 0x21:      /* Zen3 Ryzen Desktop  */
   ....

Right?

> >> Also, there is some discuss and testing for both drivers:
> >>
> >> https://github.com/ocerman/zenpower/issues/39
> >>
> >
> > Thanks for the information. However, since I do not have time to actively maintain
> > the driver, since each chip variant seems to use different addresses and scales,
> > and since the information about voltages and currents is unpublished by AMD,
> > I'll remove support for voltage/current readings from the upstream driver.
> > I plan to send the patch doing that to Linus shortly after the commit window
> > closes (or even before that).
>
> I believe Guenter is talking about
> https://www.spinics.net/lists/linux-hwmon/msg10252.html.

I know and don't get me started about your replay to that because
it looks like you believe the Linux community or your Linux customers
are somewhat stupid.

Best Reagrds,

Gabriel C.
