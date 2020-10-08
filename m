Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCA287358
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgJHL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:28:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:22012 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgJHL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:28:04 -0400
IronPort-SDR: QG7coDREibY5FWHsBpsRxGgWzaV6LK2uxrhzG2b4nb8j+ncmdBLeJ54e5vFTBTe+7SxHIoW6PT
 DOwBgxzLvxEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152235216"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="152235216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 04:28:03 -0700
IronPort-SDR: LI0kr9FE2tdovbWtpPErBSS5aB7HmYlC03phkV2tkYYAkT9IowmDX4co3aBdPoW5wUoANJB2wj
 hrMW7h5esngw==
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="461783186"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 04:28:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kQU6a-001lEN-EQ; Thu, 08 Oct 2020 14:29:04 +0300
Date:   Thu, 8 Oct 2020 14:29:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>, bhelgaas@google.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Add check for DL_ACTIVE bit in
 pciehp_check_link_status()
Message-ID: <20201008112904.GH4077@smile.fi.intel.com>
References: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
 <20201006193830.GA32510@wunner.de>
 <7309c7f3-a895-e4aa-578e-444c5d5734d6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7309c7f3-a895-e4aa-578e-444c5d5734d6@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:43:17PM +0530, Sanjay R Mehta wrote:
> On 10/7/2020 1:08 AM, Lukas Wunner wrote:
> > On Tue, Oct 06, 2020 at 01:24:28PM -0500, Sanjay R Mehta wrote:
> >> if DL_ACTIVE bit is set it means that there is no need to check
> >> PCI_EXP_LNKSTA_LT bit, as DL_ACTIVE would have set only if the link
> >> is already trained. Hence adding a check which takes care of this
> >> scenario.
> > 
> > Sorry for being dense but I don't understand this at all:
> > 
> > The PCI_EXP_DPC_CAP_DL_ACTIVE bit which you check here indicates
> > that the port is capable of sending an ERR_COR interrupt whenever
> > the link transitions from inactive to active.
> > 
> > What is the connection to the PCI_EXP_LNKSTA_LT bit (which indicates
> > that the link is still being trained)?
> > 
> > Also, the negation of a bitwise AND is always either 0 or 1
> > (!(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)), so bit 0 is set or not set.
> > However PCI_EXP_LNKSTA_LT is bit 11.  A bitwise AND of bit 11 and 0 is
> > always 0, so the expression can never be 1.
> > 
> > Am I missing something?
> > 
> Please accept my sincere apologies for sending the wrong patch.
> 
> I am supposed to use PCI_EXP_LNKSTA_DLLLA bit in my patch but have used PCI_EXP_DPC_CAP_DL_ACTIVE.
> 
> The correct code should be as below,
> 
> -     if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
> +     if (((lnk_status & PCI_EXP_LNKSTA_LT) &
> +          !(lnk_status & PCI_EXP_LNKSTA_DLLLA )) ||
> 
> Is it right? please share your feedback, if I am wrong. Will send out V2 patch, once you confirm on this.

At least you are ignoring LKP valid warning...

-- 
With Best Regards,
Andy Shevchenko


