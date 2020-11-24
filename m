Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC642C20A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgKXJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgKXJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:01:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:01:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e3600a9cb1df0e98d070c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:a9cb:1df0:e98d:70c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EB881EC04DF;
        Tue, 24 Nov 2020 10:01:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606208460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=spuCTuobFwZYtpYYd4DV2fwHDk1geO/8cruVmOCIaH0=;
        b=fj3ptSS1GtXsvj+p8OhlpnW/U9DSzWgcspkEvxrdmT29kMCqUlsSIez4hyxYY0SZw7LX/z
        4yAaVBGc6siRwnUFXzcYgN4RqqvaO3Rmtt6RdnKKSSd40K8B+OPuBSjxCvic3UJo9603rU
        M62U9inbR4ckew8vrSFeasWEjqAIMoU=
Date:   Tue, 24 Nov 2020 10:00:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124090055.GB4009@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123180215.GG15044@zn.tnic>
 <20201123184327.GA22269@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123184327.GA22269@char.us.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 01:43:27PM -0500, Konrad Rzeszutek Wilk wrote:
> I am assuming that TDX is going to have the same exact issue that 
> AMD SEV will have.
> 
> Are you recommending to have an unified x86 specific callback
> where we check if it:
> 
>  - CPUID_AMD_SEV or CPUID_INTEL_TDX is set, and
>  - No vIOMMU present, then we adjust the size?

I'm thinking do it correct right now and when TDX appears on the horizon
requesting this adjusted to TDX, then change it. Like we always do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
