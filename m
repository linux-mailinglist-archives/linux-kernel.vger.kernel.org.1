Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCF2C5FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392494AbgK0GSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgK0GSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:18:08 -0500
Received: from localhost (unknown [122.167.146.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECBE221FD;
        Fri, 27 Nov 2020 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606457888;
        bh=Rdoi629DjicvHoCKKgi6+NxG/4/rdjkHZDIAQJ5MAJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/HoHHKFJX74NRjz9J8FtFtn84vPzICi+RbaYQdzpvSUqgbHYwOxh+oz1TQdL1Adn
         TZI3vXKLc0HpZkba6veJrNtrtHL+8WIwPUBFm4aYFTUuToZg7lZL2ZHGpZAScxv8Xh
         8WCY65V8QV7qgA+Yrj0CyoqHDtsjcPXrumrTjp3Q=
Date:   Fri, 27 Nov 2020 11:47:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Message-ID: <20201127061758.GK8403@vkoul-mobl>
References: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
 <20201125050528.GC8403@vkoul-mobl>
 <DM6PR11MB4074BC35644527BA45C1CB3CFFF90@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20201126042222.GG8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126042222.GG8403@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-20, 09:52, Vinod Koul wrote:

> > > > @@ -154,7 +163,12 @@ int sdw_master_device_add(struct sdw_bus *bus,
> > > struct device *parent,
> > > >  	bus->dev = &md->dev;
> > > >  	bus->md = md;
> > > >
> > > > +	pm_runtime_set_autosuspend_delay(&bus->md->dev,
> > > SDW_MASTER_SUSPEND_DELAY_MS);
> > > > +	pm_runtime_use_autosuspend(&bus->md->dev);
> > > > +	pm_runtime_mark_last_busy(&bus->md->dev);
> > > > +	pm_runtime_set_active(&bus->md->dev);
> > > >  	pm_runtime_enable(&bus->md->dev);
> > > > +	pm_runtime_idle(&bus->md->dev);
> > > 
> > > I understand that this needs to be done somewhere but is the core the right
> > > place. In intel case it maybe a dummy device but other controllers are real
> > > devices and may not support pm.
> > > 
> > > I think better idea would be to do this in respective driver.. that way it
> > > would be an opt-in for device supporting pm.
> > 
> > Should it be put in the same place as pm_runtime_enable?
> > IMHO, pm_runtime_enable is in the core already and it seems to be harmless
> > for devices which don't support pm. And pm can still be optional on md's
> > parent device.
> 
> For intel case yes, but world is not only intel, there are md which do
> not have a parent like sof. they are real sdw controller devices

Sorry I confused md with real master device ;-) I guess this patch
should be okay then.. As the real parent will control.

Thanks
-- 
~Vinod
