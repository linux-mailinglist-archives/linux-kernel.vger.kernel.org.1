Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B62FB6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbhASJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbhASJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:12:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1755C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:11:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00060d4a1f80a80a6a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:60d:4a1f:80a8:a6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BC731EC0595;
        Tue, 19 Jan 2021 10:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611047483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xG66aDFJtNpW4iGBKuUs8rPliTKzmq7slPAVAkozqBU=;
        b=qaOXaQk5XuvxJ0/Krw4SPaY5ZHZ4Yrp1YpVvvKCeac2uw31pf8IZcHg2ACyJiDLAgXwwd/
        s8CBFH2IFxm259uMALmtHpIrLvIXb9Pvu0pscNktF28vhjwQEKbZMxk0WdXcJNWMvSSDIV
        K7Y2W6/WE1YSZw8PBBLwld/xlPygSg8=
Date:   Tue, 19 Jan 2021 10:11:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH v4] tools/x86: Add a kcpuid tool to show raw CPU features
Message-ID: <20210119091116.GA27433@zn.tnic>
References: <1610955311-77910-1-git-send-email-feng.tang@intel.com>
 <20210119051942.GA87207@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119051942.GA87207@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 01:19:42PM +0800, Feng Tang wrote:
> Sorry, after testing on more platforms, the following is needed to fix
> a potential array overflow ((a full patch with fix is also attached)
> 
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> index 3ea607b..bf68335 100644
> --- a/tools/arch/x86/kcpuid/kcpuid.c
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -329,7 +329,8 @@ static int parse_line(char *line)
>  		range = leafs_basic;
>  
>  	index &= 0x7FFFFFFF;
> -	if ((int)index > range->nr)
> +	/* range->nr equals to max index plus 1 */
> +	if ((int)index >= range->nr)

That comment is basically repeating the code. What it should do is
explain *why* that test is being done or not be there at all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
