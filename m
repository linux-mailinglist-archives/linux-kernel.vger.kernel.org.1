Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEC2C4DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgKZEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387541AbgKZEW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:22:28 -0500
Received: from localhost (unknown [122.179.79.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE46206B7;
        Thu, 26 Nov 2020 04:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606364547;
        bh=lPPiTGMeU8PpU5mX6yzjCp594S3qDNomjgsxTVj3DMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjiLoMq8FjTpL1Qf8n5/xSWCYAhU98rLyyh6jPTL8jCx+EfjcNxYxLGdvir2CVMl5
         BvimTMbxfi55nSDDAkUnZgfzxxBbTOOVWvHSuC+ZifX6xrHWEFEByX6nqI1NphZx61
         lHMZ6ltA0iROGuysgVk8DA3xngKQpLfZ1zf5HFho=
Date:   Thu, 26 Nov 2020 09:52:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Message-ID: <20201126042222.GG8403@vkoul-mobl>
References: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
 <20201125050528.GC8403@vkoul-mobl>
 <DM6PR11MB4074BC35644527BA45C1CB3CFFF90@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4074BC35644527BA45C1CB3CFFF90@DM6PR11MB4074.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-20, 03:11, Liao, Bard wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Wednesday, November 25, 2020 1:05 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> > gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>; Lin,
> > Mengdong <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on
> > add
> > 
> > On 24-11-20, 21:07, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >
> > > The 'master' device acts as a glue layer used during bus
> > > initialization only, and it needs to be 'transparent' for pm_runtime
> > > management. Its behavior should be that it becomes active when one of
> > > its children becomes active, and suspends when all of its children are
> > > suspended.
> > >
> > > In our tests on Intel platforms, we routinely see these sort of
> > > warnings on the initial boot:
> > >
> > > [ 21.447345] rt715 sdw:3:25d:715:0: runtime PM trying to activate
> > > child device sdw:3:25d:715:0 but parent (sdw-master-3) is not active
> > >
> > > This is root-caused to a missing setup to make the device 'active' on
> > > probe. Since we don't want the device to remain active forever after
> > > the probe, the autosuspend configuration is also enabled at the end of
> > > the probe - the device will actually autosuspend only in the case
> > > where there are no devices physically attached. In practice, the
> > > master device will suspend when all its children are no longer active.
> > >
> > > Fixes: bd84256e86ecf ('soundwire: master: enable pm runtime')
> > > Signed-off-by: Pierre-Louis Bossart
> > > <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > ---
> > >  drivers/soundwire/master.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
> > > index 3488bb824e84..9b05c9e25ebe 100644
> > > --- a/drivers/soundwire/master.c
> > > +++ b/drivers/soundwire/master.c
> > > @@ -8,6 +8,15 @@
> > >  #include <linux/soundwire/sdw_type.h>  #include "bus.h"
> > >
> > > +/*
> > > + * The 3s value for autosuspend will only be used if there are no
> > > + * devices physically attached on a bus segment. In practice enabling
> > > + * the bus operation will result in children devices become active
> > > +and
> > > + * the master device will only suspend when all its children are no
> > > + * longer active.
> > > + */
> > > +#define SDW_MASTER_SUSPEND_DELAY_MS 3000
> > > +
> > >  /*
> > >   * The sysfs for properties reflects the MIPI description as given
> > >   * in the MIPI DisCo spec
> > > @@ -154,7 +163,12 @@ int sdw_master_device_add(struct sdw_bus *bus,
> > struct device *parent,
> > >  	bus->dev = &md->dev;
> > >  	bus->md = md;
> > >
> > > +	pm_runtime_set_autosuspend_delay(&bus->md->dev,
> > SDW_MASTER_SUSPEND_DELAY_MS);
> > > +	pm_runtime_use_autosuspend(&bus->md->dev);
> > > +	pm_runtime_mark_last_busy(&bus->md->dev);
> > > +	pm_runtime_set_active(&bus->md->dev);
> > >  	pm_runtime_enable(&bus->md->dev);
> > > +	pm_runtime_idle(&bus->md->dev);
> > 
> > I understand that this needs to be done somewhere but is the core the right
> > place. In intel case it maybe a dummy device but other controllers are real
> > devices and may not support pm.
> > 
> > I think better idea would be to do this in respective driver.. that way it
> > would be an opt-in for device supporting pm.
> 
> Should it be put in the same place as pm_runtime_enable?
> IMHO, pm_runtime_enable is in the core already and it seems to be harmless
> for devices which don't support pm. And pm can still be optional on md's
> parent device.

For intel case yes, but world is not only intel, there are md which do
not have a parent like sof. they are real sdw controller devices

-- 
~Vinod
