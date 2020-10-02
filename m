Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCF281778
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbgJBQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:08:43 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F05C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:08:41 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id d18so536927uav.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xu/Uk9wb4/SRX/lNOg251KFRQf7KzG5P3wRuNCk78Q=;
        b=a3BhqywDHcthMTGATAxbl3NdAD83stTIBlQ2FfQ5ezFmBlhdJvMt0IZndBwDKvAmc8
         m+njQ9M9skhmu9Q/AVESIG77rI8bC3IK0wnCXevl9VVVWrYn3rpllhfvcm+gW9GJJj8J
         xyRSvc901uFfOxXZfBSXUGKak3C+AmMBhUi5k8Drd2CrZwMk7O+tPHNydC6bfHTcC3dw
         fRSzIi96ECelYHaGgttb+oHit6lsATIJzcNO/nYihWqoxu8BxtY4PnIhFP7dwqUCsOue
         DBH466z6r4OG/3+B3AHF8j/iKMdojiqmAcjVIlSIAK5myL3TxprvK7eP34QlWAiIWg7o
         HraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xu/Uk9wb4/SRX/lNOg251KFRQf7KzG5P3wRuNCk78Q=;
        b=S+kl0dllVh2yzyrerrdiFEFpIoqN9W+B8p82jNyJJiYacwXia7bizQHGKgtK+f/d2S
         Q1ESCmyut6xuBjtfJiKkASdoa1IienPSEUNi/VNcvkiQjEXcz/2ZnoKRDKPMqmir3ErY
         v8+g78NOV7X9ZoBn27wSF4OCqS11uemLU1KQlRqHw0hc3uJwcnY6iUEGNUOWDdJMl7NS
         kJckkjkK/h4v+QpgrJD3V8qDuJEqf4ccAA9aRRAgz0HMVYpicF8gutycKsD2UH/S7qYb
         7r3aB9Jg1DzDrUjriudV9Waaveo2KkLT49dKF1RiZXVErcB05TkV0bFkFRzeYOS1Io+N
         CbLg==
X-Gm-Message-State: AOAM533dFpT4ePJgAhOoah+c1PROZqvkgE688GXc+ByLsFgcvHAVCCtf
        ohmpSYTynFgKvyR1iJkim2Edya6vwphwEvZTl/jVVw==
X-Google-Smtp-Source: ABdhPJygv1guoMmOlqYRQxvkcv9hBfbPNVn1KMr3qe8rFpypjiJPn3b/GKYn1BpK1Fr1JuCtbnaxJj09Zqlzs4FZwWo=
X-Received: by 2002:ab0:768:: with SMTP id h95mr1573232uah.23.1601654916896;
 Fri, 02 Oct 2020 09:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-3-badhri@google.com>
 <20201002133952.GA3411859@kroah.com> <20201002134041.GA3412330@kroah.com>
In-Reply-To: <20201002134041.GA3412330@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 2 Oct 2020 09:08:00 -0700
Message-ID: <CAPTae5LBeY1qifPmGce+6Cu2hjVx=QZazk53Y=n6RPPRAuozLA@mail.gmail.com>
Subject: Re: [PATCH v9 02/15] usb: typec: tcpci: Add set_vbus tcpci callback
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Yes I tested it on usb-next before sending it out.

  630 |  tcpci->tcpc.enable_frs =3D tcpci_enable_frs;

In https://patchwork.kernel.org/project/linux-usb/list/?series=3D356837
i.e v9 version of this series,
Patch 7 i.e. https://patchwork.kernel.org/patch/11804847/ is where the
above line is added.

I restested in combinations [1]  [2] [3] [4]. All of them were clear
cherry-picks. I didnt any merge conflicts.

Maybe you are applying patches in a different order ?
If so can you post the git log for me to apply in the same order and test ?

Or Do you want me to rebase on top of usb-testing ?
I didnt see any merge conflicts though.

Thanks,
Badhri


[1] usb-testing all patches in series
https://patchwork.kernel.org/project/linux-usb/list/?series=3D356837
07684bb88ed4 (HEAD -> usb-testing) usb: typec: tcpci_maxim: Enable
auto discharge disconnect
1c97f5e32ba6 usb: typec: tcpci: Implement Auto discharge disconnect callbac=
ks
1b829a062e6e usb: typec: tcpm: Implement enabling Auto Discharge
disconnect support
7ba4edfd9155 usb: typec: tcpm: Parse frs type-c current from device tree
01d47f2e98ba usb: typec: tcpci_max77759: Fix vbus stuck on upon
diconnecting sink
9e8ed3d8809c usb: typec: tcpci: frs sourcing vbus callback
8804a3f75563 usb: typec: tcpm: frs sourcing vbus callback
69fe6c1c7648 usb: typec: tcpci_maxim: Add support for Sink FRS
0a22d446c026 usb: typec: tcpci: Implement callbacks for FRS
93c622006aa6 usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
14672081f2fd dt-bindings: connector: Add property to set initial
current cap for FRS
58372bd1d8e8 usb: typec: tcpci_maxim: Chip level TCPC driver
c16b09eaf60f dt-bindings: usb: Maxim type-c controller device tree
binding document
32d66c0449e1 usb: typec: tcpci: Add set_vbus tcpci callback
85e90e5054d6 usb: typec: tcpci: Add a getter method to retrieve
tcpm_port reference
97b65223c18f (origin/usb-testing) USB: core: remove polling for
/sys/kernel/debug/usb/devices
da0cb6310094 usb: typec: add support for STUSB160x Type-C controller family

