Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BE26D37A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIQGMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:12:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:12:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1053004ecb76e63d7beff7.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:4ecb:76e6:3d7b:eff7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2A281EC03A0;
        Thu, 17 Sep 2020 08:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600323143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wP5V6e8HmsuFSJFurli6pgsVa/P/4K0cBE0gZt2GKdg=;
        b=JI72fkmwMRbrq54ehWoY2a3ZyB+/C8UiyKOsg0ezkIRmtGglIS18JJBk8v4VdoryO59HRO
        bJ1hI3H9trJh7Do6eeI/iylDMBwFQ41FubrpshnX52CMKEFScXRDThXh2m0rN1ep9Ec+wr
        jNvainROYMCl52KqkAAQ4gUzHgJd1DY=
Date:   Thu, 17 Sep 2020 08:12:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
Message-ID: <20200917061220.GB31960@zn.tnic>
References: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Thu, Sep 17, 2020 at 09:12:18AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/pti
> branch HEAD: 767d46ab566dd489733666efe48732d523c8c332  Documentation: Add L1D flushing Documentation
> 
> Warning in current branch:
> 
> arch/x86/mm/tlb.c:426:36: sparse:     expected void const [noderef] __percpu *__vpp_verify
> arch/x86/mm/tlb.c:426:36: sparse:     got bool *
> arch/x86/mm/tlb.c:426:36: sparse: sparse: incorrect type in initializer (different address spaces)
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- i386-randconfig-s002-20200916
>     |-- arch-x86-mm-tlb.c:sparse:expected-void-const-noderef-__percpu-__vpp_verify
>     |-- arch-x86-mm-tlb.c:sparse:got-bool
>     `-- arch-x86-mm-tlb.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-const-noderef-__percpu-__vpp_verify-got-bool

this is another worthless bug report:

* No .config attached

* no build command line to know how you run sparse. I'm guessing with
C=1. But I should not have to guess.

Pls fix.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
