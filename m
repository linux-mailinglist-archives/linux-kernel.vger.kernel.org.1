Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1E2ECB54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbhAGH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAGH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:56:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F8C0612F4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 23:55:37 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e340040aa7c2c4e2416a1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:40aa:7c2c:4e24:16a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF93F1EC04CC;
        Thu,  7 Jan 2021 08:55:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610006135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sW6hm87b5oW8k6oqUpJtDBoftUKMU0GFZ/lyl9nnYg0=;
        b=Xvz8Mk7TMSXQ5jHVk6boN4KyigI0SHRsxRFbAgke/csYJM+WstZm4pEne89dq1bE0/9XMx
        wNggDlpIFGobMEn3KvFW3jVoQwFntMrUdAECPwCaO0neSCSnBgwuVgCZqXtD+Ld/PE64fz
        b47VHgWWtiqlG0SJ10fzvnya2rEIV8c=
Date:   Thu, 7 Jan 2021 08:55:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     x86@kernel.org, kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: fix movdir64b() sparse warning
Message-ID: <20210107075533.GD14697@zn.tnic>
References: <160997278817.3976343.969979053457914470.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160997278817.3976343.969979053457914470.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:40:25PM -0700, Dave Jiang wrote:

> Subject: Re: [PATCH v2] x86: fix movdir64b() sparse warning

There are a lot of times I don't agree with checkpatch but this time I do:

WARNING: A patch subject line should describe the change not the tool that found it
#2: 
Subject: [PATCH v2] x86: fix movdir64b() sparse warning

Pls fix your other patch subject too.

> Add missing __iomem annotation to address sparse warning. Caller is expected
> to pass an __iomem annotated pointer to this function. The current usages
> send a 64bytes command descriptor to an MMIO location (portal) on a
> device for consumption. When future usages for MOVDIR64B instruction show
> up in kernel for memory to memory operation is needed, we can revisit.

Who's "we"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
