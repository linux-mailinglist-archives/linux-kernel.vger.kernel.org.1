Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870802CA708
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbgLAP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:26:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbgLAP0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:26:38 -0500
Received: from zn.tnic (p200300ec2f0e6a009ae7ed3e982f3c10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:9ae7:ed3e:982f:3c10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D2381EC04D1;
        Tue,  1 Dec 2020 16:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606836357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EqXvKoYqADEjA6zEZSWiBnqob+NV98aFo9Y3mq5PFt4=;
        b=sRWAKCymZ83rvJB58riy8B6m+MECl/9WckPjTsJ5afX0hVI58qC0mMjUzEdIJAW4CPpsQe
        nM4tlaPuU6MbCMUj6oXdFJCJ0gqEyJPfdgI+d8V8X4BWUkAoZPYwfMSbxLfs5JohZnLRS/
        8crj6L0sDIsQ8+pIBkMBTVqKC/V8EOU=
Date:   Tue, 1 Dec 2020 16:25:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201201152552.GD22927@zn.tnic>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic>
 <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
 <20201201145415.GC22927@zn.tnic>
 <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:17:39PM +0800, Rongwei Wang wrote:
> In ARM, the system registers can only be accessed through msr and mrs,
> so the problem created by MSR driver (depend on rdmsr and wrmsr) in
> x86 is not necessarily present in ARM, which is very different from
> x86.

No, the point I'm making is that it doesn't matter what the architecture
does or does not, register *writes* from userspace are a bad bad idea
for the reasons I described.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
