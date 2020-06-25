Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87720A354
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391047AbgFYQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 12:49:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391034AbgFYQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:49:46 -0400
Received: from zn.tnic (p200300ec2f0ed10035c3b797f40e07e6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:35c3:b797:f40e:7e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDEBB1EC0103;
        Thu, 25 Jun 2020 18:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593103785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zKr+xsUqnBWde4lQVzfFTLrVybIlx5wYc2zlELScPRY=;
        b=r7MZdWvF8Am0McUIxicQadDbNxJdFS4apYHLXB3T7MMSfuEKVUkid4VF66NPuJyu3HD0ZP
        LTBjVApGeJT0w2srFtQJupvVgLGJ7C6E35rrtk/gJ5X9SUtK8f/LaFrDCx0KioUapQDcsy
        mPZM9QDT+Kln2DmfG8lMRcpLES2pg5g=
Date:   Thu, 25 Jun 2020 18:49:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v33 03/21] x86/mm: x86/sgx: Signal SIGSEGV with PF_SGX
Message-ID: <20200625164939.GF20319@zn.tnic>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
 <20200617220844.57423-4-jarkko.sakkinen@linux.intel.com>
 <20200625085931.GB20319@zn.tnic>
 <20200625153431.GA3437@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625153431.GA3437@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:34:31AM -0700, Sean Christopherson wrote:
> However, building and running enclaves is complex, and the vast majority of
> SGX enabled applications are expected to leverage a library of one kind or
> another to hand the bulk of the gory details.

I gotta say this rings a bell: dhansen alluded on IRC to the jumping
through hoops one needs to do in order to run SGX enclaves.

...

> The vDSO stuff is in patches 15-18 of this series.
> 
> There's a gigantic thread on all the alternatives that were considered[2].
> 
> [1] https://lkml.kernel.org/r/CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com
> [2] https://lkml.kernel.org/r/CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com

Yeah, that makes it very clear. Thanks a lot for taking the time and
writing it down. I've snipped it for brevity but it is very useful!

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
