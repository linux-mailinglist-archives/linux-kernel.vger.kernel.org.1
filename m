Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0595D29461B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439776AbgJUAuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439768AbgJUAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:50:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C42822251;
        Wed, 21 Oct 2020 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603241417;
        bh=78hBHfbHX9Dr+4BC7F/fPvXdyozvyE0CdvpMQRY51q0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXdZcIPsC6TJdY5qBUVp6ZNx+wcnt7qUAwP/YkuvwtT2mMSMKsHRquW/KWDx7xSV2
         t4sMlXbpVTgcyU6BNy6w9ZG/XPKWP7IxZITf3piNAR9GaoHPRiRxRScFdHvK5NsCA0
         eyWOCebYkJZS36zRVVXTBNcqX8YSvB9Ab0C58+RE=
Date:   Wed, 21 Oct 2020 09:50:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201021095013.d82637f84af564ae4363189d@kernel.org>
In-Reply-To: <20201020143746.GG11583@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
        <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
        <20201020143746.GG11583@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 16:37:46 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Oct 20, 2020 at 11:27:00PM +0900, Masami Hiramatsu wrote:
> > So, if this return value is optional, it is OK to me. But the success
> > return value does NOT mean it a correctly encoded instruction.
> 
> Ok, so what is the correct way to find out whether the decoding was
> successful?
> 
> Because as it is now, it is confusing:
> 
> - Which ->got field do you check?
> 
> - Do you check all got fields like insn_complete() does?
> 
> And the return value can be made non-optional to denote that the
> *function* that was called, was successful or not. The thing is, one
> needs to designate one function to call and say, if this function
> returns successfully, then the decode was ok.

Agreed. So I'm OK for returning the result of "decoding".
But we also need to note that the returning success doesn't
mean the instruction is valid. That needs another validator.

> If we want to look at only some aspects of some insn bytes, we can
> definitely make the functions which do, like insn_get_length(),
> insn_get_immediate() and all those return a value to denote that *they*
> were successful or not.

OK.

> 
> All I'm trying to say is, *how* this insn decoder *should* be used,
> is not really entirely clear, at least to me it isn't, and we need to
> define that so that callers know what to expect.
> 
> Does that make more sense?

Yes, so let's add the return value (with a note, so that someone
does not try to use it for validation).

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
