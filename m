Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778C328E791
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJNT4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:56:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNT4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:56:24 -0400
Received: from zn.tnic (p200300ec2f0c4400a8a63b86eef17592.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:4400:a8a6:3b86:eef1:7592])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D459E1EC0493;
        Wed, 14 Oct 2020 21:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602705383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kRhOfW32b0y55S8bP4pZaw8i53srY+meEMHsyHTonbQ=;
        b=rQa3QO0OIFdfmh14RpHCz+2MO2wmrwcAVseqnjcbTbZYLJR2OydUVQ0ZXx/QDMUG6FE1X4
        AWT7XpgUlG94HWu20GZJRPMYLoGI6a3Fg0raNAFpBnkl3VIcIGBNk6zLf9CRNEgXfsW+QB
        oiGO7DH/3vHhksVtmdEUDM0zvJAirzE=
Date:   Wed, 14 Oct 2020 21:56:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/8] x86/asm: add clear_page_nt()
Message-ID: <20201014195614.GB18196@zn.tnic>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-5-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014083300.19077-5-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 01:32:55AM -0700, Ankur Arora wrote:
> This can potentially improve page-clearing bandwidth (see below for
> performance numbers for two microarchitectures where it helps and one
> where it doesn't) and can help indirectly by consuming less cache
> resources.
> 
> Any performance benefits are expected for extents larger than LLC-sized
> or more -- when we are DRAM-BW constrained rather than cache-BW
> constrained.

"potentially", "expected", I don't like those formulations. Do you have
some actual benchmark data where this shows any improvement and not
microbenchmarks only, to warrant the additional complexity?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
