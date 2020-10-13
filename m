Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513BF28C9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbgJMILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbgJMILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:11:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32926C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:11:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ecc00b688821b0a181b84.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:cc00:b688:821b:a18:1b84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D90CE1EC0407;
        Tue, 13 Oct 2020 10:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602576687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=icPRekjS8kR0Y34b/6RCaf5TY6fJKr7Q4iu2Gfc+rUg=;
        b=nR0UwQHND2jTLtgj6RNpHh6u7FSSI0wYvtYPE00EUK9NuI78HTJRGOu858J5QvGWSWIBBF
        4KUFk1YmEh4Q0b9feeO8YyqvbMuUjQ5ML7G4NKgIqcFh0LR21Pi+KS+SgN9Vt1ra0sSTbR
        9mOuE4nrMg/r9hzJsdq1xeS3Ta2d9kQ=
Date:   Tue, 13 Oct 2020 10:11:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201013081117.GA28215@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012153501.GA559681@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:35:01AM -0400, Arvind Sankar wrote:
> > qemu supports it. -cpu "qemu64,+la57"
>
> Thanks! On QEMU, it does crash without this patch.

Works fine here. I gave this to qemu:

-cpu qemu64,+la57,vendor=GenuineIntel

it said:

qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.07H:ECX.la57 [bit 16]

because host is AMD, probably, and I have

CONFIG_X86_5LEVEL=y

enabled for the guest kernel and tip:x86/seves booted fine.

What am I missing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
