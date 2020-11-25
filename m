Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FEB2C483B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKYT0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgKYT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:26:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB15C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:26:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c9b00f5da200e3f5a4570.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9b00:f5da:200e:3f5a:4570])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FFF91EC04DB;
        Wed, 25 Nov 2020 20:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606332360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5FJUMx0oWkal2PmgCr3m76x9Ssn6xnvO8OZ8Gc6iM2c=;
        b=TnzlggvRfPq6N6ugY/0YZOjoMXSPVG7/oWHn6KWLMQtpeNfhczxIcZpw7LLFhp0GWBnW7i
        NYNegyh3OA1HfpjL+TNqXW9zYItPxKIYOXO7fLuUJhsbi0CtNWTTZNDBK3h9SLZYLAnoQR
        R794sXl6LOtGcS4rPEtsoPAPPX4SptQ=
Date:   Wed, 25 Nov 2020 20:25:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 03/19] x86/insn: Add an insn_decode() API
Message-ID: <20201125192553.GD9996@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
 <20201124101952.7909-4-bp@alien8.de>
 <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 01:53:33AM +0900, Masami Hiramatsu wrote:
> (only from the viewpoint of VEX coding, a bit stricter, but not perfect.)

Yeah, I wanted to document the fact that it has changed behavior in the
commit message - we'll make it perfect later. :-)

> > @@ -98,8 +101,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
> >   * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
> >   * to point to the (first) opcode.  No effect if @insn->prefixes.got
> >   * is already set.
> > + *
> > + * * Returns:
> > + * 0:  on success
> > + * !0: on error
> >   */
> 
> So this is different from...
> 
> [..]
> > +
> > +/**
> > + * insn_decode() - Decode an x86 instruction
> > + * @insn:	&struct insn to be initialized
> > + * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
> > + * @buf_len:	length of the insn buffer at @kaddr
> > + * @m:		insn mode, see enum insn_mode
> > + *
> > + * Returns:
> > + * 0: if decoding succeeded
> > + * < 0: otherwise.
> 
> this return value.
> 
> Even for the insn_get_*(), I would like to see them returning -EINVAL
> as same as insn_decode(). Same API group has different return value is
> confusing.

Right, my goal in the end here is to make *all* users of the decoder
call insn_decode() and nothing else. And there you can have different
return values so checking negative/positive is the proper way to go.

Those other helpers, though, should then become internal and for those I
think it is easier to use them when they return a boolean yes/no value,
meaning, they do one thing and one thing only:

For example, it is more readable to do:

	if (insn_...)

vs

	int ret;

	...

	ret = insn_,...()
	if (ret)
		...

which is 4 more lines of error handling and return variable, leading to
more code.

But if you want to be able to use those other helpers outside of the
decoder - for whatever reason - then sure, the function signatures
should be the same.

Thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
