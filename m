Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88621296D06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462486AbgJWKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370826AbgJWKrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:47:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2693F20FC3;
        Fri, 23 Oct 2020 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603450028;
        bh=G2EaU4mWljkQC6TVUEJFwltCjR3+RIJPSAcW6gMXBoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OAEIp75kVS0ePYn8KtHw99JSRG9TYI1CdIZtu8KMZZx4A3W+TsriI78qTUnac5m2I
         YqfQHle/hWUR6H9cuq1fjW6xQGSO9AfKpQiEnhpOIVqOmldHOr+OIgvHK3DQUV3nBY
         NzrXPZQ8+vUNscB2QVijn0lCuilG8piEOGHDQLXI=
Date:   Fri, 23 Oct 2020 19:47:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-Id: <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
In-Reply-To: <20201023093254.GC23324@zn.tnic>
References: <20201020143746.GG11583@zn.tnic>
        <20201021095013.d82637f84af564ae4363189d@kernel.org>
        <20201021092750.GA4050@zn.tnic>
        <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
        <20201021164558.GB4050@zn.tnic>
        <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
        <20201022093044.GA29222@zn.tnic>
        <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
        <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
        <20201023182850.c54ac863159fb312c411c029@kernel.org>
        <20201023093254.GC23324@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 11:32:54 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Oct 23, 2020 at 06:28:50PM +0900, Masami Hiramatsu wrote:
> > OK, would you think we also better to integrate it with insn_init()?
> 
> That kinda makes sense because it would obviate the need to call it
> as user of the interface but simply do insn_decode() which will do
> everything for you. Lemme see how it works out in practice...
> 
> > Borislav, would you handle it? I think you already started.
> 
> Sure, I'll have a poke at it.

Thanks! I look forward to it.

-- 
Masami Hiramatsu <mhiramat@kernel.org>
