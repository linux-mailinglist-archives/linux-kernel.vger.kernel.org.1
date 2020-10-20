Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21248293EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408252AbgJTOh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408233AbgJTOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:37:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFF4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:37:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1066002c8cb5b4e89050dd.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:6600:2c8c:b5b4:e890:50dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79FB71EC04CB;
        Tue, 20 Oct 2020 16:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603204676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ga8ur2Se3KwTAI78fC2QFDfZPWYbl5RBbvnVZZoDbOM=;
        b=UZOBjQxlduDKd+YsY8Tq+DBfHjkcim6in7HyEmXOLK1BAWsBfR+myblh4v7Q642L6Cpelb
        6KEGmZzYA/0KqKvyc98YhfWw1HUp1X/Nw3RXkkNirfQoWk8OK0A0XU4qkqlUx9aEswYSMr
        DW+seTFZzn9MRN6HrpzYPLLO3wOWZ10=
Date:   Tue, 20 Oct 2020 16:37:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201020143746.GG11583@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
 <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:27:00PM +0900, Masami Hiramatsu wrote:
> So, if this return value is optional, it is OK to me. But the success
> return value does NOT mean it a correctly encoded instruction.

Ok, so what is the correct way to find out whether the decoding was
successful?

Because as it is now, it is confusing:

- Which ->got field do you check?

- Do you check all got fields like insn_complete() does?

And the return value can be made non-optional to denote that the
*function* that was called, was successful or not. The thing is, one
needs to designate one function to call and say, if this function
returns successfully, then the decode was ok.

If we want to look at only some aspects of some insn bytes, we can
definitely make the functions which do, like insn_get_length(),
insn_get_immediate() and all those return a value to denote that *they*
were successful or not.

All I'm trying to say is, *how* this insn decoder *should* be used,
is not really entirely clear, at least to me it isn't, and we need to
define that so that callers know what to expect.

Does that make more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
