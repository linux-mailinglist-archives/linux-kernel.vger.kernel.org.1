Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD32CDD30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLCSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLCSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:17:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D366C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 10:17:19 -0800 (PST)
Received: from zn.tnic (p200300ec2f0dc5004496c992b512bfd2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:4496:c992:b512:bfd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98FD31EC0283;
        Thu,  3 Dec 2020 19:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607019437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9m4NiydVLFvnOy0kDRZckdmjd5apIRy2SjVNb1/3aEo=;
        b=L9SK4kv3O3iy+1vcp5dZkf5JxWogEHm2opxaAwUWVuLJ3p6xkNJvEu6jdspHq+jrRv54lf
        k5v3Hblo9NP/CnKuE1FG9/roLs1X/3FvHq0DWr/EgFkRZL+3fwF9VXO93n/5Yym6ed0fp7
        n330h3Khj1okcJSQWq9ZnGSB9Od3+tI=
Date:   Thu, 3 Dec 2020 19:17:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
Message-ID: <20201203181712.GN3059@zn.tnic>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <20201203123757.GH3059@zn.tnic>
 <20201203124121.GI3059@zn.tnic>
 <20201203124820.GJ3059@zn.tnic>
 <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
 <20201203165420.GL3059@zn.tnic>
 <20201203170140.GM3059@zn.tnic>
 <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:10:10PM -0600, Tom Lendacky wrote:
> Since that struct is used in multiple places, I think basing it on the array
> size is the best way to go. The main point of the check is just to be sure
> you don't read outside of the array.

Well, what happens if someone increases the array size of:

struct insn_field {
	union {
		insn_byte_t bytes[4];
				^^^^

?

That's why a separate array only for legacy prefixes would be better
in the long run. The array size check is good as a short-term fix for
stable.

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
