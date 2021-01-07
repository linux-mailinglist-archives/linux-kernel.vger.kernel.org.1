Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33972ED070
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbhAGNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbhAGNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:14:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E83C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 05:13:54 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e34002eff7511bba3cf4e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:2eff:7511:bba3:cf4e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42C191EC04CC;
        Thu,  7 Jan 2021 14:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610025232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1cAMdYV0mgJMk3XU71CqEQ8vD2W+hlB/hvTiTo8FAyk=;
        b=RW3iXTO5ixT8uTo67NXE/TVhrzGnuFF4BV60eHuE6fhT2qlbViY6tV/lZ6GhgSmJZqbUac
        zuYWBpm7oiabA/HEGpdZIdsjhrsE0XxQFBg3fQGGhXnfpxlbV8cS98WAkzssEIr3M4jYw8
        7AeFzsnCYTz4Zyvv4/hKO5yfLnOeVOc=
Date:   Thu, 7 Jan 2021 14:13:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: Re: [RFC][PATCH 6/6] x86/mce: Dont use noinstr for now
Message-ID: <20210107131349.GH14697@zn.tnic>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.779081583@infradead.org>
 <8B866DA6-ED68-4681-8D83-A23E8F18E77C@alien8.de>
 <20210107100626.GG14697@zn.tnic>
 <X/cFbZVSFXLuj40Q@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/cFbZVSFXLuj40Q@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:58:21PM +0100, Peter Zijlstra wrote:
> ifdef CONFIG_FUNCTION_TRACER
> CFLAGS_REMOVE_core_instr.o = $(CC_FLAGS_FTRACE)
> endif

Ah, looks familiar, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
