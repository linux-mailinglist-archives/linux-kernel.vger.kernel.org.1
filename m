Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC45D297B74
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760046AbgJXIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760039AbgJXIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 04:24:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9CC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 01:24:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f830002f7f4f3bcfb0c40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:2f7:f4f3:bcfb:c40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 902001EC054C;
        Sat, 24 Oct 2020 10:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603527889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jmoc4fwoCZvguxc4JIIXHibdyjTNnd8EjJPfw+6xl3c=;
        b=HIl/yOMsdl4wQJPEAFNVWOwIlZMxn0G3usXQnkqyeaS8v3WEosLDKr+aidS2tYs4MVJ9w5
        Sz7ngmDHlnNq3nIt46MXtloYmNDtDdgs8ZGKb+jGvydsuQ2/b9melA9TRvf46qbbjznDQD
        zxCIpKSev7pk1wnVMnlu4YYJpctNS/g=
Date:   Sat, 24 Oct 2020 10:24:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201024082445.GB11562@zn.tnic>
References: <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org>
 <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
 <20201023232741.GF23324@zn.tnic>
 <20201024161315.267499b854b1d08213f7c445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201024161315.267499b854b1d08213f7c445@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 04:13:15PM +0900, Masami Hiramatsu wrote:
> Thanks, so will you split this into several patches, since I saw some
> cleanups in this patch?

Oh, most definitely. This was just a preview of where this is going...

> Yeah, that's good to me because in the most cases, user needs prefix,
> length or total decoded info.
> 
> BTW, it seems you returns 1 for errors, I rather like -EINVAL or -EILSEQ
> for errors so that user can also write
> 
>  if (insn_decode() < 0)
>    ...
> 
> I think "positive" and "zero" pair can easily mislead user to "true" and
> "false" trap.

Ok, sure, makes sense.

> Yeah, for the kprobes, if you see the insn_init() and insn_get_length()
> those can be replaced with one insn_decode().

Ok.

> Except for the return value, it looks good to me.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
