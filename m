Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2625F20A73F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 23:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbgFYVLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 17:11:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54600 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405671AbgFYVLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:11:13 -0400
Received: from zn.tnic (p200300ec2f0ed100d8d4e97d1105ac1f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d8d4:e97d:1105:ac1f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 599C51EC03D6;
        Thu, 25 Jun 2020 23:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593119472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3DIExf5rAnW8eXhQXfFMb3tWOLnXuwc7o5iylRGeRCc=;
        b=f0pi/Ukl91g6NwOyqSJ194l6gGGwJgNXN7GX/aJ/UNDmK3++sEMUyy28f3MZdk/pGKG5SW
        XChz0v2hK3HTKB+xhjv8Z2MkmvEaKRjLdotNW00jckivHfJb5MHMydZZn1MuAL+kBpnY3b
        THquaM5PPN1t6BjzLfCA3qeJpv02df0=
Date:   Thu, 25 Jun 2020 23:11:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Message-ID: <20200625211103.GR20319@zn.tnic>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
 <20200617220844.57423-4-jarkko.sakkinen@linux.intel.com>
 <20200625085931.GB20319@zn.tnic>
 <20200625205211.GC15394@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625205211.GC15394@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:52:11PM +0300, Jarkko Sakkinen wrote:
> I ended up with:
> 
>  *   bit 5 ==				1: protection keys block access
>  *   bit 6 ==				1: inside SGX enclave

You mean bit 15.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
