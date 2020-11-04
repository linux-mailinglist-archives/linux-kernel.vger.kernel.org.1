Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954AF2A6DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgKDTND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:13:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4661C0613D3;
        Wed,  4 Nov 2020 11:13:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ef400317dde2deb3fed11.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f400:317d:de2d:eb3f:ed11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9BED1EC03C1;
        Wed,  4 Nov 2020 20:12:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604517178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vVu9csKhteKU6kae0FPak6xIIsJyL2Kx45JkmeXH8g8=;
        b=mXo2/W+n3XEaxyD7bx01mlXyFyvteJhnhSzpFN4WqJqcK9VtkwDMVKssnxEfcxr0IO6wM/
        ZF9GwShYI8q58lBrhm+NEehHE6AsBLhQ0N2fXLwWf7bg71p4l54B3Y0ERtYC9H/KOfhKVh
        uGrAG8lzmdZ4k9ZSHt3PV5F8VWiimyo=
Date:   Wed, 4 Nov 2020 20:12:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Serge Ayoun <serge.ayoun@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v40 03/24] x86/sgx: Initialize metadata for Enclave Page
 Cache (EPC) sections
Message-ID: <20201104191252.GF23298@zn.tnic>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
 <20201104145430.300542-4-jarkko.sakkinen@linux.intel.com>
 <20201104182129.GD23298@zn.tnic>
 <20201104190443.GA318315@kernel.org>
 <20201104190903.GA304537@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104190903.GA304537@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:09:03PM +0200, Jarkko Sakkinen wrote:
> If you want, I can do a resend of this version same time underlining
> that this the only difference and I do have a framework to check this
> thing in place.

No need - I'll simply reorder them here and see how far I'd get.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
