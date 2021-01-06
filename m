Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE70C2EBB74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbhAFI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:58:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:9556 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbhAFI64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:58:56 -0500
IronPort-SDR: 01zKe0lo6XqYNfIKDqYH3u3B7C68PPe/bQvs4HI4ZWg3AxB8qIJRTFqksUOnNEUZORg9lxdZvk
 rXrbyTShQfOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164322509"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="164322509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 00:58:15 -0800
IronPort-SDR: S8858dBH4eM/cR2PNZhdpu116YWdOo4bpNpPX4y2On1tMPy+dlwYTQ66TNF0/dF2T7a7E+Maun
 wk6ewBUVub7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="350746261"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2021 00:58:13 -0800
Date:   Wed, 6 Jan 2021 16:53:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH 2/2] misc: add support for retimers interfaces on Intel
  MAX 10 BMC
Message-ID: <20210106085329.GA13860@yilunxu-OptiPlex-7050>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
 <1609918567-13339-3-git-send-email-yilun.xu@intel.com>
 <X/VtOvRyoKJ9wCkH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/VtOvRyoKJ9wCkH@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:56:42AM +0100, Greg KH wrote:
> On Wed, Jan 06, 2021 at 03:36:07PM +0800, Xu Yilun wrote:
> > This driver supports the ethernet retimers (C827) for the Intel PAC
> > (Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.
> > 
> > C827 is an Intel(R) Ethernet serdes transceiver chip that supports
> > up to 100G transfer. On Intel PAC N3000 there are 2 C827 chips
> > managed by the Intel MAX 10 BMC firmware. They are configured in 4 ports
> > 10G/25G retimer mode. Host could query their link states and firmware
> > version information via retimer interfaces (Shared registers) on Intel
> > MAX 10 BMC. The driver creates sysfs interfaces for users to query these
> > information.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc-retimer |  32 +++++
> >  drivers/misc/Kconfig                               |  10 ++
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/intel-m10-bmc-retimer.c               | 158 +++++++++++++++++++++
> >  4 files changed, 201 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> >  create mode 100644 drivers/misc/intel-m10-bmc-retimer.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > new file mode 100644
> > index 0000000..528712a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > @@ -0,0 +1,32 @@
> > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/tag
> > +Date:		Jan 2021
> > +KernelVersion:	5.12
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the tag of the retimer chip. Now there are 2
> > +		retimer chips on Intel PAC N3000, they are tagged as
> > +		'retimer_A' and 'retimer_B'.
> > +		Format: "retimer_%c".
> > +
> > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/sbus_version
> > +Date:		Jan 2021
> > +KernelVersion:	5.12
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the Transceiver bus firmware version of
> > +		the retimer chip.
> > +		Format: "0x%04x".
> > +
> > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/serdes_version
> > +Date:		Jan 2021
> > +KernelVersion:	5.12
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the SERDES firmware version of the retimer
> > +		chip.
> > +		Format: "0x%04x".
> > +
> > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/link_statusX
> > +Date:		Jan 2021
> > +KernelVersion:	5.12
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the status of each line side link. "1" for
> > +		link up, "0" for link down.
> > +		Format: "%u".
> 
> Who is going to use all of these read-only attributes?

The Intel OPAE (Open Programmable Acceleration Engine) lib handles these
attrs.

For the version attrs, the OPAE retimer firmware update tool will query
them to make sure the update is succeed.

For the link_status attrs, the OPAE net tools handles it.

> 
> And why isn't this information exported in the "normal" way for network
> devices?  Having them as custom sysfs attributes ensures that no
> existing tools will work with these at all, right?  Why not do the
> standard thing here isntead?

I had sent some RFC patches to expose the Line Side Ether Group + retimer +
QSFP as a netdev, and got some comments from netdev Maintainers.

The network part of the N3000 card is like the following:

                       +----------------------------------------+
                       |                  FPGA                  |
  +----+   +-------+   +-----------+  +----------+  +-----------+   +----------+
  |QSFP|---|retimer|---|Line Side  |--|User logic|--|Host Side  |---|XL710     |
  +----+   +-------+   |Ether Group|  |          |  |Ether Group|   |Ethernet  |
                       |(PHY + MAC)|  |wiring &  |  |(MAC + PHY)|   |Controller|
                       +-----------+  |offloading|  +-----------+   +----------+
                       |              +----------+              |
                       |                                        |
                       +----------------------------------------+

The main concern is that physically the QSFP & retimer is managed by the
BMC and host could only get the retimer link states. This is not enough
to support some necessary netdev ops.  E.g. host cannot realize the
type/speed of the SFP by "ethtool -m", then users could not configure the
various layers accordingly.

This means the existing net tool can not work with it, so this patch just
expose the link states as custom sysfs attrs.

Thanks,
Yilun 
