Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB82CAA43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404182AbgLARyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:54:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:32626 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgLARyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:54:55 -0500
IronPort-SDR: lxb89I+hgIk3kZ1z5tRpioGk+OugZ0q/A4MiQwQswFlgOG7BAlx9vVp3Pa7Xyv/E6u8Us2ZZ6B
 n9B+WOQnf9QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="172090288"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172090288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 09:53:14 -0800
IronPort-SDR: xWPLBeStGXG9Cwge6UOzsqxxNd88soLX3oa2speAsdv9z8wx8GD5EWdkvJXiv8UGHJMMPA7rrD
 sjPbgV9+WKEQ==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="345559125"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 09:53:14 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AF3CC6363;
        Tue,  1 Dec 2020 09:53:13 -0800 (PST)
Date:   Tue, 1 Dec 2020 09:53:13 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        markgross@kernel.org, adam.r.gretzinger@intel.com
Subject: Re: [PATCH 00/22] Intel Vision Processing Unit base enabling part 1
Message-ID: <20201201175313.GC56560@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <X8YXdJ2CDg2TI5LF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8YXdJ2CDg2TI5LF@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:14:12AM +0100, Greg KH wrote:
> On Mon, Nov 30, 2020 at 03:06:45PM -0800, mgross@linux.intel.com wrote:
> > From: mark gross <mgross@linux.intel.com>
> > 
> > The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
> > the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
> > SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
> > Vision Processing accelerator add in card.
> > 
> > This part 1 of the patches make up the base or core of the stack needed to
> > enable both use cases for the VPU.
> > 
> > Part 2 includes 11 more patches that depend on part 1.  Those should be ready
> > in a couple of weeks or less.
> > 
> > I am trying something a bit new with this sequence where I've been working with
> > the driver developers as a "pre-maintainer" reviewing and enforcing the kernel
> > expectations as I understand them.  Its taken a couple of months to get this
> > code to the point I feel its ready for public posting.  My goal is to make sure
> > it meets expectations for quality and compliance with kernel expectations and
> > there will be mostly technical / design issues to talk about.
> > 
> > Thanks for looking at these and providing feedback.
> > 
> > --mark
> > p.s. I have had a problem my MTA configuration between mutt and git send-email
> > where I was using msmpt to send from mutt (because 15+ years ago its the first
> > way I got to work and never changed) while my worstation MTA that git
> > send-email uses was un-configured resulting in my return-path naming my
> > workstion withing the firewall.  I suck at email administration.
> > 
> > I appologies for the multiple copies.
> 
> Ah, here's the full set of patches...
> 
> But, you didn't cc: everyone on them, some of us just got a partial set
> of patches, why?
Because I thought ccing everyone on all the changes was not what was expected.
Does the DT guy want to see all the non-DT changes?

this is my first time sending a big patch set that crosses subsystems like
this.  I'm not sure what the preferd way to do things so I used
get_maintainer.pl on each patch to add thime in the cc: tags just above the
signed off's.

Should I have simply concatinated the list of mainttainers and CC them all on
all the patches?

> 
> still confused,
its my fault.  

--mark
