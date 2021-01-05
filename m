Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398972EAEBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbhAEPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:36:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:61013 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbhAEPgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:36:46 -0500
IronPort-SDR: 7Brgp6sAcyF5bX25zqusiNjJlIV0Glrg92zEVFhafyUhcsxAbkOe5IfVXQjoEkVSRfNyS72rle
 ZKpVEr6Q00RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="177276452"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="177276452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 07:36:05 -0800
IronPort-SDR: xEZhFXKKXLG3R5DDzLiI2mVworipatgOAxJ5Cgg//xD0r9N5Oybu1Ol78tnUjoYBHdalLJunZH
 028g4FB+kFHA==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="350417007"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 07:36:05 -0800
Date:   Tue, 5 Jan 2021 07:36:03 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: fix xchg() warning
Message-ID: <20210105153603.GA17644@agluck-desk2.amr.corp.intel.com>
References: <20210104085806.4176886-1-arnd@kernel.org>
 <ad54481b-15da-e795-0c1a-bd54d3e8ab87@physik.fu-berlin.de>
 <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com>
 <71274a7cdf7d48bf9c2fda873fa37727@intel.com>
 <CAK8P3a2KhaEZ-ErAXGi0wOr_z2YT-GUV7r5QMhUoV+e+tpc5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2KhaEZ-ErAXGi0wOr_z2YT-GUV7r5QMhUoV+e+tpc5zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:17:41PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 4, 2021 at 5:00 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > I have not received any reply from the ia64 maintainers, I assume they were
> > > both out of office for Christmas.
> >
> > I'm back in the office ... but have no working ia64 machines, nor time to look at patches :-(
> >
> > Should drop me from the MAINTAINTERS file.
> 
> If you like, I can apply the patch below and take that through my
> asm-generic tree along with the two bug fixes I sent:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f2e55faaf7f..b74093803154 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8432,11 +8432,8 @@ F: drivers/i3c/
>  F: include/linux/i3c/
> 
>  IA64 (Itanium) PLATFORM
> -M: Tony Luck <tony.luck@intel.com>
> -M: Fenghua Yu <fenghua.yu@intel.com>
>  L: linux-ia64@vger.kernel.org
> -S: Odd Fixes
> -T: git git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
> +S: Orphan
>  F: Documentation/ia64/
>  F: arch/ia64/
> 
> Is that what you had in mind? I see that Fenghua Yu has not been
> actively involved for a long time. If you are both out, that would
> make the port unmaintained, but that may actually help find someone
> else to either volunteer as a maintainer or pay someone if they
> have a commercial interest.

Yes. Fenghua has moved to working on other things, so that looks good.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
