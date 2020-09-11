Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3053E266770
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIKRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgIKRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:42:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A13C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:42:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so7921009pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FdWGaxXRUitH6K3FRqOi/nwR0BmCC6UFg5CIc1k6uhM=;
        b=diBEe2iSkZ3bLkSY0YmMboYhINNcw0nTH5UBHo/Xtw8YDpxOVXaVhE88DjDlg5Z7YV
         D4hDOSe9/bJX64MJKxJvedW6MqV2VptIlS4P0k1aIcrq4XzXxx+76ObN12VM+oYvDP2k
         hXUDXbBUPklMVDeFMQu6Wh0lcxeMV83pfDvuRBUdhSWtBT2C5GYzZayQvrwe3COcXyTj
         kWAaANHmuV+U6On0ec1S95/2w7icVixqSHQfPG1sqmz6tH6ru9VSRE1DP9yAxRMurdDm
         HyPZa7/GuVdaJ5WLHCy1CyWjzxWg5qrZ2ttcFU5pQyAllybUB8b1DcQWxFy3QpWcvKo8
         /LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdWGaxXRUitH6K3FRqOi/nwR0BmCC6UFg5CIc1k6uhM=;
        b=sDJUkp9+2dKaPfkAGcvbTG4TCcH1XP36xyXsDDE381lvybzUWoik3A/zldlL9PAhpM
         uKpDEs5kL9yOn3k0IEx5s3krqh9m0EDc13jZ3WF3QVoZw8ABH+pl5zodfcOpaXQdjs53
         1lciNpq2pPBuW/SgZ2Tu1NWFHXC81RasiKb9C6XHJ2I7oMcn2jrcqxt9+MH2RENzrwbt
         bVpmWka+CO5480OMAAlPGP4/VE3zkoZ2P6hp/0UNugZyivbnrdWiiwXdgMsPGx5x78/p
         lxZ+p3bg7o8qeAP/wfR52fth2wOh/AmbtTK0UlRG7MzM6bIrp3Yy8C0FNyI5tw5UjG/Q
         hi6Q==
X-Gm-Message-State: AOAM530GcgfYwyDaHAW4XwPmbvYdP4cl4Z/ppye4XcL8uVxNsBa+bKS2
        rxknrUG2Ee9vqOGb41sERoGDQA==
X-Google-Smtp-Source: ABdhPJwGCZMyn01NZcgFHHntzva+eWiW2tTIZd7Wec0SipaLhS8Dt1WPk13cccs9y/NCJHQ0Pk8pSA==
X-Received: by 2002:aa7:911a:0:b029:13e:d13d:a13d with SMTP id 26-20020aa7911a0000b029013ed13da13dmr3121730pfh.37.1599846174703;
        Fri, 11 Sep 2020 10:42:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c128sm3061304pfb.126.2020.09.11.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:42:54 -0700 (PDT)
Date:   Fri, 11 Sep 2020 11:42:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 21/24] coresight: cti: allow cti to be built as a
 module
Message-ID: <20200911174251.GB613136@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-22-tingwei@codeaurora.org>
 <20200910230303.GE590446@xps15>
 <010101747b1340f9-b0542779-88d7-4193-b53b-5b5bfab5d6a3-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101747b1340f9-b0542779-88d7-4193-b53b-5b5bfab5d6a3-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 02:51:33AM +0000, Tingwei Zhang wrote:
