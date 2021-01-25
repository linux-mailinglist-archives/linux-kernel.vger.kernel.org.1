Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1F303063
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbhAYXn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:43:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:55690 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732665AbhAYXlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:41:53 -0500
IronPort-SDR: 14GIq/HaNbCX9o3u/CpDhNBpx6F1FemKFhz9D/Argd7HogAOfcV8Kq4fZr8szUvDnWvHAMwHcK
 VatfQOPQ02BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179967802"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179967802"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 15:39:36 -0800
IronPort-SDR: 0c5+MwZ4nPWpzySfO5nrCXG3v+C8e/ZR/qIys6UWsnw9a26vANP5hMuWso44uL30BDIzWlKV1z
 mwc0GegIw4sw==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="402534524"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 15:39:35 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 1F7E66365;
        Mon, 25 Jan 2021 15:39:35 -0800 (PST)
Date:   Mon, 25 Jan 2021 15:39:35 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: Re: [PATCH v2 29/34] Intel tsens i2c slave driver.
Message-ID: <20210125233935.GA13745@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com>
 <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:15:06PM -0800, Randy Dunlap wrote:
> On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > index 8b263fdd80c3..c2138339bd89 100644
> > --- a/drivers/misc/intel_tsens/Kconfig
> > +++ b/drivers/misc/intel_tsens/Kconfig
> > @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
> >  	  Say Y if using a processor that includes the Intel VPU such as
> >  	  Keem Bay.  If unsure, say N.
> >  
> > +config INTEL_TSENS_I2C_SLAVE
> > +	bool "I2C slave driver for intel tsens"
> 
> Why bool instead of tristate?
Becuase the I2C driver depends on a file scoped global i2c_plat_data
instanciated in the INTELL_TSENS_LOCAL_HOST DRIVER (intel_tsens_thermal.[ch])

Udhaya, would you care to comment further?

--mark


> 
> > +	depends on INTEL_TSENS_LOCAL_HOST
> > +	select I2C
> > +	select I2C_SLAVE
> > +	help
> > +	  This option enables tsens i2c slave driver.
> 
> 	                            I2C
> 
> > +
> > +	  This driver is used for reporting thermal data via I2C
> > +	  SMBUS to remote host.
> > +	  Enable this option if you want to have support for thermal
> > +	  management controller
> 
> 	             controller.
> 
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
