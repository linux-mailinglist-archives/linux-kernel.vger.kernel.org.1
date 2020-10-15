Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120AF28F58B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbgJOPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:08:54 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:4136 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388764AbgJOPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602774533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83CI7dEo4abtDvi3SxA31wt2De+c17XHCkaW0cRBP4E=;
  b=PPueg4XnCasWC/tkgYGDl259eKePZvAalOCP9IxyU1cj/aM+Nqks3Nnh
   yW0eP7R2uiQgRENqEbT+hhCMXDoGka1NrfRz+YYyL8gdJWwPX8HWC0XS3
   PHQl8VoL2rm0Rnr3Ocjl/tKlOpPwFktEjVKdTq+4QKAASD6DmZxEJz/YN
   Y=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: CjATV4Crrjol+n6HDirYBQsJMKcs7EyyWxNtiTk9h6eDIAlG6bdANvubnE/XRTJVY6tSS7bhhy
 CFUPRJ66GqBhVAau//zD8/EEAezobQHNRhXbyJN7D3J/SOUKqAorBdb+kR6InWVMOUK7zygELd
 wesJe14tWMEj5Qbkb2AaBJo2zq75S6QMpvJEDvZW4VE+cbl7RWTdSuJcNHl96WXz3Ixil7KYkK
 TvtRUO2KWXZQbGt9uSF9kaILv3XOFqkPPUaxQvgNB7K6Bj5n3KJyR/5TBcPXLSiAceyVLz8qsL
 0DY=
X-SBRS: 2.5
X-MesageID: 29067109
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="29067109"
Date:   Thu, 15 Oct 2020 17:08:44 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
CC:     Jason Andryuk <jandryuk@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] xen: Remove Xen PVH/PVHVM dependency on PCI
Message-ID: <20201015150844.GF68032@Air-de-Roger>
References: <20201014175342.152712-1-jandryuk@gmail.com>
 <20201014175342.152712-2-jandryuk@gmail.com>
 <b74a3f83-cd8a-34a3-b436-95141f01cb20@suse.com>
 <CAKf6xps+mAFdfk8uBw=aMsAFNYmt4ETPkB8dwT3sTv-qPbVENw@mail.gmail.com>
 <3919ef15-379b-cc1e-994c-c33b23865afd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3919ef15-379b-cc1e-994c-c33b23865afd@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 05:02:21PM +0200, Jan Beulich wrote:
> On 15.10.2020 16:59, Jason Andryuk wrote:
> > On Thu, Oct 15, 2020 at 4:10 AM Jan Beulich <jbeulich@suse.com> wrote:
> >>
> >> On 14.10.2020 19:53, Jason Andryuk wrote:
> >>> @@ -76,7 +80,9 @@ config XEN_DEBUG_FS
> >>>         Enabling this option may incur a significant performance overhead.
> >>>
> >>>  config XEN_PVH
> >>> -     bool "Support for running as a Xen PVH guest"
> >>> +     bool "Xen PVH guest support"
> >>
> >> Tangential question: Is "guest" here still appropriate, i.e.
> >> isn't this option also controlling whether the kernel can be
> >> used in a PVH Dom0?
> > 
> > Would you like something more generic like "Xen PVH support" and
> > "Support for running in Xen PVH mode"?
> 
> Yeah, just dropping "guest" would be fine with me. No idea how
> to reflect that PVH Dom0 isn't supported, yet.

The fact that it isn't supported by Xen shouldn't be reflected on the
Linux configuration, as it's independent. Ie: you could run this Linux
kernel on a future version of Xen where PVH dom0 is supported.

There's already a warning printed by Xen when booting PVH dom0 about
not being a supported mode.

Thanks, Roger.
