Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680762CA77A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391945AbgLAPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:52:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34968 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391886AbgLAPwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:52:12 -0500
Received: from zn.tnic (p200300ec2f0e6a009ae7ed3e982f3c10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:9ae7:ed3e:982f:3c10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A18DA1EC0426;
        Tue,  1 Dec 2020 16:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606837890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRYv1SLWtxLzgR/QboS0I3cMHWb72mjJTAWK7Q3su8k=;
        b=XiJyU0ODNsfVzJluKAbtEzSzksiWpXfmYAA7NgcYK5A214N1qGGmZcvveQX+aNY/feZKtn
        EYqdY2FwKxBEqb2xznT+igc8d7ig5JXcE/UitvOSHkOnkplWGQCXpLLiKLELwiiaojDwE1
        Nb98FuvLyYi46tRgTV8qVzt15Ben20k=
Date:   Tue, 1 Dec 2020 16:51:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Kara <jack@suse.cz>,
        =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
Message-ID: <20201201155126.GE22927@zn.tnic>
References: <20201130223059.101286-1-brgerst@gmail.com>
 <20201201094810.GB24488@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201094810.GB24488@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:48:10AM +0100, Jan Kara wrote:
> On Mon 30-11-20 17:30:59, Brian Gerst wrote:
> > Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments to
> > use the compat handlers to allow conversion to passing args via pt_regs.
> > sys_fanotify_mark() was however missed, as it has a general compat handler.
> > Add a config option that will use the syscall wrapper that takes the split
> > args for native 32-bit.
> > 
> > Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
> > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> 
> Thanks for the patch! It looks good to me. Feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>
> 
> I assume you plan to push this via x86 tree given the changes are mostly
> there, don't you?

Looks sane to me too, I guess I can send it to Linus even now so that it
lands in 5.10. Is that what you'd prefer Jan?

Also, Paweł, can you give that one a try to see if it fixes your case?
It should...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
