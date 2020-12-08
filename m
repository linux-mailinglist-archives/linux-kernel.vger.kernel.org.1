Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BFA2D2A00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgLHLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLHLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:53:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB310C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 03:52:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f080075ab11bb2325b51a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:75ab:11bb:2325:b51a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E8481EC04DF;
        Tue,  8 Dec 2020 12:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607428374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ilCcr2hsaww+8WtUZm8dpe2+ao20Xeo/UcCyN6Gb//4=;
        b=ZmRzOQIdQKqDh10l00y9zQ1fVIbW+W4oZqGIJxLY7iEBXLo1AkfGzfMMLByL3rvWleR8kb
        VpCa2H79kaU1ClF3j5EkBbkfNRzecfF77bLe4ckhKW6u2GQbFK59ruSJykpGGC+CBeB35A
        NA9fxYS1GaN7CQ1hZ/fIjPvMM82Pg3w=
Date:   Tue, 8 Dec 2020 12:52:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 01/18] docs: acrn: Introduce ACRN
Message-ID: <20201208115249.GC27920@zn.tnic>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-2-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201093853.12070-2-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:38:36PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> Add documentation on the following aspects of ACRN:

Thanks for doing this!

> +===============
> +ACRN CPUID bits
> +===============
> +
> +A guest VM running on an ACRN hypervisor, can check some of its features using
> +cpuid.

s/cpuid/CPUID/g

> +ACRN Hypervisor Introduction
> +============================
> +
> +The ACRN Hypervisor is a Type 1 hypervisor, running directly on the bare-metal

s/the //

with those fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
