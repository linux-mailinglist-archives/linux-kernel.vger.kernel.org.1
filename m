Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1191292D30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgJSRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgJSRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:54:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFEC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:54:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so1082929ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEZB5GRTmrZaMNj/Rw5xKbbXCRlbpKBqsdzVrJzTdY4=;
        b=HBdC+kz7196kPgrjSBHu3cxIvP9ZP74ZfnWlVCdTJWg+3snACvtAfSvskVjcTyZxPy
         0nc5xbsllBdzIk7XemJCx4laR5kjfu6VYTa217IeyE+1rOA1tGHPNiSNpUqjbhDKUUOP
         Gb4GTb3+U/WYvSNZscNHe5gc7AR3OWSwAmx6i0VlgIn1xKaSmT2Vx5A3YYkld52Ixsd5
         cqwnIQEHK5xqTsPhKjXZBqryc+g/4yhYMtgw2rRG5thFL2weMOXbdMCYl//YQFPKZ/k3
         XUMf4NsAnn/5evp3yIB4caGRKs+OtBZmuTaVdr7ZBVLPWGF1km2pInJp1c2C7ZM5WteP
         Ysfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rEZB5GRTmrZaMNj/Rw5xKbbXCRlbpKBqsdzVrJzTdY4=;
        b=eZrHh+xMy28zUQ8HQx4NVowloKSS0V3tETnMyE6fp9VnWuSKQRcHYJ1h3yFI1MSgAb
         WIY8fTFsXo4Q7niQ+vU/1uAuBh3LWommmJie69xZEtyQTid15+TxyPD4E4bE8pg5ZfVq
         1f5MLmwWErwwEiq05XSXrmoZ9I0q2mWEnAGOe/cfEVjRb5me2N/hR849cWgy+NEKyF7H
         AfET1D/sIOmKyFD1OIvb/EKjPgM4IV/zFd2z9xQ4R6TJcylzgVbVoqjulD2oIyV1JMWR
         2u463IwUD7ZOhBetxefTb6Z4U2+mPnNzKxduIoaUdb7OSGaUEg6cXrqC4yWAkxn73EF4
         ENTw==
X-Gm-Message-State: AOAM5317ygitTLMo/RKK0deY6w8RXWWsa2w7sQTVMZP3h3p/1yzaorLO
        Wwo3tcZbZ6YAj5IExxJWMEw=
X-Google-Smtp-Source: ABdhPJzRoOIf7CbwQtdrVb4m+w+T3PjPfwtv3E+MY8QA0E7OLYAVJLadenm8ANjc+QYjhewdSSiR3Q==
X-Received: by 2002:a92:1303:: with SMTP id 3mr964428ilt.117.1603130090484;
        Mon, 19 Oct 2020 10:54:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p15sm403853ioh.27.2020.10.19.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:54:49 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 13:54:47 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201019175447.GA2720155@rani.riverdale.lan>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019170008.GA2701355@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:00:08PM -0400, Arvind Sankar wrote:
> On Mon, Oct 19, 2020 at 05:11:19PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Check whether the hypervisor reported the correct C-bit when running as
> > an SEV guest. Using a wrong C-bit position could be used to leak
> > sensitive data from the guest to the hypervisor.
> > 
> > The check function is in arch/x86/kernel/sev_verify_cbit.S so that it
> > can be re-used in the running kernel image.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> 
> > +
> > +	/* Store value to memory and keep it in %r10 */
> > +	movq	%r10, sev_check_data(%rip)
> > +
> 
> Does there need to be a cache flush/invalidation between this and the
> read below to avoid just reading back from cache, or will the hardware
> take care of that?

Also, isn't it possible that the initial page tables we're running on
have already been messed with and have the C-bit in the wrong location,
so that this write happens decrypted?

> 
> > +	/* Backup current %cr3 value to restore it later */
> > +	movq	%cr3, %r11
> > +
> > +	/* Switch to new %cr3 - This might unmap the stack */
> > +	movq	%rdi, %cr3
> 
> Does there need to be a TLB flush after this? When executed from the
> main kernel's head code, CR4.PGE is enabled, and if the original page
> mapping had the global bit set (the decompressor stub sets that in the
> identity mapping), won't the read below still use the original encrypted
> mapping if we don't explicitly flush it?
> 
> > +
> > +	/*
> > +	 * Compare value in %r10 with memory location - If C-Bit is incorrect
> > +	 * this would read the encrypted data and make the check fail.
> > +	 */
> > +	cmpq	%r10, sev_check_data(%rip)
> > +
> > +	/* Restore old %cr3 */
> > +	movq	%r11, %cr3
> > +
> > +	/* Check CMPQ result */
> > +	je	3f
> > +
> > +	/*
> > +	 * The check failed - Prevent any forward progress to prevent ROP
> > +	 * attacks, invalidate the stack and go into a hlt loop.
> > +	 */
> > +	xorq	%rsp, %rsp
> > +	subq	$0x1000, %rsp
> > +2:	hlt
> > +	jmp 2b
> > +3:
> > +#endif
> > +	ret
> > +SYM_FUNC_END(sev_verify_cbit)
> > +
> > -- 
> > 2.28.0
> > 
