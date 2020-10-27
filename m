Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3129AA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460322AbgJ0L0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:26:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460314AbgJ0L0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:26:39 -0400
Received: from zn.tnic (p200300ec2f0dae00ea24eb74b2fb7b68.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:ea24:eb74:b2fb:7b68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A67AE1EC025D;
        Tue, 27 Oct 2020 12:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603797998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ef6LYmbq9FJher6dg4RpLI0Ys/mS9KqfkzUSj4o9KXc=;
        b=q3qzXDPyaUj0JIal3lSgXmgnov9BoNEmhBXfGov5q9D1Nl0Xf7jeUmSveq99RYk9CR9/bM
        TsnK0FbPUEA/TAqAgdKKy6njwGyRROhPZj6fEVlsAWVtowp9PbcemGMpIanKIaf0+qQaAu
        7/rlI1/WSfC4yW76NCg8iitJcF0O7LQ=
Date:   Tue, 27 Oct 2020 12:26:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] x86/sev-es: Do not support MMIO to/from encrypted
 memory
Message-ID: <20201027112635.GF15580@zn.tnic>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021123938.3696-6-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:39:38PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> MMIO memory is usually not mapped encrypted, so there is no reason to
> support emulated MMIO when it is mapped encrypted.
> 
> This prevents a possible hypervisor attack where it maps a RAM page as

"Prevent... "

> an MMIO page in the nested page-table, so that any guest access to it
> will trigger a #VC exception and leak the data on that page to the
						^

"... via the GHCB (like with normal MMIO)... "

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
