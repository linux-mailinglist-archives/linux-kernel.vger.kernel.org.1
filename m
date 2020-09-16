Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A499226CD90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIPVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgIPQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2DC0698D5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:39:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e000ee699b54c433a91.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:ee6:99b5:4c43:3a91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 892AD1EC0136;
        Wed, 16 Sep 2020 13:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600256096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PTEjwjWCxnifqmay2schcOj42jghOVREf92+55yeao=;
        b=WFTrHxF7aRz7y3HdsqQHlVAeb4hm08P7tXBq736IBvFvIZOjHWA9xn9q1riewV2WbR9icz
        iiN5tWrJ/meR4p+KaiHlSbPKh+I+6uPtGCgPevihelODO0dFz3FambZKKFAwUEYD1CEt6H
        4NDo7BaAFj0otmUOpYlM3d6k3MEDils=
Date:   Wed, 16 Sep 2020 13:34:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200916113449.GH2643@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
 <20200915215054.GA1104608@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915215054.GA1104608@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:50:54PM -0400, Arvind Sankar wrote:
> On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> > 
> > (Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should not be
> >  returning, ever. :-))
> > 
> 
> I think this is because panic() is varargs, and clang doesn't support
> gcc's -mskip-rax-setup. The normal ABI requires the caller to set RAX to
> the number of arguments in vector registers.
> 
> https://patchwork.ozlabs.org/project/gcc/patch/20141218131150.GA32638@intel.com/

Ah, good point. Found this in the ABI doc:

"For calls that may call functions that use varargs or stdargs
(prototype-less calls or calls to functions containing ellipsis (...) in
the declaration) %al is used as hidden argument to specify the number of
vector registers used. The contents of %al do not need to match exactly
the number of registers, but must be an upper bound on the number of
vector registers used and is in the range 0–8 inclusive."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