> On Fri, Sep 11, 2020 at 07:03:03AM +0800, Mathieu Poirier wrote:
> > On Fri, Aug 21, 2020 at 11:44:42AM +0800, Tingwei Zhang wrote:
> > > Allow to build coresight-cti as a module, for ease of development.
> > > 
> > > - Kconfig becomes a tristate, to allow =m
> > > - append -core to source file name to allow module to
> > >   be called coresight-cti by the Makefile
> > > - add an cti_remove function, for module unload
> > > - move cti_remove_conn_xrefs to cti_remove
> > > - add a MODULE_DEVICE_TABLE for autoloading on boot
> > > 
> > > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > > Tested-by: Mike Leach <mike.leach@linaro.org>
> > > Reviewed-by Mike Leach <mike.leach@linaro.org>
> > > ---
> > >  drivers/hwtracing/coresight/Kconfig           |  5 ++++-
> > >  drivers/hwtracing/coresight/Makefile          |  4 ++--
> > >  .../{coresight-cti.c => coresight-cti-core.c} | 20 ++++++++++++++++++-
> > >  .../hwtracing/coresight/coresight-platform.c  |  1 +
> > >  drivers/hwtracing/coresight/coresight.c       |  1 +
> > >  5 files changed, 27 insertions(+), 4 deletions(-)
> > >  rename drivers/hwtracing/coresight/{coresight-cti.c =>
> > coresight-cti-core.c} (98%)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/Kconfig
> > b/drivers/hwtracing/coresight/Kconfig
> > > index f31778dd0b5d..b04aae2ceecc 100644
> > > --- a/drivers/hwtracing/coresight/Kconfig
> > > +++ b/drivers/hwtracing/coresight/Kconfig
> > > @@ -136,7 +136,7 @@ config CORESIGHT_CPU_DEBUG
> > >  	  module will be called coresight-cpu-debug.
> > >  
> > >  config CORESIGHT_CTI
> > > -	bool "CoreSight Cross Trigger Interface (CTI) driver"
> > > +	tristate "CoreSight Cross Trigger Interface (CTI) driver"
> > >  	depends on ARM || ARM64
> > >  	help
> > >  	  This driver provides support for CoreSight CTI and CTM
> > components.
> > > @@ -147,6 +147,9 @@ config CORESIGHT_CTI
> > >  	  halt compared to disabling sources and sinks normally in driver
> > >  	  software.
> > >  
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called coresight-cti.
> > > +
> > >  config CORESIGHT_CTI_INTEGRATION_REGS
> > >  	bool "Access CTI CoreSight Integration Registers"
> > >  	depends on CORESIGHT_CTI
> > > diff --git a/drivers/hwtracing/coresight/Makefile
> > b/drivers/hwtracing/coresight/Makefile
> > > index f2a568b969c4..0359d5a1588f 100644
> > > --- a/drivers/hwtracing/coresight/Makefile
> > > +++ b/drivers/hwtracing/coresight/Makefile
> > > @@ -19,6 +19,6 @@ coresight-etm4x-y := coresight-etm4x-core.o
> > coresight-etm4x-sysfs.o
> > >  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> > >  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> > >  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> > > -obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o \
> > > -				coresight-cti-platform.o \
> > > +obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
> > > +coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
> > >  				coresight-cti-sysfs.o
> > > diff --git a/drivers/hwtracing/coresight/coresight-cti.c
> > b/drivers/hwtracing/coresight/coresight-cti-core.c
> > > similarity index 98%
> > > rename from drivers/hwtracing/coresight/coresight-cti.c
> > > rename to drivers/hwtracing/coresight/coresight-cti-core.c
> > > index ec286d617b73..d6d5419ec21c 100644
> > > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > > +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> > > @@ -838,7 +838,6 @@ static void cti_device_release(struct device *dev)
> > >  	struct cti_drvdata *ect_item, *ect_tmp;
> > >  
> > >  	mutex_lock(&ect_mutex);
> > > -	cti_remove_conn_xrefs(drvdata);
> > >  	cti_pm_release(drvdata);
> > >  
> > >  	/* remove from the list */
> > > @@ -853,6 +852,18 @@ static void cti_device_release(struct device *dev)
> > >  	if (drvdata->csdev_release)
> > >  		drvdata->csdev_release(dev);
> > >  }
> > > +static int __exit cti_remove(struct amba_device *adev)
> > > +{
> > > +	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > > +
> > > +	mutex_lock(&ect_mutex);
> > > +	cti_remove_conn_xrefs(drvdata);
> > > +	mutex_unlock(&ect_mutex);
> > > +
> > > +	coresight_unregister(drvdata->csdev);
> > > +
> > > +	return 0;
> > 
> > Once again my recommendations from V8 were not followed.
> >
> 
> Sorry for missing your comment. I'll add reason for above change
> in commit message in V11.
>

I have a couple more things to check on this set - please hold off on V11.  I
will let you know when I'm done.
 
> Thanks,
> Tingwei
>  
> > > +}
> > >  
> > >  static int cti_probe(struct amba_device *adev, const struct amba_id
> > *id)
> > >  {
> > > @@ -973,6 +984,8 @@ static const struct amba_id cti_ids[] = {
> > >  	{ 0, 0},
> > >  };
> > >  
> > > +MODULE_DEVICE_TABLE(amba, cti_ids);
> > > +
> > >  static struct amba_driver cti_driver = {
> > >  	.drv = {
> > >  		.name	= "coresight-cti",
> > > @@ -980,6 +993,7 @@ static struct amba_driver cti_driver = {
> > >  		.suppress_bind_attrs = true,
> > >  	},
> > >  	.probe		= cti_probe,
> > > +	.remove		= cti_remove,
> > >  	.id_table	= cti_ids,
> > >  };
> > >  
> > > @@ -1002,3 +1016,7 @@ static void __exit cti_exit(void)
> > >  
> > >  module_init(cti_init);
> > >  module_exit(cti_exit);
> > > +
> > > +MODULE_AUTHOR("Mike Leach <mike.leach@linaro.org>");
> > > +MODULE_DESCRIPTION("Arm CoreSight CTI Driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/hwtracing/coresight/coresight-platform.c
> > b/drivers/hwtracing/coresight/coresight-platform.c
> > > index 227e234a2470..3629b7885aca 100644
> > > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > > @@ -75,6 +75,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle
> > *r_fwnode)
> > >  	}
> > >  	return csdev;
> > >  }
> > > +EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
> > >  
> > >  #ifdef CONFIG_OF
> > >  static inline bool of_coresight_legacy_ep_is_input(struct device_node
> > *ep)
> > > diff --git a/drivers/hwtracing/coresight/coresight.c
> > b/drivers/hwtracing/coresight/coresight.c
> > > index 6c9f6930b8b8..668963b4b7d4 100644
> > > --- a/drivers/hwtracing/coresight/coresight.c
> > > +++ b/drivers/hwtracing/coresight/coresight.c
> > > @@ -288,6 +288,7 @@ void coresight_set_assoc_ectdev_mutex(struct
> > coresight_device *csdev,
> > >  	csdev->ect_dev = ect_csdev;
> > >  	mutex_unlock(&coresight_mutex);
> > >  }
> > > +EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
> > >  
> > >  static int coresight_enable_sink(struct coresight_device *csdev,
> > >  				 u32 mode, void *data)
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum,
> > > a Linux Foundation Collaborative Project
> > > 
