Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21084224956
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgGRGq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 02:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgGRGq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:46:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4452074B;
        Sat, 18 Jul 2020 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595054819;
        bh=D5Xj9nuGpdxU4UOsgskwkpEk7lsaF7ap2StCvE8+brQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCikUobpjDAjVG5hYAJ1h09UJkKCTneYnOdV6OZDyvdnZeid1im2ob1T2KJLdiW+2
         Z7M+bTtpT6LkWNn/c965zZ1KrLBpPUnKxY52OW01pPu70fwNl1s46e9GGIOKixbZLn
         9po0iA4ae4jDLePVVUpmN/cF5Z+6SfW3pS8zOtX4=
Date:   Sat, 18 Jul 2020 08:46:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200718064656.GB245355@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155810.GC186665@kroah.com>
 <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:18:46PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Sunday, July 12, 2020 10:58 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > 
> > On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > > +static int dlb2_probe(struct pci_dev *pdev,
> > > +		      const struct pci_device_id *pdev_id) {
> > > +	struct dlb2_dev *dlb2_dev;
> > > +	int ret;
> > > +
> > > +	dev_dbg(&pdev->dev, "probe\n");
> > 
> > ftrace is your friend.  Remove all of your debugging code now, you don't need
> > it anymore, especially for stuff like this where you didn't even need it in the
> > first place :(
> 
> I'll remove this and other similar dev_dbg() calls. This was an oversight on my part.
> 
> I have other instances that a kprobe can't easily replace, such as printing structure contents, that are useful for tracing the usage of the driver. It looks like other misc drivers use dev_dbg() similarly -- do you consider this an acceptable use of a debug print?

Why can't a kernel tracepoint print a structure?

thanks,

greg k-h
