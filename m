Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E963D213030
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgGBXi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 19:38:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:23278 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBXi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:38:29 -0400
IronPort-SDR: 7OHRaxU5/Xcx9PJiew+J/Pt4rvvs6wDY6R04kryZnZS0i0qTfvqC1MWDz2ETkt8720ZToBseMz
 RguqmXQrrEdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="127143841"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="127143841"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 16:38:29 -0700
IronPort-SDR: R7qtgIdD+8x4AgJAXlJishfVhDQlpMuzDCNzs0lpcUKlpGG0Iqoy50SkIK5OaZgag591grFZjG
 IsMvYSztU5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="267205271"
Received: from chadjitt-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.125])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2020 16:38:24 -0700
Date:   Fri, 3 Jul 2020 02:38:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200702233823.GH31291@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
 <20200625211923.2jirvix6zbrbgj6e@cantor>
 <20200626130851.GA7853@linux.intel.com>
 <20200630191515.m3hi6gmn4ya7hvji@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630191515.m3hi6gmn4ya7hvji@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:15:15PM -0700, Jerry Snitselaar wrote:
> On Fri Jun 26 20, Jarkko Sakkinen wrote:
> > On Thu, Jun 25, 2020 at 02:19:23PM -0700, Jerry Snitselaar wrote:
> > > On Fri Jun 26 20, Jarkko Sakkinen wrote:
> > > > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
> > > > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
> > > > > > Acer C720 running Linux v5.3 reports this in klog:
> > > > > >
> > > > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > > > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
> > > > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > > > > > tpm_tis 00:08: Could not get TPM timeouts and durations
> > > > > > ima: No TPM chip found, activating TPM-bypass!
> > > > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> > > > > >
> > > > > > % git --no-pager grep IFX0102 drivers/char/tpm
> > > > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > > > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> > > > > >
> > > > > > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
> > > > > > mistake.
> > > > > >
> > > > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> > > > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > > > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> > > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > >
> > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > >
> > > > Bugzilla has an example of similar behavior with v4.15. I'll apply this
> > > > asap.
> > > >
> > > > /Jarkko
> > > >
> > > 
> > > Any idea what happened to git.infradead.org? It was offline the other day,
> > > and at the moment not all repos from before seem to be there.
> > 
> > Now the kernel tree is back online.
> > 
> > /Jarkko
> > 
> 
> Hi Jarkko, I still see your linux-tpmdd repository as not being online:
> 
> git remote show tpmdd
> fatal: remote error: access denied or repository not exported: /users/jjs/linux-tpmdd.git
> 
> Regards,
> Jerry

It's now fixed and back online again.

/Jarkko
