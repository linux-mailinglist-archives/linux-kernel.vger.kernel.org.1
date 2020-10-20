Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF53294025
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437008AbgJTQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgJTQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:04:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE5CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:04:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j13so2982770ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNlB9YEedi1DCkSsmiZeDcO9zXDI+9cp+/wZCzJQVtc=;
        b=p+YTYFnA+0z42/OG9X9WFzK3kpkh4WHfxeFrEDCOSwHO8817IhHloUNnIupg+5494E
         TBLiuOljaVKtXEOt6ITyO/OsitEWd7ooSR1Y5VlrBd+0+Ssg2oJXCHfwH7ELDqtBZSM1
         T3kl7gUhqegry/M+e5o8jLAXTC4EHUYlw2oZWx7HCgHhGvM7lYySl/sBHbjOM/yWylnZ
         xj21zhph2Fk2QRVH9qeIggTgenObMetcdesza8YNVN23AuLBeUpHiAFDgCQaK9mJw3k0
         634Mgmds4tJeFsiR69fyDuK3qiDzH95h14GT8u5cTAcAOQ543/iTpRJyOFdyDuN/sQHk
         118w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lNlB9YEedi1DCkSsmiZeDcO9zXDI+9cp+/wZCzJQVtc=;
        b=cNV2jchP2u6j0CfmeGSkuMBs3UCUT4BGU2C+rbQQv0mtk9mK4tMM1JSY6liZLJHp4y
         em7e1tRp3lj/N8t77elenL/kkPYgEYcIVTINDhlaTGLxnX33/ozUq2KwaY5uQDo3sHu0
         L3uQidZgnJxnABswfFs/bFWQbpC6SnXNnjPcLLjA5n8iAJ3D9zSZpTXlrbgbvrNg/MgQ
         rn7ZD2NoxQpqPHB/aH4V++FShloSQKlEPEtGfQPlGDu1T+Aexw1mTXpLgHnjy2mXYeIs
         79hFLbqTRyD5BKXFuIBEAFIBAoaDhCOad7OJiiAWZ+HwIM5OYSXsPq4nNEriifCyPqqH
         DjnQ==
X-Gm-Message-State: AOAM531lc5HgUBPSFkuuF2eM/Ixswetrpu/4GBWv/SctRQ09K0p0TEBA
        PlKwIpgJscPt/d0QJUWlBzM=
X-Google-Smtp-Source: ABdhPJwXtQda0DLV083DLiaouxqH5RiPw+TsjqvllgYZzPUmjGoLQ31+BMrf27JAnmQLYg/w1UwQgw==
X-Received: by 2002:a92:3007:: with SMTP id x7mr2689146ile.141.1603209871738;
        Tue, 20 Oct 2020 09:04:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f13sm2462907ilf.85.2020.10.20.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 09:04:30 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 20 Oct 2020 12:04:28 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
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
Subject: Re: [PATCH v2 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201020160428.GA3233355@rani.riverdale.lan>
References: <20201020121856.19427-1-joro@8bytes.org>
 <20201020121856.19427-4-joro@8bytes.org>
 <20201020141259.GC2996696@rani.riverdale.lan>
 <20201020154812.GB22179@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020154812.GB22179@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:48:12PM +0200, Joerg Roedel wrote:
> On Tue, Oct 20, 2020 at 10:12:59AM -0400, Arvind Sankar wrote:
> > On Tue, Oct 20, 2020 at 02:18:54PM +0200, Joerg Roedel wrote:
> > Why use r10-r12 rather than the caller-save registers? Even for the head
> > code where you need to perserve the cr3 value you can just return it in
> > rax?
> 
> It can surely be optimized, but it makes the code less robust.  This
> function is only called from assembly so the standard x86-64 calling
> conventions might not be followed strictly. I think its better to make
> as few assumptions as possible about the calling code to avoid
> regressions. Changes to the head code are not necessarily tested with
> SEV/SEV-ES guests by developers.
> 
> Regards,
> 
> 	Joerg

This is called from both assembly and C, but anyway, you're already
assuming r10 and r11 can be clobbered safely, and you just took out the
save/restores in set_sev_encryption_mask, which is actually called only
from assembly.
