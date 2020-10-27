Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2229C507
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824099AbgJ0SC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:02:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:40536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1824089AbgJ0SC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:02:56 -0400
IronPort-SDR: fG2kpTDRvhUgGQRRSL7cqEjF5wu5yUfgIKkg/Ky4iEkFurob2FK4MzRTB/OHC1RrfbrTB80vuS
 0mnNgXc+6+iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="185881900"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="185881900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 11:02:56 -0700
IronPort-SDR: QB8xWuYDPJkJLrHinQCkNshLxzUHA69VnRYfRqjmBDDg1rJX8/nrDg7hrkmKbZHqhCfn4FdZ0h
 BF2Gc3fmdqxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="350685982"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2020 11:02:56 -0700
Date:   Tue, 27 Oct 2020 18:02:56 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/resctrl: Correct MBM total and local values
Message-ID: <20201027180256.GA3478584@otcwcpicx6.sc.intel.com>
References: <20201014004927.1839452-1-fenghua.yu@intel.com>
 <20201014004927.1839452-3-fenghua.yu@intel.com>
 <20201027175748.GJ15580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027175748.GJ15580@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Tue, Oct 27, 2020 at 06:57:48PM +0100, Borislav Petkov wrote:
> On Wed, Oct 14, 2020 at 12:49:27AM +0000, Fenghua Yu wrote:
> > +static const struct mbm_correction_factor_table {
> > +	u32 rmidthreshold;
> > +	u64 cf;
> > +} mbm_cf_table[] = {
> 
> That thing wants to be __initdata, AFAICT, since the only function
> touching it is __init.
> 
> Made it so.

You are right. The correction value is read from this table only
once in __init. So this table should be __initdata.

Thank you very much for your review!

-Fenghua
