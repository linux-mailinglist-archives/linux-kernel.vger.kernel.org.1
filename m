Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAE2E6FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2K7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2K7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:59:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46376C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:58:35 -0800 (PST)
Received: from zn.tnic (p2e584e83.dip0.t-ipconnect.de [46.88.78.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 036EB1EC0283;
        Tue, 29 Dec 2020 11:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609239512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hsQtGK2q0uoUzluF6P6QksT9oReRT9WAM43QOWo87ag=;
        b=DKP4jeCBW/quMo5U/d5lZSdA8G/l2Fo+mWA+TuZn4QPELwQMuqJDtNSiO/hgYkAgJdsonF
        cIhOblnoOb1rgYXoIgq0Jz94bMmSbscDVHeftfgllKJ/0W61FPiNSRz7PGjZHuanqAqI4S
        uMBourarEA4Yn69GmMtlB0sU1w1q9pk=
Date:   Tue, 29 Dec 2020 11:56:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc
 handling
Message-ID: <20201229105618.GA29947@zn.tnic>
References: <20201217010409.3675060-1-pgonda@google.com>
 <X9uTESe5n3ApvnOD@google.com>
 <20201228223650.GD20321@zn.tnic>
 <X+ptiuVAMXJ3uBX8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+ptiuVAMXJ3uBX8@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 03:43:06PM -0800, Sean Christopherson wrote:
> Eh, casting to u8 is "absolutely correct" as well.  I don't like using bytes[]
> because it feels like accessing the raw data as opposed to the end result of
> decoding, but it's not a sticking point.

Ok, code in the kernel uses mostly ->value so u8 casting it is.

> Yes, insn_get_immediate() sets insn->immediate.value directly and sign extends
> the imm8 (which is correct, e.g. for "AND r/m64, imm8"). 
> 
> 	switch (inat_immediate_size(insn->attr)) {
> 	case INAT_IMM_BYTE:
> 		insn->immediate.value = get_next(signed char, insn);
> 		insn->immediate.nbytes = 1;

Ah, there it is. And we set nbytes too, conveniently.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
