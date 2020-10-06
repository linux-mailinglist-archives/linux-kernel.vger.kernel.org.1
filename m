Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640D62854F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJFXh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:37:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:65481 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFXh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:37:56 -0400
IronPort-SDR: XVLlThjHP0yoJ7r8uczGsumcqtxo9pb17EJAEuXeTSZIATbMACDpnCdi1jq+VUK7SNzzVv4x1b
 2VpNYDjZML9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161357127"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="161357127"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 16:37:55 -0700
IronPort-SDR: JA9MIm9UlcL04BLq488pv8K14hgdNZRi1A3yQwwACiAR5IlBV9cWWL186SdS6jYG8ee+ZHWinf
 1C5XaFwuLHRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="342577992"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2020 16:37:55 -0700
Date:   Tue, 6 Oct 2020 23:37:55 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Correct MBM total and local values
Message-ID: <20201006233755.GA1421920@otcwcpicx6.sc.intel.com>
References: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
 <20201005093506.GB21151@zn.tnic>
 <20201006004348.GA1415745@otcwcpicx6.sc.intel.com>
 <20201006160056.GG27700@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006160056.GG27700@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Tue, Oct 06, 2020 at 06:00:56PM +0200, Borislav Petkov wrote:
> On Tue, Oct 06, 2020 at 12:43:48AM +0000, Fenghua Yu wrote:
> > I keep this original table here for two reasons:
> > 1. It's an original table that can be tracked by any one in the future.
> >    If I don't list the original table here, others may wonder where I
> >    get the converted table from.
> 
> If you wanna document it then put that table in
> Documentation/x86/resctrl_ui.rst.
> 
> Before you put it there, you can rename that file to
> 
> Documentation/x86/resctrl.rst
> 
> because after that change, it won't contain UI documentation only
> anymore.
> 
> Commit messages tend to become hard to dig out in the future, when a lot
> of patches accumulate ontop. Even more so if someone renames files so if
> you really need to document something, you can either put it a comment
> over the code where it is used, or if it is something bigger as this
> table, you can put it in Documentation/ and refer to it in the code.

Sure. I will put the correction table in resctrl.rst.

> 
> > Ok. I will describe the problem in the commit message.
> 
> Just paste the erratum text. That's it - it is small enough.

Sure. I will do that.

Thank you very much for your review!

-Fenghua
