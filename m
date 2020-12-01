Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3CA2CA65D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391525AbgLAOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389519AbgLAOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:55:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:54:23 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e6a00797954e951a06088.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:7979:54e9:51a0:6088])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F2571EC04B9;
        Tue,  1 Dec 2020 15:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606834461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+P6mLtdTiCQEV00e7XUadSCicMLYNZyllTVA4ujVE+o=;
        b=ZOIf/oSEITo3E5OhQyNscvmmsjaDOIIHwhzRquBXC578emnt0yrzEdIO5r7xaFlGLjIzO6
        5rbj30wI2HprBxobcfVxKlsMS0PMp5DXf9766TOV7zkizup8AtVqAliL19rQed/93Y+bst
        afiu8WaY26y1CA/Gqnk2T19JBpwLiWs=
Date:   Tue, 1 Dec 2020 15:54:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     wangrongwei <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201201145415.GC22927@zn.tnic>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic>
 <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:33:42PM +0800, wangrongwei wrote:
> Yes, and x86 also provides two instructions with the same name in the
> instruction set, but not in ARM.

Sorry, I can't parse what you're trying to say here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
