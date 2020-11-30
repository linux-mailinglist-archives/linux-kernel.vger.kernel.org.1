Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0742C8DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbgK3TEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:04:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387684AbgK3TEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:04:15 -0500
Received: from zn.tnic (p200300ec2f0c0400247ce5eea000f6a3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:400:247c:e5ee:a000:f6a3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61A701EC04A9;
        Mon, 30 Nov 2020 20:03:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606763014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rOUJuYK9wa/A/SuFfQYy/ZZkyjuXFeT8MrvwplFTrug=;
        b=jrCIk71InAWgGv6MbKCP/PFkK+mFlCMD6mvNGDXGXBjva/yHKnrkiSrGICWiapeoO0tSSp
        boZw16x4ifvlxt7leKkJr6pVUlJlOa3knq3QcEFk9Kh0RdTWee4gd76h/IgS11F7RWPW3w
        8cJNDcBF2o3fMatncsMx1sRdnvBwnx4=
Date:   Mon, 30 Nov 2020 20:03:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201130190331.GI6019@zn.tnic>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:48:30AM +0800, Rongwei Wang wrote:
> MSR ARM driver aims to provide interfacs for user to read or write
> data to all system registers.

Just a warranty from x86 land: if I were an ARM arch maintainer, I would
never never *ever* take such driver exposing naked hw registers to
userspace.

We have been fighting with this on x86 for years:

a7e1f67ed29f ("x86/msr: Filter MSR writes")

with userspace tools poking at random MSRs. Read the commit message
for what can happen. And taking that thing is like opening a huge
can'o'worms that can't be closed anymore.

Currently, we're trying to move userspace tools to proper sysfs
interfaces but it is a huuuge pain. It is a lot easier to have people
define proper interfaces from the get-go where the kernel can control
and synchronize access.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
