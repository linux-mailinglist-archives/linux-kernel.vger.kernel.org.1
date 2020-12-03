Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55182CDBB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgLCRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLCRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:02:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07028C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:01:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f0dc5004496c992b512bfd2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:4496:c992:b512:bfd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3091B1EC01A2;
        Thu,  3 Dec 2020 18:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607014899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3c+0u2xiE9vV/8OBVB3MNID0owbw/IseZO13Ua1k4bY=;
        b=JZ0/0jd8mbL3Vjue6Ea6Q+mgWKJXg0zeL+KQdYAjd1Sl9k5XaiI9NmeNzsB5xdZ216PZtG
        /A9XuYFwMyf03PRtjLbtojWWR/8DaYb0ZlT6t2LK3XkmreQ9yqKUKYvcQRYARj4n9NiEBW
        +teZQUPPL6GzaGP3B4OVB91VOU59KbE=
Date:   Thu, 3 Dec 2020 18:01:40 +0100
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
Message-ID: <20201203170140.GM3059@zn.tnic>
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <20201203123757.GH3059@zn.tnic>
 <20201203124121.GI3059@zn.tnic>
 <20201203124820.GJ3059@zn.tnic>
 <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
 <20201203165420.GL3059@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203165420.GL3059@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 05:54:20PM +0100, Borislav Petkov wrote:
> On Thu, Dec 03, 2020 at 10:45:48AM -0600, Tom Lendacky wrote:
> > Since this is based on the array size, can
> > 
> > 	idx < NUM_LEGACY_PREFIXES
> > 
> > be replaced with:
> > 
> > 	idx < ARRAY_SIZE(insn->prefixes.bytes)
> 
> Actually, this needs another change:
> 
> struct insn_field {
>         union {
>                 insn_value_t value;
>                 insn_byte_t bytes[NUM_LEGACY_PREFIXES];

Blergh, spoke too soon. All those struct insn members are struct
insn_field.

insn.prefixes should probably be a separate array of explicit size
NUM_LEGACY_PREFIXES, not that insn_byte_t bytes[] gets enlarged in the
future for whatever reason, while the max legacy prefixes count will
remain 4.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
