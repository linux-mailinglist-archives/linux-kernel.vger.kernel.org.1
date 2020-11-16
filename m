Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A22B53D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgKPVag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:30:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:60550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgKPVag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:30:36 -0500
IronPort-SDR: fbzVzJPh71d24eMHaY6krkcgoV5kxc2154mao955jsNNq1QY/gVe45gpmCiuPcEbw4kkrgzYGL
 o5EN/mjgPsDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158594019"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="158594019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 13:30:21 -0800
IronPort-SDR: nYvSDaJbDRJyoLEJ6aQ61vfzzlpFBHHD4PSUhCZg66AKhOnVsH+pggjhEXWSmrEHKXizkel/rk
 u8U1GBMTtTqw==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="543755912"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 13:30:21 -0800
Date:   Mon, 16 Nov 2020 13:30:19 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201116213019.GB76389@otc-nc-03>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
 <20201116122735.GA1131@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116122735.GA1131@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Mon, Nov 16, 2020 at 01:27:35PM +0100, Borislav Petkov wrote:
> ( drop stable@ from Cc because this is not how fixes get added to stable@ )

Stable is still left below. with #v4.10+

Do you want to keep this? Also do you want him to resend or you have that
covered?

> 
> On Fri, Nov 13, 2020 at 09:59:23AM +0800, Chen Yu wrote:
> > Currently scan_microcode() leverages microcode_matches() to check if the
> > microcode matches the CPU by comparing the family and model. However before
> > saving the microcode in scan_microcode(), the processor stepping and flag
> > of the microcode signature should also be considered in order to avoid
> > incompatible update and caused the failure of microcode update.
> 
> This is going in the right direction but needs to take care of one
> more angle. I've extended your fix to the version below. Lemme know if
> something's not clear or still missing.
> 

Seems clear to me, and the commit log cleanup also makes sense.
I don't have a system myself,. Will wait for Chen Yu to confirm if it works
for him as well. 

> Thx.
> 
> ---
> From: Chen Yu <yu.c.chen@intel.com>
> Date: Fri, 13 Nov 2020 09:59:23 +0800
> Subject: [PATCH] x86/microcode/intel: Check patch signature before saving microcode for early loading
> 
> Currently, scan_microcode() leverages microcode_matches() to check
> if the microcode matches the CPU by comparing the family and model.
> However, the processor stepping and flags of the microcode signature
> should also be considered when saving a microcode patch for early
> update.
> 
> Use find_matching_signature() in scan_microcode() and get rid of the
> now-unused microcode_matches() which is a good cleanup in itself.
> 
> Complete the verification of the patch being saved for early loading in
> save_microcode_patch() directly. This needs to be done there too because
> save_mc_for_early() will call save_microcode_patch() too.
> 
> The second reason why this needs to be done is because the loader still
> tries to support, at least hypothetically, mixed-steppings systems and
> thus adds all patches to the cache that belong to the same CPU model
> albeit with different steppings.
> 
> For example:
> 
>   microcode: CPU: sig=0x906ec, pf=0x2, rev=0xd6
>   microcode: mc_saved[0]: sig=0x906e9, pf=0x2a, rev=0xd6, total size=0x19400, date = 2020-04-23
>   microcode: mc_saved[1]: sig=0x906ea, pf=0x22, rev=0xd6, total size=0x19000, date = 2020-04-27
>   microcode: mc_saved[2]: sig=0x906eb, pf=0x2, rev=0xd6, total size=0x19400, date = 2020-04-23
>   microcode: mc_saved[3]: sig=0x906ec, pf=0x22, rev=0xd6, total size=0x19000, date = 2020-04-27
>   microcode: mc_saved[4]: sig=0x906ed, pf=0x22, rev=0xd6, total size=0x19400, date = 2020-04-23
> 
> The patch which is being saved for early loading, however, can only be
> the one which fits the CPU this runs on so do the signature verification
> before saving.
> 
>  [ bp: Do signature verification in save_microcode_patch()
>        and rewrite commit message. ]
> 
> Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: stable@vger.kernel.org #v4.10+
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=208535
> Link: https://lkml.kernel.org/r/20201113015923.13960-1-yu.c.chen@intel.com
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 63 +++++----------------------
>  1 file changed, 10 insertions(+), 53 deletions(-)
