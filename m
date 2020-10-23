Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE90296C24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461516AbgJWJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461474AbgJWJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:33:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:33:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f8300d0366120c91f316b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:d036:6120:c91f:316b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA5621EC047E;
        Fri, 23 Oct 2020 11:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603445584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l3a3lBCQx52C+7Y2bgEPgUigXQ6ucl3whBYlrY70F6s=;
        b=WhDIm89y58vLGdXi+rEKgDRSUGFk/6gKPcYrHNb5gK+6bo9hwDiTXr9qc7AKa4YcxIglV5
        CzZO9/DGTaJgmrKTjS0fXAuVRP1LLJk4bfUAYQ3qA59v+zuTQUbedEgYbICQTMspIfQioO
        3iNWLdStDeafzwSP1sVYv4wGiL9ciZM=
Date:   Fri, 23 Oct 2020 11:32:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201023093254.GC23324@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023182850.c54ac863159fb312c411c029@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:28:50PM +0900, Masami Hiramatsu wrote:
> OK, would you think we also better to integrate it with insn_init()?

That kinda makes sense because it would obviate the need to call it
as user of the interface but simply do insn_decode() which will do
everything for you. Lemme see how it works out in practice...

> Borislav, would you handle it? I think you already started.

Sure, I'll have a poke at it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
