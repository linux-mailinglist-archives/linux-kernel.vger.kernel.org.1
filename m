Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118D22B6B18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgKQRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgKQRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:07:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:07:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f1013008aaa2b5438c9ced9.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:8aaa:2b54:38c9:ced9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CB191EC027D;
        Tue, 17 Nov 2020 18:07:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605632860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DJgCtIjBDNS0OHlgANP+y4Xcsaz/d3+IMCtvPwqMqpI=;
        b=QrcmnPdx8cd5goZzLYIdjA4acvgeS0gYIu0jz5r/V/z423H+0r/+8J+ucYTRsSLJ6i4oMQ
        OUTfULijsGXZGsrugNEX6qcCY0Noemr5SEm9KQIDi4KevmbQvoEoYJS1A159h9FnZLbdAN
        ufL/bQXYH16IG1fDFM6xevzOZuWpPhY=
Date:   Tue, 17 Nov 2020 18:07:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Message-ID: <20201117170735.GH5719@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116202426.GF1131@zn.tnic>
 <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:19:01AM +0100, Alexandre Chartre wrote:
> We are not reversing PTI, we are extending it.

You're reversing it in the sense that you're mapping more kernel memory
into the user page table than what is mapped now.

> PTI removes all kernel mapping from the user page-table. However there's
> no issue with mapping some kernel data into the user page-table as long as
> these data have no sensitive information.

I hope that is the case.

> Actually, PTI is already doing that but with a very limited scope. PTI adds
> into the user page-table some kernel mappings which are needed for userland
> to enter the kernel (such as the kernel entry text, the ESPFIX, the
> CPU_ENTRY_AREA_BASE...).
> 
> So here, we are extending the PTI mapping so that we can execute more kernel
> code while using the user page-table; it's a kind of PTI on steroids.

And this is what bothers me - someone else might come after you and say,
but but, I need to map more stuff into the user pgt because I wanna do
X... and so on.

> The minimum size would be 1 page (4KB) as this is the minimum mapping size.
> It's certainly enough for now as the usage of the PTI stack is limited, but
> we will need larger stack if we won't to execute more kernel code with the
> user page-table.

So on a big machine with a million tasks, that's at least a million
pages more which is what, ~4 Gb?

There better be a very good justification for the additional memory
consumption...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
