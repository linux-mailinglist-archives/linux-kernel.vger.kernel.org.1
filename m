Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7812B56B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKQCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:22:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:44728 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgKQCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:22:44 -0500
IronPort-SDR: aMYa4t9TkdTWbGXd7AvgbW/mwohYUSBYurSRzx5g/a6dkKEyBrgp0LCRmeaNwjUaA1qz0128qC
 cBRI0RBfWWBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171019823"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="171019823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:22:43 -0800
IronPort-SDR: rnWeFILlHT4o7cLSEHwmEZ151Cp1cb+Rfxgi1BQV1L8Jh5xPl9zo//ipZYt4ZOLU4lj2EgZFBp
 uc6YBs9TDGLQ==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="543844106"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:22:40 -0800
Date:   Tue, 17 Nov 2020 10:25:18 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ashok Raj <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201117022518.GA17555@chenyu-office.sh.intel.com>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
 <20201116122735.GA1131@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116122735.GA1131@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,
thanks for taking a look,
On Mon, Nov 16, 2020 at 01:27:35PM +0100, Borislav Petkov wrote:
> ( drop stable@ from Cc because this is not how fixes get added to stable@ )
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
This patch works for me. Besides I have one question about adding the
signature check in save_mc_for_early():
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
If I understand correctly, the only place that invokes save_mc_for_early()
is in generic_load_microcode(). While in generic_load_microcode() only
microcode has a newer version will be saved by checking has_newer_microcode(),
and this function leverages find_matching_signature() to check if the candidate
is of the same signature. So when it comes to save_microcode_patch(), the signature
already matches. In case save_mc_for_early() will be invoked by other
function in the future, it is okay to add this check too.

thanks,
Chenyu

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
