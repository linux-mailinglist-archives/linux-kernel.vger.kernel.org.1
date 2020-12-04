Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4C2CF04B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgLDPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:03:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbgLDPDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:03:06 -0500
Received: from zn.tnic (p200300ec2f12b100a8acd31b3e2f4e6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:b100:a8ac:d31b:3e2f:4e6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AF4B1EC0380;
        Fri,  4 Dec 2020 16:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607094145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yui38/jim3iTXbTxJ/PqC28fcudMd1RnlJgfgC5QNxQ=;
        b=U2Oe+fbvpNQJxf5aTQ2O5diDtVaAXuH9zr38119qB6iMYGQBGA0iLjp7bVnKGcnVF1rBPr
        HVIzHinl/oXDByaXfnlxyjorAjcRMxOEP9uPHhlXVoM1zez1PpGSVlW2NqzUwX5GXLqV1l
        gKHnjmQmyQWTyljMpBc9mgdtx7y6ac8=
Date:   Fri, 4 Dec 2020 16:02:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/insn: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-ID: <20201204150221.GF31534@zn.tnic>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160707930875.3296595.12884856538916078988.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 07:55:09PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here are the 3rd version of patches to fix the wrong loop boundary
> check on insn.prefixes.bytes[] array.

Ok, so I've committed the version with ARRAY_SIZE to keep it as small
as possible for stable. Let's discuss the new changes here ontop, once
those urgent fixes go up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
