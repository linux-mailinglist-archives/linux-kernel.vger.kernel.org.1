Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654372A1BB2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 03:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKACTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 22:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKACTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 22:19:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE2C0617A6;
        Sat, 31 Oct 2020 19:19:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w13so331595eju.13;
        Sat, 31 Oct 2020 19:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/oc1y+3opRtV7SItzc5X2Ox37U2lsq5l+b04ii/Mlk=;
        b=Q4ctBg1nr2bdpgA8HTArPxqAsmZHiWocWxRo7QpWZEvOnePqj/ePf2f5HaF4kwrCJy
         wSyCCiYcZ/HA61Y1FXBTYvJ48xsFULV0FhHrhXIwXSqjpNbOVlyGGo6bcMYHkpgxltcD
         2UEyq+2l5lm7lKEhCrbJVqn+1L/SjwLBJBGtnmUeDkM5WLzlpc2AYLJTra1tKGYq1nDU
         uBAb4LcGCPhBngYl22TiN44vbG25E3S/n9UZXmn5Ufv+1pkaciNQfWpLpMeALMXYvm+7
         cnLEBt4Cr9VCDVKqgH2Izj7GY5/Hd0R0YfwO6S3EWSelJ4jZob+wDbFo7kf+M/h1fSwX
         9hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/oc1y+3opRtV7SItzc5X2Ox37U2lsq5l+b04ii/Mlk=;
        b=VGq8Nwcje3FNaF7a8hRs1THQZwb5d25y10GwdM4kNO2WkI13FMWCu4DxCjS7le4kNP
         PdBQAup8Ec6tvK8JMTRPkhl+zfvVLrLiPgAjxFa76kSL7tN0I5/Pd4bLtUHbdWnOZALS
         YSxw1FPfcoeAp/Q0kP1IKTsukWKJn70l4fzt3SkDT/TIj/LQLtHzoDnN1f8dZYCbxL5b
         s+uhr0yaTEjhvMzn5r//B/ahd/nf9PDU6UcXBymbkuIwn6ADTvfIAsfiVi6VNA8rexj+
         24YtREwLvv/DLKhRlSaFJJdS53K0ZML5+YaeAwy4fpnGrRddecja9+dCfJvb7vTqruIs
         sh5g==
X-Gm-Message-State: AOAM530NE4glntERyeJvIFGkqAC4teVYpF5V+5WnpMQD7fIB3XnfmKWU
        9I/fMl0wLrHpAU+iIqCk+rYpha3raWPrOvGN9jvV2nmBc/c=
X-Google-Smtp-Source: ABdhPJwzUi42pCWsdf/OH7pn3OyNuLkui6Uuvb7WnU+otnQV/OpOV0ZMZz0CzYshCeD5pkp30sT+7InpJWztgkaFGao=
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr8779403eju.364.1604197158081;
 Sat, 31 Oct 2020 19:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamsqOfgS6-7mt4SGd9rou-QRxzRDfQ_wD6dB3veueXtqgw@mail.gmail.com>
 <20201101014040.GA1428475@rowland.harvard.edu>
In-Reply-To: <20201101014040.GA1428475@rowland.harvard.edu>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sat, 31 Oct 2020 22:19:06 -0400
Message-ID: <CAEAjamu1iU0JBPjdj0R4OAxoftXp8cv3y7TxKm4x9Amrq+k64g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_set_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It cannot be reproducible, unfortunately.

Thanks,
Kyungtae Kim

On Sat, Oct 31, 2020 at 9:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Oct 28, 2020 at 04:51:09PM -0400, Kyungtae Kim wrote:
> > We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
> > of syzkaller).
> >
> > The bug happened when accessing a freed instance of struct fsg_dev
> > (i.e., fsg->bulk_in) in do_set_interface() (line 2245).
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in do_set_interface.part.7+0xa6b/0xd90
> > drivers/usb/gadget/function/f_mass_storage.c:2245
> > Read of size 8 at addr ffff88806bc940f8 by task file-storage/2063
> >
> > CPU: 3 PID: 2063 Comm: file-storage Not tainted 5.8.13 #4
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xa7/0xea lib/dump_stack.c:118
> >  print_address_description.constprop.8+0x3f/0x60 mm/kasan/report.c:383
> >  kasan_report.cold.11+0x20/0x37 mm/kasan/report.c:513
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:146
> >  do_set_interface.part.7+0xa6b/0xd90
> > drivers/usb/gadget/function/f_mass_storage.c:2245
> >  do_set_interface drivers/usb/gadget/function/f_mass_storage.c:2202 [inline]
> >  handle_exception drivers/usb/gadget/function/f_mass_storage.c:2426 [inline]
> >  fsg_main_thread+0x12c7/0x59f1 drivers/usb/gadget/function/f_mass_storage.c:2466
> >  kthread+0x374/0x480 kernel/kthread.c:291
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
>
> Is this reproducible?  Can you test patches?
>
> Alan Stern
