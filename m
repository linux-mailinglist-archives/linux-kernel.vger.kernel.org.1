Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54F2D1C96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLGWBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:01:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:51437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgLGWBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:01:06 -0500
IronPort-SDR: cvAePUdaifUidWYnEWCpqPMbVI3yz4RUvoQ1qwraQKmaxGzTx6/ZeLDrE65VW/1F64PYUgvxw8
 K9RBFxxERWwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173897143"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173897143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:59:20 -0800
IronPort-SDR: QK/Q3dDEb3EbjM7V0j7somE7FX3sEZ3O6gtp7Zm38ocnMw4aUOvV7fxXXr1B3b44GujvRv/TT+
 7lZEggJuRRpg==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="370120200"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:59:19 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 51E256363;
        Mon,  7 Dec 2020 13:59:19 -0800 (PST)
Date:   Mon, 7 Dec 2020 13:59:19 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>
Subject: Re: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
Message-ID: <20201207215919.GF49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-23-mgross@linux.intel.com>
 <3595d2e5e5de009730b3374bf65e96359c02392d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3595d2e5e5de009730b3374bf65e96359c02392d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 07:05:34PM -0800, Joe Perches wrote:
> On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> > From: Seamus Kelly <seamus.kelly@intel.com>
> > 
> > Refactor the too large IOCTL function to call helper functions.
> 
> This should not be sent as a known poor patch as patch 21 of 22
> and then updated in patch 22 of 22 with a better style.
> 
> This should be sent in the as desired final form the first time
> so that people don't give you useless notes.

We will re-work the changes to better integrate this one in the earlier
changes.

--mark

> 
> > @@ -342,427 +323,84 @@ static int kmb_xlink_remove(struct platform_device *pdev)
> >   * IOCTL function for User Space access to xlink kernel functions
> >   *
> >   */
> > +int ioctl_connect(unsigned long arg);
> >  
> > 
> >  static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  {
> > -	struct xlink_handle		devh	= {0};
> > -	struct xlinkopenchannel		op	= {0};
> > -	struct xlinkwritedata		wr	= {0};
> > -	struct xlinkreaddata		rd	= {0};
> > -	struct xlinkreadtobuffer	rdtobuf = {0};
> > -	struct xlinkconnect		con	= {0};
> > -	struct xlinkrelease		rel	= {0};
> > -	struct xlinkstartvpu		startvpu = {0};
> > -	struct xlinkcallback		cb	= {0};
> > -	struct xlinkgetdevicename	devn	= {0};
> > -	struct xlinkgetdevicelist	devl	= {0};
> > -	struct xlinkgetdevicestatus	devs	= {0};
> > -	struct xlinkbootdevice		boot	= {0};
> > -	struct xlinkresetdevice		res	= {0};
> > -	struct xlinkdevmode		devm	= {0};
> > -	struct xlinkregdevevent		regdevevent = {0};
> > -	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
> > -	char name[XLINK_MAX_DEVICE_NAME_SIZE];
> > -	int interface = NULL_INTERFACE;
> > -	u32 device_status = 0;
> > -	u32 num_devices = 0;
> > -	u32 device_mode = 0;
> > -	u32 num_events = 0;
> > -	char filename[64];
> > -	u32 *ev_list;
> > -	u8 reladdr;
> > -	u8 *rdaddr;
> > -	u32 size;
> >  	int rc;
> >  
> > 
> >  	switch (cmd) {
> >  	case XL_CONNECT:
> > -		if (copy_from_user(&con, (void __user *)arg,
> > -				   sizeof(struct xlinkconnect)))
> > -			return -EFAULT;
> > -		if (copy_from_user(&devh, (void __user *)con.handle,
> > -				   sizeof(struct xlink_handle)))
> > -			return -EFAULT;
> > -		rc = xlink_connect(&devh);
> > -		if (rc == X_LINK_SUCCESS) {
> > -			if (copy_to_user((void __user *)con.handle,
> > -					 &devh, sizeof(struct xlink_handle)))
> > -				return -EFAULT;
> > -		}
> > -		if (copy_to_user((void __user *)con.return_code, (void *)&rc,
> > -				 sizeof(rc)))
> > -			return -EFAULT;
> > +		rc = ioctl_connect(arg);
> >  		break;
> 
> etc...
> 
