Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A362CA14B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgLAL1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:27:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgLAL1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:27:33 -0500
Received: from zn.tnic (p200300ec2f0e6a00835f506c18984427.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:835f:506c:1898:4427])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A33A01EC03CE;
        Tue,  1 Dec 2020 12:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606822011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kG05JigLq40d1naxqpJ6O+B10zBDQJXKWSq7mQrphYg=;
        b=BojY9LhbBSwQ8ArzVxrc7xJmMa4uIFOav+p30OL3Syx6JraGb//TATTYxZZJFIjUiez9A2
        09xGNqYRskkRNf8Xc1CMYnDSWvJuTK+AxDFujk4khnAeCy1t2Vo04v1Br8C9dwrmoUNa3h
        q7gIMGzlZ3iVWvjaihbgym07HcKoVjU=
Date:   Tue, 1 Dec 2020 12:26:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     wangrongwei <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201201112647.GA22927@zn.tnic>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:44:52AM +0800, wangrongwei wrote:
> Indeed, I have read the commit message, and it seems that writes data
> to a system register may cause many problems. Actually, we have taken
> this into account. In the current version, we have separated the read
> and write functions to the system registers into two commands,

There's rdmsr and wrmsr in msr-tools on x86 too.

> In providing the WRASR function, we consider that users should bear
> the consequences of rewriting registers during the debugging phase. In
> fact, most of the time we rarely use WRASR, and only use it when we
> are very confident.

As I said, there should never never ever be a tool which allows writing
of registers from userspace. If I could go back in time, I'd stop this
on x86 but it is too late now. Not for ARM though.

Also, do you see how all the people who replied to your mail, put the
text under the quoted text. Do that too, pls, from now on, and refrain
from top-posting.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
