Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9E1F6D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgFKS23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:28:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:17772 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgFKS22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:28:28 -0400
IronPort-SDR: ExWz34cRT2QhdMCHv6z2p+a+dRy/GnI+3sxDe7BY/qawseuUQvYiYaqyUj6Rs5k1tPsRlvZYqV
 tpGiFOMIyDHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 11:28:28 -0700
IronPort-SDR: wQt5M7ODhWPUc1cX5GWjc98u1g5OaERp+mmdzi72cej5QxlbN73+yiBuIwzO1ENY4Jx7o2+Gxe
 1mlge1L86x4A==
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="307040528"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 11:28:28 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 3BD276367;
        Thu, 11 Jun 2020 18:28:27 +0000 (UTC)
Date:   Thu, 11 Jun 2020 11:28:27 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] docs: hw-vuln: SRBDS: Fix "Title underline too short"
 warnings during build
Message-ID: <20200611182827.GB29107@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200609202856.2283975-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609202856.2283975-1-carnil@debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack
Signed-off-by:Mark Gross<mgross@linux.intel.com>

Thanks!

--mark



On Tue, Jun 09, 2020 at 10:28:56PM +0200, Salvatore Bonaccorso wrote:
> Some of the title underlining did not have the correct length causing a few
> warnings when building the htmldocs. Line up each of the title underlinings
> with the text they are under.
> 
> Fixes: 7222a1b5b874 ("x86/speculation: Add SRBDS vulnerability and mitigation documentation")
> Cc: Mark Gross <mgross@linux.intel.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: trivial@kernel.org
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  .../hw-vuln/special-register-buffer-data-sampling.rst       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> index 47b1b3afac99..3b1ce68d2456 100644
> --- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> +++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> @@ -14,7 +14,7 @@ to the core through the special register mechanism that is susceptible
>  to MDS attacks.
>  
>  Affected processors
> ---------------------
> +-------------------
>  Core models (desktop, mobile, Xeon-E3) that implement RDRAND and/or RDSEED may
>  be affected.
>  
> @@ -59,7 +59,7 @@ executed on another core or sibling thread using MDS techniques.
>  
>  
>  Mitigation mechanism
> --------------------
> +--------------------
>  Intel will release microcode updates that modify the RDRAND, RDSEED, and
>  EGETKEY instructions to overwrite secret special register data in the shared
>  staging buffer before the secret data can be accessed by another logical
> @@ -118,7 +118,7 @@ with the option "srbds=".  The option for this is:
>    ============= =============================================================
>  
>  SRBDS System Information
> ------------------------
> +------------------------
>  The Linux kernel provides vulnerability status information through sysfs.  For
>  SRBDS this can be accessed by the following sysfs file:
>  /sys/devices/system/cpu/vulnerabilities/srbds
> -- 
> 2.27.0
> 
