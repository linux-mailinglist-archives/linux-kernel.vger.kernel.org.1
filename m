Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013212EC95B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAGETe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:19:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:19143 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAGETd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:19:33 -0500
IronPort-SDR: GLj9rOtLIqHBONZF+DGLb944XTvh+CPbFUOWlfivHg1hDphgk2rAdJnkq/L82CmhyN53Vs5EWl
 cUpeRD8e5QEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="177524966"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="177524966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 20:18:52 -0800
IronPort-SDR: fqLeDLFnIN/0ZwUT4JjYAvGTygD1eWoXNQOB67KSb2TeppFGEE7s+qTVdSexR6x2tq4Rjw+uix
 P1c2kHeZ+i4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="351118965"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2021 20:18:50 -0800
Date:   Thu, 7 Jan 2021 12:14:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, russell.h.weight@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH 2/2] misc: add support for retimers interfaces on Intel
  MAX 10 BMC
Message-ID: <20210107041405.GA7750@yilunxu-OptiPlex-7050>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
 <1609918567-13339-3-git-send-email-yilun.xu@intel.com>
 <X/VtOvRyoKJ9wCkH@kroah.com>
 <20210106085329.GA13860@yilunxu-OptiPlex-7050>
 <X/V9hvXYlUOT9U2n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/V9hvXYlUOT9U2n@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 10:06:14AM +0100, Greg KH wrote:
> On Wed, Jan 06, 2021 at 04:53:29PM +0800, Xu Yilun wrote:
> > On Wed, Jan 06, 2021 at 08:56:42AM +0100, Greg KH wrote:
> > > On Wed, Jan 06, 2021 at 03:36:07PM +0800, Xu Yilun wrote:
> > > > This driver supports the ethernet retimers (C827) for the Intel PAC
> > > > (Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.
> > > > 
> > > > C827 is an Intel(R) Ethernet serdes transceiver chip that supports
> > > > up to 100G transfer. On Intel PAC N3000 there are 2 C827 chips
> > > > managed by the Intel MAX 10 BMC firmware. They are configured in 4 ports
> > > > 10G/25G retimer mode. Host could query their link states and firmware
> > > > version information via retimer interfaces (Shared registers) on Intel
> > > > MAX 10 BMC. The driver creates sysfs interfaces for users to query these
> > > > information.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-driver-intel-m10-bmc-retimer |  32 +++++
> > > >  drivers/misc/Kconfig                               |  10 ++
> > > >  drivers/misc/Makefile                              |   1 +
> > > >  drivers/misc/intel-m10-bmc-retimer.c               | 158 +++++++++++++++++++++
> > > >  4 files changed, 201 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > > >  create mode 100644 drivers/misc/intel-m10-bmc-retimer.c
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > > > new file mode 100644
> > > > index 0000000..528712a
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
> > > > @@ -0,0 +1,32 @@
> > > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/tag
> > > > +Date:		Jan 2021
> > > > +KernelVersion:	5.12
> > > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > +Description:	Read only. Returns the tag of the retimer chip. Now there are 2
> > > > +		retimer chips on Intel PAC N3000, they are tagged as
> > > > +		'retimer_A' and 'retimer_B'.
> > > > +		Format: "retimer_%c".
> > > > +
> > > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/sbus_version
> > > > +Date:		Jan 2021
> > > > +KernelVersion:	5.12
> > > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > +Description:	Read only. Returns the Transceiver bus firmware version of
> > > > +		the retimer chip.
> > > > +		Format: "0x%04x".
> > > > +
> > > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/serdes_version
> > > > +Date:		Jan 2021
> > > > +KernelVersion:	5.12
> > > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > +Description:	Read only. Returns the SERDES firmware version of the retimer
> > > > +		chip.
> > > > +		Format: "0x%04x".
> > > > +
> > > > +What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/link_statusX
> > > > +Date:		Jan 2021
> > > > +KernelVersion:	5.12
> > > > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > +Description:	Read only. Returns the status of each line side link. "1" for
> > > > +		link up, "0" for link down.
> > > > +		Format: "%u".
> > > 
> > > Who is going to use all of these read-only attributes?
> > 
> > The Intel OPAE (Open Programmable Acceleration Engine) lib handles these
> > attrs.
> 
> I have no idea what that is, you should put a pointer to the source for
> this in either the changelog comment, or here in the sysfs entries to
> show who is using this.

This is the source of the OPAE lib.

https://github.com/OPAE/opae-sdk/

Generally it facilitate the development on all the DFL (Device Feature
List) based FPGA Cards, including the management of static region &
dynamic region reprogramming, accelerators accessing and the board
specific peripherals.

I'll add the link in the changelog.

> 
> > For the version attrs, the OPAE retimer firmware update tool will query
> > them to make sure the update is succeed.
> 
> Why does anyone care about that?  The firmware download logic should
> handle that properly, right?

Yes, the firmware download tool could always tells the update is succeed
or fail. But on another day we may need to check where we are by reading
the version numbers. An OPAE tool help collects the versions and users
could then check the release notes to see the detailed change.

> 
> > For the link_status attrs, the OPAE net tools handles it.
> 
> So not the normal userspace networking tools?
> 
> If not, we need to get an ack from the networking developers as to why
> you are not following their existing user/kernel apis.

This is the previous thread:

https://lore.kernel.org/netdev/1603442745-13085-2-git-send-email-yilun.xu@intel.com/

I'll resend the patch and loop in the netdev maintainers for further
discussion.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
