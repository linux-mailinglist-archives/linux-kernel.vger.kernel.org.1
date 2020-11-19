Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8192B8E66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKSJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:06:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgKSJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:06:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED616221F1;
        Thu, 19 Nov 2020 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605776804;
        bh=z8lCOn1Jq20pJMTKv4u0xsatXRQad9hb8eDDEXLTGNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MezSjNaSmtGFSLPTdnvSSrvrfgcftCan467XzelpKHoQE3oNXx6X5BxrUUTOYjB0u
         c05W/EQ9hbjCzUAF1jKy7Vx5wbmfDs9itVFatLkxxKcGDWrh1xdHmkoCqBjlbYxJMO
         YFAE1MXeoL0j8wkfIz/PV/zm7+G2GpDT2Vppc7/g=
Date:   Thu, 19 Nov 2020 09:06:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
Message-ID: <20201119090639.GD3599@willie-the-truck>
References: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
 <CAMj1kXFr+1Khbisq2je41j_nFQnFhdYBW9bg+Ka5xbBJXHHkyg@mail.gmail.com>
 <f1c18bdb-69a5-9260-d931-69f6bc926170@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c18bdb-69a5-9260-d931-69f6bc926170@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:32:48PM +0800, Youling Tang wrote:
> On 11/19/2020 03:18 PM, Ard Biesheuvel wrote:
> > On Thu, 19 Nov 2020 at 02:45, Youling Tang <tangyouling@loongson.cn> wrote:
> > > We currently try to emit *.init.rodata.* twice, once in INIT_DATA, and once
> > > in the line immediately following it. As the two section definitions are
> > > identical, the latter is redundant and can be dropped.
> > > 
> > > This patch drops the redundant *.init.rodata.* section definition.
> > > 
> > > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > .init.rodata.* was added to INIT_DATA in
> > 266ff2a8f51f02b429a987d87634697eb0d01d6a, so removing it here seems
> > reasonable. However, it does conflict with the for-next/lto branch in
> > the arm64 tree.
> > 
> The possible causes of the conflict are e35123d83ee submit.
> 
> master branch code as follows:
>     ...
>     INIT_RAM_FS
>     *(.init.rodata.* .init.bss)     /* from the EFI stub */
> 
> for-next/lto branch code as follows:
>     ...
>     INIT_RAM_FS
>     *(.init.altinstructions .init.rodata.* .init.bss) /* from the EFI stub

That looks trivial enough for us to sort out, especially if this patch can
wait until 5.11 (I think it can).

Will
