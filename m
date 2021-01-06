Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA52EBB89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAFJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbhAFJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:05:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04FC92310A;
        Wed,  6 Jan 2021 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609923892;
        bh=sZvoIahKG/sNJMkgiygvNzXeRBts4zBsF7PhddKvqTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJ89Y8AE5++IfGOfpBPNtBXbQewUf+JuSwWtoG9d4Z5SL4shLMM1b8NAKMmVaSY5+
         M+7ic3upkbcKXa716wzZqHwLgCRtBRf6sHWaMY424/z06p4xZAvxtpAjmKts1tVpBO
         RRsB2/g6DNoheHFwz5B9+riBOnF83K8BSi7lXWfI=
Date:   Wed, 6 Jan 2021 10:06:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     arnd@arndb.de, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH 2/2] misc: add support for retimers interfaces on Intel
 MAX 10 BMC
Message-ID: <X/V9hvXYlUOT9U2n@kroah.com>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
 <1609918567-13339-3-git-send-email-yilun.xu@intel.com>
 <X/VtOvRyoKJ9wCkH@kroah.com>
 <20210106085329.GA13860@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106085329.GA13860@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:53:29PM +0800, Xu Yilun wrote:
> On Wed, Jan 06, 2021 at 08:56:42AM +0100, Greg KH wrote:
> > On Wed, Jan 06, 2021 at 03:36:07PM +0800, Xu Yilun wrote:
> > > This driver supports the ethernet retimers (C827) for the Intel PAC
> > > (Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.
> > > 
> > > C827 is an Intel(R) Ethernet serdes transceiver chip that supports
> > > up to 100G transfer. On Intel PAC N3000 there are 2 C827 chips
> > > managed by the Intel MAX 10 BMC firmware. They are configured in 4 ports
> > > 10G/25G retimer mode. Host could query their link states and firmware
> > > version information via retimer interfaces (Shared registers) on Intel
> > > MAX 10 BMC. The driver creates sysfs interfaces for users to query these
> > > information.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > ---
> > >  .../ABI/testing/sysfs-driver-intel-m10-bmc-retimer |  32 +++++
> > >  drivers/misc/Kconfig                               |  10 ++
> > >  drivers/misc/Makefile                              |   1 +
> > >  drivers/misc/intel-m10-bmc-retimer.c               | 158 +++++++++++++++++++++
> > >  4 files changed, 201 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > >  create mode 100644 drivers/misc/intel-m10-bmc-retimer.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > > new file mode 100644
> > > index 0000000..528712a
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > > @@ -0,0 +1,32 @@
> > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/tag
> > > +Date:		Jan 2021
> > > +KernelVersion:	5.12
> > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > +Description:	Read only. Returns the tag of the retimer chip. Now there are 2
> > > +		retimer chips on Intel PAC N3000, they are tagged as
> > > +		'retimer_A' and 'retimer_B'.
> > > +		Format: "retimer_%c".
> > > +
> > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/sbus_version
> > > +Date:		Jan 2021
> > > +KernelVersion:	5.12
> > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > +Description:	Read only. Returns the Transceiver bus firmware version of
> > > +		the retimer chip.
> > > +		Format: "0x%04x".
> > > +
> > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/serdes_version
> > > +Date:		Jan 2021
> > > +KernelVersion:	5.12
> > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > +Description:	Read only. Returns the SERDES firmware version of the retimer
> > > +		chip.
> > > +		Format: "0x%04x".
> > > +
> > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/link_statusX
> > > +Date:		Jan 2021
> > > +KernelVersion:	5.12
> > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > +Description:	Read only. Returns the status of each line side link. "1" for
> > > +		link up, "0" for link down.
> > > +		Format: "%u".
> > 
> > Who is going to use all of these read-only attributes?
> 
> The Intel OPAE (Open Programmable Acceleration Engine) lib handles these
> attrs.

I have no idea what that is, you should put a pointer to the source for
this in either the changelog comment, or here in the sysfs entries to
show who is using this.

> For the version attrs, the OPAE retimer firmware update tool will query
> them to make sure the update is succeed.

Why does anyone care about that?  The firmware download logic should
handle that properly, right?

> For the link_status attrs, the OPAE net tools handles it.

So not the normal userspace networking tools?

If not, we need to get an ack from the networking developers as to why
you are not following their existing user/kernel apis.

thanks,

greg k-h
