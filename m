Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8471AD4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 05:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgDQDYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 23:24:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:22715 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgDQDYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:24:14 -0400
IronPort-SDR: uRabRcaaOmb+cf1MiuROWjs7h8iT0TDopivNXN8HK7fJixhXf3x2w0WDXGbGKq78/nFT2fx9rk
 b5+qb1bOWYHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 20:24:14 -0700
IronPort-SDR: vm7kEmXJN0BsDyOFZzfPgeTZf2QaefCY0zx1kjPSt7pVlPucMluF6jzrfE1Y6kcew5SMLDtqeZ
 f0IdLxZxxWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="254081720"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 20:24:11 -0700
Date:   Fri, 17 Apr 2020 11:21:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhu@redhat.com" <bhu@redhat.com>
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Message-ID: <20200417032132.GA25293@yilunxu-OptiPlex-7050>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
 <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:05:16AM +0800, Wu, Hao wrote:
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Friday, April 17, 2020 9:56 AM
> > To: Tom Rix <trix@redhat.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; linux-kernel@vger.kernel.org; bhu@redhat.com
> > Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
> >
> > Hi Rix:
> >
> > This patch is based on linux-next. There is an preceding patch
> > (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configure",
> > Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> > This patch is to fix the lkp warning brought by the previous one.
> 
> Yilun
> 
> Is it possible that commit id may be different for master then?

It is possible if the previous patch need a little change when merging
to master.

I'm not sure how to handle this then. But the previous patch is simple
and is unlikely to change.

> 
> Thanks
> Hao
> 
> >
> > Thanks.
> >
> > On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> > > Please check the scope.
> > >
> > > On linus/master, the result of this change looks like
> > >
> > > static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> > > {
> > >     struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > >     struct dfl_fpga_cdev *cdev = drvdata->cdev;
> > >
> > >     if (!num_vfs) {
> > >         /*
> > >          * disable SRIOV and then put released ports back to default
> > >          * PF access mode.
> > >          */
> > >         pci_disable_sriov(pcidev);
> > >
> > >         dfl_fpga_cdev_config_ports_pf(cdev);
> > >
> > >     } else {
> > >         int ret; <--- defined here
> > >
> > >         /*
> > >          * before enable SRIOV, put released ports into VF access mode
> > >          * first of all.
> > >          */
> > >         ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
> > >         if (ret)
> > >             return ret;
> > >
> > >         ret = pci_enable_sriov(pcidev, num_vfs);
> > >         if (ret)
> > >             dfl_fpga_cdev_config_ports_pf(cdev);
> > >     }
> > >
> > >     return ret;  <---- not in scope, not defined here
> > > }
> > >
> > > Tom
