Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBD301BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAXL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 06:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbhAXL5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:57:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96B5E22C9D;
        Sun, 24 Jan 2021 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611489397;
        bh=kuc0ga0EMCsk0uQBO3oWOefHYQSTrNoAokvBZacsueQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVAevWYvvOlnI5vgZ6fBr0dCE5INW3EeFyp7Bx6ze05EqyFUB87yEDt3ZoB+S2aaf
         696mJTZLPzBlOxN7YZewtkac5OKL/b/w+kIGP9dfQCLSUSiQDguIU1265iOJwXgVQ3
         TbK+mcF+5zGKrpR2WmX7c+vn4Fpuy9Lihe9PlVlw=
Date:   Sun, 24 Jan 2021 12:56:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Thokala, Srikanth" <srikanth.thokala@intel.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <YA1gclRd4HRNrmhM@kroah.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-10-mgross@linux.intel.com>
 <YAhvJ2MxqnX2g0nS@kroah.com>
 <MWHPR11MB14061D584C7CC0CE3AD58F1A85BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB14061D584C7CC0CE3AD58F1A85BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 11:48:29AM +0000, Thokala, Srikanth wrote:
> > > +{
> > > +	struct pci_epf_bar *epf_bar;
> > > +	bool bar_fixed_64bit;
> > > +	int ret, i;
> > > +
> > > +	for (i = BAR_0; i <= BAR_5; i++) {
> > > +		epf_bar = &epf->bar[i];
> > > +		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 <<
> > i));
> > > +		if (bar_fixed_64bit)
> > > +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > > +		if (epc_features->bar_fixed_size[i])
> > > +			epf_bar->size = epc_features->bar_fixed_size[i];
> > > +
> > > +		if (i == BAR_2) {
> > > +			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_2,
> > > +						    BAR2_MIN_SIZE,
> > > +						    epc_features->reserved_bar);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > > +		if (i == BAR_4) {
> > > +			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_4,
> > > +						    BAR4_MIN_SIZE,
> > > +						    epc_features->reserved_bar);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > 
> > Why do you need to check all of this?  Where is the data coming from
> > that could be incorrect?
> 
> PCI BAR attributes, as inputs, are coming from the PCIe controller driver
> through PCIe End Point Framework.  These checks are required to compare the 
> configuration this driver is expecting to the configuration coming from
> the PCIe controller driver.

So why do you not trust that information coming from the caller?
Shouldn't it always be correct as it already is validated by that
in-kernel caller?  Don't check for things you don't have to check for
because you control the code that calls this stuff.

thanks,

greg k-h
