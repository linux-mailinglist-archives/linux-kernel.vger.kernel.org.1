Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A342AE0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgKJUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:30:05 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63702065E;
        Tue, 10 Nov 2020 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040204;
        bh=qPD+Y/c5XbWSUp40YSha6SI5TcwaBNNhHibumy2giZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCL3BHmtGairaWBM5fU+r2Zwn4wulzIkR3nbO+yK07HiuBAmG06ErAEpEa0OF5Jlo
         1xHBvP5xnCtt/h2oOeFiTkgJO+vbOOHQx2vQHm9okTTOVpgQ7opq5pxgMbBDpg6iPx
         7B8uaIHs/AOTFq4FteVjQxCIzh2mbDLJnylTBviw=
Date:   Tue, 10 Nov 2020 21:31:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers: make struct device_driver::remove return void
Message-ID: <X6r4ikS3SBPLqjZ1@kroah.com>
References: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:07:23PM +0100, Uwe Kleine-König wrote:
> The driver core doesn't check the return value of the remove callback
> because there is only little software can do when hardware disappears.
> 
> So change the callback to not return a value at all and adapt all users.
> The motivation for this change is that some driver authors have a
> misconception about failures in the remove callback. Making it void
> makes it pretty obvious that there is no error handling to be expected.
> 
> Most drivers were easy to convert as they returned 0 unconditionally, I
> added a warning to code paths that returned an error code (that was
> ignored already before).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I expect that there are still a few driver that need adaption as I only
> build tested allmodconfig on ARM and amd64.
> 
> Best regards
> Uwe
> 
>  drivers/acpi/processor_driver.c         | 10 ++++------
>  drivers/amba/bus.c                      |  7 ++++---
>  drivers/base/platform.c                 | 13 +++++++------
>  drivers/bus/fsl-mc/fsl-mc-bus.c         |  7 ++-----
>  drivers/bus/mhi/core/init.c             |  6 ++----
>  drivers/char/hw_random/optee-rng.c      |  4 +---
>  drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++++----
>  drivers/firmware/broadcom/tee_bnxt_fw.c |  4 +---
>  drivers/fsi/fsi-master-hub.c            |  4 +---
>  drivers/fsi/fsi-sbefifo.c               |  4 +---
>  drivers/fsi/fsi-scom.c                  |  4 +---
>  drivers/gpu/drm/drm_mipi_dsi.c          |  7 +++++--
>  drivers/gpu/host1x/bus.c                | 11 +++++++----
>  drivers/greybus/core.c                  |  4 +---
>  drivers/hsi/clients/cmt_speech.c        |  4 +---
>  drivers/hsi/clients/hsi_char.c          |  4 +---
>  drivers/hsi/clients/nokia-modem.c       |  4 +---
>  drivers/hsi/clients/ssi_protocol.c      |  4 +---
>  drivers/i2c/busses/i2c-fsi.c            |  4 +---
>  drivers/input/rmi4/rmi_bus.c            |  4 +---
>  drivers/input/rmi4/rmi_driver.c         |  4 +---
>  drivers/input/touchscreen/wm97xx-core.c |  7 +++----
>  drivers/mfd/ucb1400_core.c              |  3 +--
>  drivers/net/ethernet/3com/3c509.c       |  5 ++---
>  drivers/net/ethernet/3com/3c59x.c       |  3 +--
>  drivers/net/ethernet/dec/tulip/de4x5.c  |  4 +---
>  drivers/net/fddi/defxx.c                |  5 ++---
>  drivers/net/phy/mdio_device.c           |  4 +---
>  drivers/net/phy/phy_device.c            |  4 +---
>  drivers/pci/pcie/portdrv_core.c         |  5 ++---
>  drivers/scsi/advansys.c                 |  3 +--
>  drivers/scsi/aha1740.c                  |  4 +---
>  drivers/scsi/aic7xxx/aic7770_osm.c      |  3 +--
>  drivers/scsi/ch.c                       |  3 +--
>  drivers/scsi/sd.c                       |  6 ++----
>  drivers/scsi/ses.c                      |  3 +--
>  drivers/scsi/sim710.c                   |  3 +--
>  drivers/scsi/sr.c                       |  6 ++----
>  drivers/scsi/st.c                       |  5 ++---
>  drivers/siox/siox-core.c                |  6 ++++--
>  drivers/soundwire/bus_type.c            | 13 +++++++------
>  drivers/spi/spi.c                       |  8 +++++---
>  drivers/usb/core/driver.c               |  7 ++-----
>  drivers/visorbus/visorbus_main.c        |  5 +----
>  include/linux/device/driver.h           |  2 +-
>  sound/core/seq/oss/seq_oss_synth.c      |  6 ++----
>  sound/core/seq/oss/seq_oss_synth.h      |  2 +-
>  sound/core/seq/seq_midi.c               |  6 +++---
>  sound/drivers/opl3/opl3_seq.c           | 10 ++++++----
>  sound/drivers/opl4/opl4_seq.c           |  9 +++++----
>  sound/hda/ext/hdac_ext_bus.c            |  9 +++++++--
>  sound/isa/sb/emu8000_synth.c            |  5 ++---
>  sound/pci/emu10k1/emu10k1_synth.c       |  5 ++---
>  sound/pci/hda/hda_bind.c                | 11 +++++++----
>  54 files changed, 129 insertions(+), 172 deletions(-)

First off, that's a lot of drivers with a "raw" remove function, why is
anyone doing that?  It should all be wrapped up in the bus that the
drivers are on.

In digging, ugh, looks like there's some sound driver abuse here that
should be fixed up first, which will cause you to get these "for free",
and some busses should be fixed up as well.

This type of patch should only have to bus code, if things are right,
not individual drivers.  It's not your fault, but fixing that up will
make this patch easier as it will be in bisectable pieces :)

thanks,

greg k-h
