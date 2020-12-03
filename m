Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACC22CD5AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgLCMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgLCMmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:42:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D544C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:41:22 -0800 (PST)
Received: from zn.tnic (p200300ec2f0dc500b89b6474ddf31320.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:b89b:6474:ddf3:1320])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E702E1EC01A2;
        Thu,  3 Dec 2020 13:41:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606999281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wf9rO+JIQ7eg4Nwc/w2Qcb+USEcKwFctKt1LleGpRRU=;
        b=LtKuqbmyqVLyo1SL5GJ76z/TeRAX3KHjlcCw2ShBK/wBgVyxaLmKg8qT2OJU0JP1itdxUS
        aisGiLCR1PohC+P92+uj0Vc1YURGhSV/hj4JTy74/kds0fJ4oc07BT9LPSH0Wz4yNosw2k
        8PVl/dY3tOHfu6e3A3X1bFC5y9eSAj0=
Date:   Thu, 3 Dec 2020 13:41:21 +0100
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
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-ID: <20201203124121.GI3059@zn.tnic>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <20201203123757.GH3059@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203123757.GH3059@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:37:57PM +0100, Borislav Petkov wrote:
> Btw, looking at the struct insn definition, that prefixes member should
> have a comment above it that those are the legacy prefixes which can be
> <= 4. But that's minor.

And that naked 4 is poking my eye too - It'd be better if it were
NUM_LEGACY_PREFIXES.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
