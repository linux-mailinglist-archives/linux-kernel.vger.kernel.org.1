Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1B2ABB2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgKINZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgKINZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:25:06 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EEC0613CF;
        Mon,  9 Nov 2020 05:25:06 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y17so8250140ilg.4;
        Mon, 09 Nov 2020 05:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTFIkPLyuQgyDTeSB90HW+RN1q4pGMJR237yURKzGvY=;
        b=vGwYDQLwU0TnedQNkBcGBO2I6U4BayCbNJ93T3kRs9AF/kq8/G6FN7/JJdl1BWdeC4
         SJz6wRnh149A3g+Ad//i7Vnd0giVrSKayDzl4UWx0tgLnsqNm5XjVovnxWS6UTwNoozP
         ikyg83nvKrzuktXtovLRxqIh6u8Xb0ctA8bfYP/gRHO2xyHj3b22wk+jvodrvcnBD0Nd
         bnh25poMn/9zQSV1pFXa0jerwilrlr/8lqL+IYXVltU38Vvo2Frh+hSnvyW3pQ0678yS
         jrFQZOyBhBA5cW/p5t/n7lbeKcxw2D6yvr8lZnDID6UXkzql26Tt0ni4EdZGzO9c2dfN
         4E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTFIkPLyuQgyDTeSB90HW+RN1q4pGMJR237yURKzGvY=;
        b=rdYWU8vXMQrlKirSq3uuEKclYspt6qeUBtE9fog1OpvzfWrImiX6PDpOR6JBLC7Cj5
         d5q2VC1e1XzG0r/nlDECqFDbZgA0/c1URd2L57c0JKgbo/OsbapMK5Wpv3eEZnH50bO3
         I9d5KVDJpOMwjAjKfbDOtJjxc+hE/sXNgC2JEn4r3nCmtE0iAWPxQwNvH2XTDWsGIcze
         l6DnsBDWlTGPv+GEnaJ9oovea1wFc469dB7NlLX3vB04eS1740rBI/Fa8LxX9XjH0dDm
         lRHOvS3xiQnCVmAgUKZ4zt2dxeMtm8SUi/g8pQ40x6XaHMly1yadyx1WgiKlof5wTC8g
         tJEQ==
X-Gm-Message-State: AOAM532Qtb4lrdUUmHAJKwgt7JurCx971bODc07eA75JvDFbqHaHf+1L
        wFmDH9ULqnch1F2WrW1KwROUZZ6OPAzBW6dtIg13H6+uH/Q=
X-Google-Smtp-Source: ABdhPJwOnorxLlzA7DDy3GiiWRQV3tnl/YNgbtaLZdIUzwk/Mj8wRQhXxbt/BKRpdAX+Za75d1giY0qm4Gz/wtNketo=
X-Received: by 2002:a92:ac0e:: with SMTP id r14mr10641398ilh.197.1604928306006;
 Mon, 09 Nov 2020 05:25:06 -0800 (PST)
MIME-Version: 1.0
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com> <20201104202952.783724-3-npcomplete13@gmail.com>
 <c0d62a2e-59e2-c811-f5bd-e7299f540ca3@gmail.com> <20201104205836.GA783888@ubuntu>
In-Reply-To: <20201104205836.GA783888@ubuntu>
From:   Vivek Unune <npcomplete13@gmail.com>
Date:   Mon, 9 Nov 2020 08:24:55 -0500
Message-ID: <CAChtp76diZQfoQXmaFw1ugfYda_rrwAacE3G1mx5j-MmHGtaEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 3:58 PM Vivek Unune <npcomplete13@gmail.com> wrote:
>
> On Wed, Nov 04, 2020 at 12:37:45PM -0800, Florian Fainelli wrote:
> >
> >
> > On 11/4/2020 12:29 PM, Vivek Unune wrote:
> > > Now that we have a pin controller, use that instead of manuplating the
> > > mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux
> >
> > I am a bit confused here as I thought the mux was intended to
> > dynamically switch the pins in order to support both internal and
> > external MDIO devices but given the register ranges that were used,
> > these were actually the pinmux configuration for the MDC and MDIO pins.
> >
> > This does not break USB and/or PCIe PHY communication does it?
>
> Hi Florian,
>
> The external and internal MDIO logic is controlled by mdio-bus-mux.
> Which controls the BIT(9) of the mdio register. This stays.
>
> The removal of mdio-mii-mux and it's replacement with usage of
> pinctrl doesn't affect USB3 or PCIe. See below USB3 detection.
>
> [ 4295.450118] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [ 4295.690183] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
> [ 4295.721888] usb-storage 4-1:1.0: USB Mass Storage device detected
> [ 4295.728349] scsi host0: usb-storage 4-1:1.0
> [ 4296.811047] scsi 0:0:0:0: Direct-Access     SanDisk  Ultra Fit        1.00 PQ: 0 ANSI: 6
> [ 4296.821159] sd 0:0:0:0: [sda] 60063744 512-byte logical blocks: (30.8 GB/28.6 GiB)
> [ 4296.829667] sd 0:0:0:0: [sda] Write Protect is off
> [ 4296.834502] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
> [ 4296.834864] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [ 4296.852604] GPT:Primary header thinks Alt. header is not at the end of the disk.
> [ 4296.860079] GPT:1540387 != 60063743
> [ 4296.863586] GPT:Alternate GPT header not at the end of the disk.
> [ 4296.869600] GPT:1540387 != 60063743
> [ 4296.873090] GPT: Use GNU Parted to correct GPT errors.
> [ 4296.878266]  sda: sda1 sda2
> [ 4296.884416] sd 0:0:0:0: [sda] Attached SCSI removable disk
>

Hi Florian,

Does this clarify your confusion?

Thanks,

Vivek
