Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3ED24373A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHMJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 05:07:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:7109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMJHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:07:49 -0400
IronPort-SDR: 9PcyCk15d7S+UDmSEln3MvyU1nw4FAkxi8pCCwhTBACVlG1g2w+gLo9UvIvLuCrilhujA1j/pJ
 V0v6lwIHT4HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="151605469"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="151605469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 02:07:49 -0700
IronPort-SDR: /dng0qgxe4ytvTgRYkcMNtGBMOynSwGAPVH+eX/Wk2LdOA8CuIW7OqoOQivzodL7qoLnQ7+pci
 3UU1b2qIBySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="318448547"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2020 02:07:47 -0700
Date:   Thu, 13 Aug 2020 17:04:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Moritz Fischer' <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200813090409.GA1080@yilunxu-OptiPlex-7050>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
 <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
 <20200813075843.GB7383@yilunxu-OptiPlex-7050>
 <54216e492cec4f84bc43dee176130e89@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54216e492cec4f84bc43dee176130e89@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:28:05AM +0000, David Laight wrote:
> From: Xu Yilun
> > Sent: 13 August 2020 08:59
> > On Wed, Aug 12, 2020 at 08:52:39AM +0000, David Laight wrote:
> > > From: Moritz Fischer
> > > > Sent: 12 August 2020 04:56
> > > >
> > > > On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > > > > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > > > > enough for feature id.
> > > > >
> > > > > This patch changes all feature id related places to fit u16.
> > >
> > > How much bigger does it make the kernel?
> > 
> > The patch changes the definition of feature id from u64 to u16, and will
> > make the kernel slightly smaller.
> 
> Unlikely.
> Most of the structures will gain a 'pad' field.
> Using u16 for function parameters and results almost certainly
> requires instructions to mask the value.
> Any arithmetic on u16 will require masking instructions on
> (probably) all architectures except x86.
> 
> Using 'unsigned int' is probably best.
> 
> u16 is never a good idea unless you are defining enough
> of them in a structure (eg as an array) to reduce the
> structure size below some threshold.
> (Or are matching some hardware layout.)

I got it. Thanks for your detailed explanation. I think we may change them to
u32. Is it the same case for u8? Think we may also change the dfl_device_id.type.


Hi Moritz:

The patch is applied to for-next, is it possible we recall it, or we
make another fix after it?

Thanks,
Yilun.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
