Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC11DB320
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgETMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:23:49 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 05:23:48 PDT
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABEC061A0E;
        Wed, 20 May 2020 05:23:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bab004cc75e27543cdd50.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:4cc7:5e27:543c:dd50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AF6B1EC0350;
        Wed, 20 May 2020 14:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589977427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=//xodGP6uhFG6vU7T1NA0Z0VRMEbIPWTE05pu4xOSHw=;
        b=Z3mDLMae+SBhuHDz3MH6XaBIXV3Z3AICO3CSsw5YVT2SEpD9en5Fi+CVeIzJwpfE/srKCG
        X8+WxIcver1ZCVgH6Vlx3Gahwaz/nQcUzCRloGKHrrOy75HP07Y+RG5zaOX0sob1MZcJKB
        wy/cYXXDul93QgDM9UPYdvYzGo4sILI=
Date:   Wed, 20 May 2020 14:23:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 02/20] x86/cpufeatures: x86/msr: Intel SGX Launch
 Control hardware bits
Message-ID: <20200520122346.GG1457@zn.tnic>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515004410.723949-3-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH v30 02/20] x86/cpufeatures: x86/msr: Intel SGX Launch Control hardware bits
							  ^
							Add

Needs a verb.

On Fri, May 15, 2020 at 03:43:52AM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add X86_FEATURE_SGX_LC, which informs whether or not the CPU supports SGX
> Launch Control.
> 
> Add MSR_IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}, which when combined contain a
> SHA256 hash of a 3072-bit RSA public key. SGX backed software packages, so
> called enclaves, are always signed. All enclaves signed with the public key
> are unconditionally allowed to initialize. [1]
> 
> Add FEATURE_CONTROL_SGX_LE_WR bit of the feature control MSR, which informs
> whether the formentioned MSRs are writable or not. If the bit is off, the

"aforementioned"

> public key MSRs are read-only for the OS.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
