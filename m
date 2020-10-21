Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26802294EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443478AbgJUO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395019AbgJUO0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:26:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2912224E;
        Wed, 21 Oct 2020 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603290377;
        bh=l35jTotqmPVpGqH3vFD7Rm4q/ta0Ol+Pocoe3l+xzZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLElJiCfd/SO4lEx/Ikc9/UFCRupmdwtM/+ReBybVLucQIbBk+D82xsmKiqKGKtNu
         2lL+X7GKJ/15W2kbfJbspgXu1MGlAh34VYRGGPRfLeyqSpj/gwrGuOKzTUjnJimWJe
         ZMFuC2PauCD+4A49wEgQXHMpFtttcvTHVFzwMeUE=
Date:   Wed, 21 Oct 2020 23:26:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
In-Reply-To: <20201021092750.GA4050@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
        <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
        <20201020143746.GG11583@zn.tnic>
        <20201021095013.d82637f84af564ae4363189d@kernel.org>
        <20201021092750.GA4050@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 11:27:50 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 21, 2020 at 09:50:13AM +0900, Masami Hiramatsu wrote:
> > Agreed. So I'm OK for returning the result of "decoding".
> > But we also need to note that the returning success doesn't
> > mean the instruction is valid. That needs another validator.
> >
> ...
> 
> >
> > Yes, so let's add the return value (with a note, so that someone
> > does not try to use it for validation).
> 
> Ok, I'm unclear on that "validation" you talk about. What exactly do
> you mean? Can you give an example of how one would determine whether an
> instruction is valid? And valid how?

Hmm, I meant someone might think it can be used for filtering the
instruction something like,

insn_init(insn, buf, buflen, 1);
ret = insn_get_length(insn);
if (!ret) {
	/* OK, this is safe */
	patch_text(buf, trampoline);
}

No, we need another validator for such usage.

Thank you,
 
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu <mhiramat@kernel.org>
