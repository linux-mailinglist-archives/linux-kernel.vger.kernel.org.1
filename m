Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D22D7F00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbgLKTDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:03:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391551AbgLKTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:02:47 -0500
Received: from zn.tnic (p200300ec2f124300da799288a8bc7530.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:da79:9288:a8bc:7530])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A729A1EC038E;
        Fri, 11 Dec 2020 20:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607713325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G1QdGYcDTW0B9pLacQcKlGP5gjL9zeHP1/bEwt95B1k=;
        b=Eco9TFSPdJj7r1rA2XJTfjc/YX8L5J91rNmAnvoLKEscJHoy9dlQ9LTWhZOHMVprHvKtOC
        R9y4YKvp5rP6KeFEWj+ilQpEy001BbvpIEOh+yEnjhbCIaMzryi8lGtfWd+gmh8YkAyejk
        i5Z1wHatgT0O3scmg6+ZouStMnvXb8k=
Date:   Fri, 11 Dec 2020 20:02:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: ia32_setup_rt_frame(): propagate __user annotations
 properly
Message-ID: <20201211190200.GF25974@zn.tnic>
References: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
 <20201211184715.GE25974@zn.tnic>
 <CAKXUXMzZ7ejn1JrznDP6d7dk8tSsTznBO+423NAwf_nYsix=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXUXMzZ7ejn1JrznDP6d7dk8tSsTznBO+423NAwf_nYsix=_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 07:55:50PM +0100, Lukas Bulwahn wrote:
> Yes, agree. Other maintainers noted that I should point out that the
> patch is only a minor clean-up and it is not urgent to be considered.
> 
> So, I add this remark to make clear that it is not top priority to
> apply just that the maintainers know.
> 
> You will sure review it eventually, and hopefully accept it then.

Well, after I review it, I probably should know what the priority is,
right?

> If that comment disturbs you, please ignore it.

I was just wondering why you're writing something which is not really
needed. Notes under "---" are usually used to clarify aspects of the
patch handling, versioning, etc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
