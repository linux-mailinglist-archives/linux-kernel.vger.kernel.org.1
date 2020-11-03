Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB832A504C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKCTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:43:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC04C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 11:43:14 -0800 (PST)
Received: from zn.tnic (p200300ec2f10e000b5af706e7587131c.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:b5af:706e:7587:131c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EAB01EC038E;
        Tue,  3 Nov 2020 20:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604432592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s20lbrgEDsc4WSu7Qsj8Gt6zxFhSJ1ztaL+SKkbtkYI=;
        b=g2rJ057YJA7m/XigLsb3XxvbJLF+gil4mXy1/Of4vt70uWWrFYiqDQFV9KN617auQUR5t0
        3ycbv7QCql8xxctB3I7K3Uv4tW5oMBf0nT49n/3zWWOAtu2gsd1uSlk5EGdwaqFeV0a+SS
        fA8RdH0BEIqw0BxxqOxDXr0PT3ADF+s=
Date:   Tue, 3 Nov 2020 20:43:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201103194300.GG4111@zn.tnic>
References: <20201102145657.GD15392@zn.tnic>
 <20201102160901.GU2672@gate.crashing.org>
 <20201102171950.GF15392@zn.tnic>
 <20201102181000.GX2672@gate.crashing.org>
 <20201102183430.GG15392@zn.tnic>
 <20201102200113.GY2672@gate.crashing.org>
 <20201102225439.GI15392@zn.tnic>
 <20201102231809.GC2672@gate.crashing.org>
 <20201103164435.GB4111@zn.tnic>
 <20201103184739.GL2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103184739.GL2672@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:47:39PM -0600, Segher Boessenkool wrote:
> > Oh well, should I open a low prio bug, would that help?
> 
> Sure, thanks!
> 
> > I probably should test with the latest gcc first, though...
> 
> Yeah...  FWIW, I tested with
> x86_64-linux-gcc (GCC) 11.0.0 20201015 (experimental)
> so I doubt current ToT will have it fixed, but who knows.

Ok, I'll open it and put you on CC and if they ask me to test latest, I
will build gcc from git.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
