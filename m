Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D1284C5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJFNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:16:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJFNQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:16:07 -0400
Received: from zn.tnic (p200300ec2f0d6300a8f8264196af23e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:a8f8:2641:96af:23e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 868281EC032C;
        Tue,  6 Oct 2020 15:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601990165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0eMzK3+nUeii3WtWwZZ92aCXncjeYvtcDWouE6KGWos=;
        b=J30hq4fp5TTsIGHDtJQIEZ5D9Z49rwMET3Nhk8pare+m9apDUUfLF4795la7J2js4Bwtd0
        zWG1WXCG1JvAJYvXPM9wKtTX/Z3/beqAJDiwLLi/8SlmcBHZ1EvSDFzZrL2EJLS3m4v3Jx
        dPp6W1e+4rH0XFK3lKJXcfblSQJUa0E=
Date:   Tue, 6 Oct 2020 15:16:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 02/13] x86/platform/uv: Remove SCIR MMR references for
 UVY systems.
Message-ID: <20201006131602.GE27700@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-3-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005203929.148656-3-mike.travis@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v4 02/13] x86/platform/uv: Remove SCIR MMR references for UVY systems.

You mean "UV" systems, right? Or are there "UVY" systems too? git grep
says no.

On Mon, Oct 05, 2020 at 03:39:18PM -0500, Mike Travis wrote:
> UV class systems no longer use System Controller for monitoring of CPU
> activity provided by this driver.  Other methods have been developed
> for BIOS and the management controller (BMC).  This patch removes that
> supporting code.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

I've fixed it up but please try not to do that in future patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
