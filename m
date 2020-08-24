Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767424F294
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 08:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgHXGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXGgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 02:36:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:36:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a13so3865388vso.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oE+ltfruvc9Qubq44a39foWSD+M3lecV1ywVYs1Y2qI=;
        b=SenChbyYVpumtOiQc0/mz1kVAnq7/GMf3G8hvhzgB1YnrQn8GrNcGA/EoWz+UA/NgK
         QCTEX7PIk9kEQf1GA61PMFKqe+5eFNoovLPAE+pXvMxokwXllMWQ5FZ50TPMExU2f5DL
         aO28hGvNDijqouUJDrA80fyegKTFnI8mxMmox775565n2VLEjEKQRo81IB7Z+ZsHFmaM
         NzKx20wxWyl+Q4on4SW+E9g9lxc6ONxq2jL/zmVfTZiU/CkWzGNb0fpL6LxaybLBZplp
         AJ5vdkmfgyRRW2MHjCG9IrBoysdS3sX6PYbZvuVpuLpcY+pdzthvRuzujzKGv0oKOv72
         X4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oE+ltfruvc9Qubq44a39foWSD+M3lecV1ywVYs1Y2qI=;
        b=JHoPJU4X/MQgdcypgw0hxc6d0JiUHespG+GxCiH2IP+b51XSYyTq2nzxfX1yR5A4+e
         Qyj+gXRJ97VlVoksg//h87fEIniYXV1PtN1X6mhDwIa7tsyutFz6xJMtkA0mdjEBho2V
         yRhVB4TnXFBPKs3kzKIkm1RRgPhhnMILURzseOWiK+5G22FE3JBqqjzqJDJjtKRI3340
         B9nsveFVZoFOb6xLs6jx07yr+rgEk2BkZTkEs3GHwMu5Gu5H/ANwG6B/3ieHQ8s0iFek
         6EFFJ2r4/bnt1DMftDAu7aUSqILv8wSpCOnoEXWzmxTSwX0NLvOEuNbUiPdTCtsoZAu+
         ePfw==
X-Gm-Message-State: AOAM531X0bnCQnayf3OmoZtQLSj43qaIuRBxbtoBvZHtrIhlgCqnFQQ0
        ++76r7EC9+qiK+dGupdqUtDCF507NaIcSdYkIUQDCA==
X-Google-Smtp-Source: ABdhPJwTZ71ucLeOztSWb74KVGlYNiX8afd3xXrvAS3MJdD0CYXamCxUdS1A77EFOgLxaG1r05qrTkjvBRNEEa2uGeI=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr1693589vso.165.1598250970881;
 Sun, 23 Aug 2020 23:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200727133837.19086-1-pali@kernel.org> <20200822094136.nm2hlq57jx2yfbju@pali>
In-Reply-To: <20200822094136.nm2hlq57jx2yfbju@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 08:35:34 +0200
Message-ID: <CAPDyKFr7GfXxH4GKbshEtS5--Ud992chqSV17KoNjN-VtshrTQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdio: Export CISTPL_VERS_1 attributes to userspace
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 at 11:41, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello Ulf! I would like to remind you this SDIO patch series. Could you
> please look and review it?

Yes, thanks for pinging, I will have a look.

Kind regards
Uffe

>
> On Monday 27 July 2020 15:38:33 Pali Roh=C3=A1r wrote:
> > CISTPL_VERS_1 structure contains useful information for identification
> > of SDIO cards. It contains revision number according to which standard
> > is SDIO card compliant. And also it contain human readable info strings
> > which should contain manufacturer name or product information, like for
> > old PCMCIA cards. SDIO simplified specification 3.00 just contain
> > reference to PCMCIA metaformat specification for definition of that
> > CISTPL_VERS_1 structure itself.
> >
> > Human readable SDIO card strings can be useful for userspace to do card
> > identification. Until now kernel exported to userspace only vendor and
> > device numbers but these numbers do not help to identify new or unknown
> > cards.
> >
> >
> > I have tested these patches with Marwell 88W8997 SDIO card (WiFi+Blueto=
oth)
> > and here is content of attributes available in userspace:
> >
> > $ grep . /sys/class/mmc_host/mmc0/mmc0:0001/* /sys/class/mmc_host/mmc0/=
mmc0:0001/*/*
> > /sys/class/mmc_host/mmc0/mmc0:0001/device:0x9140
> > /sys/class/mmc_host/mmc0/mmc0:0001/info1:Marvell
> > /sys/class/mmc_host/mmc0/mmc0:0001/info2:Wireless Device ID: 50
> > /sys/class/mmc_host/mmc0/mmc0:0001/ocr:0x00200000
> > /sys/class/mmc_host/mmc0/mmc0:0001/rca:0x0001
> > /sys/class/mmc_host/mmc0/mmc0:0001/revision:1.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/type:SDIO
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:MMC_TYPE=3DSDIO
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_ID=3D02DF:9140
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_REVISION=3D1.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO1=3DMarvell
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO2=3DWireless Device =
ID: 50
> > /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO3=3D
> > /sys/class/mmc_host/mmc0/mmc0:0001/vendor:0x02df
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/class:0x00
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/device:0x9141
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/info1:Marvell WiFi Devic=
e
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/modalias:sdio:c00v02DFd9=
141
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/revision:1.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:DRIVER=3Dmwifiex_=
sdio
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_CLASS=3D00
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_ID=3D02DF:91=
41
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_REVISION=3D1=
.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO1=3DMarv=
ell WiFi Device
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO2=3D
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:MODALIAS=3Dsdio:c=
00v02DFd9141
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/vendor:0x02df
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/class:0x00
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/device:0x9142
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/info1:Marvell Bluetooth =
Device
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/modalias:sdio:c00v02DFd9=
142
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/revision:1.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:DRIVER=3Dbtmrvl_s=
dio
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_CLASS=3D00
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_ID=3D02DF:91=
42
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_REVISION=3D1=
.0
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO1=3DMarv=
ell Bluetooth Device
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO2=3D
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:MODALIAS=3Dsdio:c=
00v02DFd9142
> > /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/vendor:0x02df
> > /sys/class/mmc_host/mmc0/mmc0:0001/power/control:auto
> > /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_active_time:0
> > /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_status:unsupported
> > /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_suspended_time:0
> > /sys/class/mmc_host/mmc0/mmc0:0001/subsystem/drivers_autoprobe:1
> >
> > As can be seen SDIO card does not provide all 4 info strings as require=
d by
> > SDIO/PCMCIA specificaion and the third and the second strings are empty=
.
> >
> >
> > Pali Roh=C3=A1r (4):
> >   mmc: sdio: Check for CISTPL_VERS_1 buffer size
> >   mmc: sdio: Parse CISTPL_VERS_1 major and minor revision numbers
> >   mmc: sdio: Extend sdio_config_attr macro and use it also for modalias
> >   mmc: sdio: Export SDIO revision and info strings to userspace
> >
> >  drivers/mmc/core/bus.c        | 12 ++++++++
> >  drivers/mmc/core/sd.c         | 36 +++++++++++++++++++++--
> >  drivers/mmc/core/sdio.c       | 24 ++++++++++++++++
> >  drivers/mmc/core/sdio_bus.c   | 54 ++++++++++++++++++++++++++---------
> >  drivers/mmc/core/sdio_cis.c   | 11 +++++++
> >  include/linux/mmc/card.h      |  2 ++
> >  include/linux/mmc/sdio_func.h |  2 ++
> >  7 files changed, 124 insertions(+), 17 deletions(-)
> >
> > --
> > 2.20.1
> >
