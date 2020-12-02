Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF12CC482
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgLBSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgLBSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:05:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:05:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9EF21EC04D6;
        Wed,  2 Dec 2020 19:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606932301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TE/OHmqT8H79QFUkFqfZpqHgm6sL6Er/QHxIG08YOvs=;
        b=Lt95ZAietdiaN+EX4738+KleeNMsD1BTxd979xsP3J6hW1i7w3xjnAy/cYxdgA2WsbqbaI
        rKF88mEp2+JHkQbWr2CEyhAzUL8m3DZE1RbF/pSpILclcy5CkyGgMGVoOUjee57OuWgFcK
        6h3i/W1wSRS/SPW6lifjufD9dY60veg=
Date:   Wed, 2 Dec 2020 19:04:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-ID: <20201202180456.GH2951@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
 <20201124174647.GI4009@zn.tnic>
 <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
 <20201129175005.7e07a9f799e888ffd5f4ed67@kernel.org>
 <20201130134442.GB6019@zn.tnic>
 <20201201022145.48201fe165a28cb0e1f042ae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201022145.48201fe165a28cb0e1f042ae@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:21:45AM +0900, Masami Hiramatsu wrote:
> Because it overruns the buffer. Maybe -E2BIG/ENODATA or any other
> error (except for -EINVAL) is OK :)

ENODATA it is. :)

And propagating that error value is easy because the err_out: labels are
all coming from the validate_next() error path so we basically know that
the buffer has ended.

./insn_sanity: Success: decoded and checked 10000 random instructions with 0 errors (seed:0x7bdfa56e)
insn buffer:
0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
supplied buf size: 15, ret 0
supplied buf size: 2, ret 0
supplied buf size: 3, ret 0
supplied buf size: 4, ret 0
insn_decode: entry
insn_decode: will get_length
insn_get_immediate: getting immediate
insn_get_displacement: getting displacement
insn_get_sib: getting sib
insn_get_modrm: entry
insn_get_opcode: entry
insn_get_prefixes: entry, prefixes->got: 0
insn_get_prefixes: 1
insn_get_prefixes: REX
insn_get_prefixes: VEX
insn_get_prefixes: validate_next: 0
insn_get_prefixes: insn->next_byte: 0x7ffc211eb661, insn->end_kaddr: 0x7ffc211eb661
insn_get_prefixes: errored out
supplied buf size: 1, ret -61

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
