Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0911C1E57ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE1Gx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 02:53:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:23208 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE1Gx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:53:27 -0400
IronPort-SDR: NNwGzALuLadW46pYPgXiwVTJiHBFuRKVkx/orZqhK6vh1Aqhz4qIVjBUESS3meItjAuoy6mufm
 RTTjkHJE1r9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 23:53:26 -0700
IronPort-SDR: cSjsHPnMl5vLuW8G07ZkXD/BD6WGOI6Ax5qbqEpy415U8PtCxcSPIVqf9U9nXFtrsAXn9ogjz6
 FyYEI5sKHMqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="267116960"
Received: from dmescala-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.59.102])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 23:53:20 -0700
Date:   Thu, 28 May 2020 09:53:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     James.Bottomley@HansenPartnership.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrin@rajagiritech.edu.in, alex@guzman.io
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Message-ID: <20200528065318.GC188849@linux.intel.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
 <1590521924.15108.1.camel@HansenPartnership.com>
 <37da2695fe6de09d69e27b77f3e29e068596205f.camel@linux.intel.com>
 <4d1a53596af44c7b84f97aa4ce04a53c@AUSX13MPC105.AMER.DELL.COM>
 <20200528004355.GA5877@linux.intel.com>
 <7072116bf16a45bca62913e7d8a0354e@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7072116bf16a45bca62913e7d8a0354e@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:59:59AM +0000, Mario.Limonciello@dell.com wrote:
> > > > [EXTERNAL EMAIL]
> > 
> > What is this?
> 
> Something my employer's mail system automatically tags in external email.
> 
> My mistakes in forgetting to remove it on the response.

NP, just asking :-)

> > > > On Tue, 2020-05-26 at 12:38 -0700, James Bottomley wrote:
> > > > > On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > > > > > > On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> > > > > > > > This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> > > > > > > >
> > > > > > > > This commit has caused regressions for the XPS 9560 containing
> > > > > > > > a Nuvoton TPM.
> > > > > > >
> > > > > > > Presumably this is using the tis driver?
> > > > > >
> > > > > > Correct.
> > > > > >
> > > > > > > > As mentioned by the reporter all TPM2 commands are failing with:
> > > > > > > >   ERROR:tcti:src/tss2-tcti/tcti-
> > > > > > > > device.c:290:tcti_device_receive()
> > > > > > > >   Failed to read response from fd 3, got errno 1: Operation not
> > > > > > > > permitted
> > > > > > > >
> > > > > > > > The reporter bisected this issue back to this commit which was
> > > > > > > > backported to stable as commit 4d6ebc4.
> > > > > > >
> > > > > > > I think the problem is request_locality ... for some inexplicable
> > > > > > > reason a failure there returns -1, which is EPERM to user space.
> > > > > > >
> > > > > > > That seems to be a bug in the async code since everything else
> > > > > > > gives a ESPIPE error if tpm_try_get_ops fails ... at least no-one
> > > > > > > assumes it gives back a sensible return code.
> > > > > > >
> > > > > > > What I think is happening is that with the patch the TPM goes
> > > > > > > through a quick sequence of request, relinquish, request,
> > > > > > > relinquish and it's the third request which is failing (likely
> > > > > > > timing out).  Without the patch, the patch there's only one
> > > > > > > request,relinquish cycle because the ops are held while the async
> > > > > > > work is executed.  I have a vague recollection that there is a
> > > > > > > problem with too many locality request in quick succession, but
> > > > > > > I'll defer to Jason, who I think understands the intricacies of
> > > > > > > localities better than I do.
> > > > > >
> > > > > > Thanks, I don't pretend to understand the nuances of this particular
> > > > > > code, but I was hoping that the request to revert got some attention
> > > > > > since Alex's kernel Bugzilla and message a few months ago to linux
> > > > > > integrity weren't.
> > > > > >
> > > > > > > If that's the problem, the solution looks simple enough: just move
> > > > > > > the ops get down because the priv state is already protected by the
> > > > > > > buffer mutex
> > > > > >
> > > > > > Yeah, if that works for Alex's situation it certainly sounds like a
> > > > > > better solution than reverting this patch as this patch actually does
> > > > > > fix a problem reported by Jeffrin originally.
> > > > > >
> > > > > > Could you propose a specific patch that Alex and Jeffrin can perhaps
> > > > > > both try?
> > > > >
> > > > > Um, what's wrong with the one I originally attached and which you quote
> > > > > below?  It's only compile tested, but I think it will work, if the
> > > > > theory is correct.
> > > >
> > > > Please send a legit patch, thanks.
> > > >
> > > > /Jarkko
> > >
> > > Jarkko,
> > >
> > > After the confirmation from Alex that this patch attached to the end of the
> > thread
> > > worked, James did send a proper patch that can be accessed here:
> > > https://lore.kernel.org/linux-
> > integrity/20200527155800.ya43xm2ltuwduwjg@cantor/T/#t
> > >
> > > Thanks,
> > 
> > Hi thanks a lot! I did read the full discussions and agree with the
> > conclusions as I get a patch in proper form.
> > 
> > Please ping next time a bit earlier. It's not that I don't want to deal
> > with the issues quickly as possible. It's probably just that I've forgot
> > something or missed.
> > 
> > /Jarkko
> 
> Thanks!
> 
> I completely forgot about it too, it was mentioned to me right after holidays
> and I forgot to follow up and see that it got sorted.

Yeah, sure, lets try to get a fix landed asap :-)

/Jarkko