[2] usb-testing: till patch4 in series
https://patchwork.kernel.org/project/linux-usb/list/?series=3D356837
58372bd1d8e8 (HEAD -> usb-testing) usb: typec: tcpci_maxim: Chip level
TCPC driver
c16b09eaf60f dt-bindings: usb: Maxim type-c controller device tree
binding document
32d66c0449e1 usb: typec: tcpci: Add set_vbus tcpci callback
85e90e5054d6 usb: typec: tcpci: Add a getter method to retrieve
tcpm_port reference
97b65223c18f (origin/usb-testing) USB: core: remove polling for
/sys/kernel/debug/usb/devices
da0cb6310094 usb: typec: add support for STUSB160x Type-C controller family

[3] usb-next all patches in series
https://patchwork.kernel.org/project/linux-usb/list/?series=3D356837
62b5171538da (HEAD -> usb-next) usb: typec: tcpci_maxim: Enable auto
discharge disconnect
ea8987805ba6 usb: typec: tcpci: Implement Auto discharge disconnect callbac=
ks
af9a12b19352 usb: typec: tcpm: Implement enabling Auto Discharge
disconnect support
33aec604a529 usb: typec: tcpm: Parse frs type-c current from device tree
31df45f3df20 usb: typec: tcpci_max77759: Fix vbus stuck on upon
diconnecting sink
0945795f170d usb: typec: tcpci: frs sourcing vbus callback
c49080982064 usb: typec: tcpm: frs sourcing vbus callback
67a3ff254cc1 usb: typec: tcpci_maxim: Add support for Sink FRS
299582bbf78f usb: typec: tcpci: Implement callbacks for FRS
bb4eb3fb65df usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
5aad64e80460 dt-bindings: connector: Add property to set initial
current cap for FRS
6c59a16ddee2 usb: typec: tcpci_maxim: Chip level TCPC driver
172274d3e327 dt-bindings: usb: Maxim type-c controller device tree
binding document
bdba308a7164 usb: typec: tcpci: Add set_vbus tcpci callback
66b7b0d83399 usb: typec: tcpci: Add a getter method to retrieve
tcpm_port reference
59ee364bafb2 (origin/usb-next) Merge tag 'thunderbolt-for-v5.10-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt
into usb-next
bf1c67449833 USB: cdc-acm: clean up no-union-descriptor handling

[4] usb-next till patch4 in series
https://patchwork.kernel.org/project/linux-usb/list/?series=3D356837
6c59a16ddee2 (HEAD -> usb-next) usb: typec: tcpci_maxim: Chip level TCPC dr=
iver
172274d3e327 dt-bindings: usb: Maxim type-c controller device tree
binding document
bdba308a7164 usb: typec: tcpci: Add set_vbus tcpci callback
66b7b0d83399 usb: typec: tcpci: Add a getter method to retrieve
tcpm_port reference
59ee364bafb2 (origin/usb-next) Merge tag 'thunderbolt-for-v5.10-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt
into usb-next
bf1c67449833 USB: cdc-acm: clean up no-union-descriptor handling


On Fri, Oct 2, 2020 at 6:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 02, 2020 at 03:39:52PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 28, 2020 at 07:39:51PM -0700, Badhri Jagan Sridharan wrote:
> > > set_vbus callback allows TCPC which are TCPCI based, however,
> > > does not support turning on sink and source mode through
> > > Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > This patch breaks the build, are you sure you tested it?
>
> Sorry, not this patch, patch 4:
>
> drivers/usb/typec/tcpm/tcpci.c: In function =E2=80=98tcpci_register_port=
=E2=80=99:
> drivers/usb/typec/tcpm/tcpci.c:630:13: error: =E2=80=98struct tcpc_dev=E2=
=80=99 has no member named =E2=80=98enable_frs=E2=80=99
>   630 |  tcpci->tcpc.enable_frs =3D tcpci_enable_frs;
>       |             ^
>
>
> thanks,
>
> greg k-h
