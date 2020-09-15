Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013D826AB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgIORwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:52:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgIORek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:34:40 -0400
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8B9F1EC0268;
        Tue, 15 Sep 2020 19:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600191276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vNLzZ6jdl4XE26ymVLkx3UZt+MAKjAlVuj2buEvQcDA=;
        b=fYQxFVvPEq0tzAJO6ZQocfUDhfmfUHtR45cSXIqA2O/ggTOkQ8fbgZ+WBUNtGboI6+IXvj
        hYlt5l/CLpCENMNZ5eBLdPP7nyrHapbjnrhZkxKdgfzgFUah4t/t00ZGMNUY/kqPSZrIQs
        mNY5eIELsPj0GqjwCyQfJnkqkjmhaQY=
Date:   Tue, 15 Sep 2020 19:34:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>,
        "Li, Philip" <philip.li@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915173430.GS14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915172152.GR14436@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 07:21:52PM +0200, Borislav Petkov wrote:
> I'm thinking clang12 is too unstable to take it seriously...

Yeah, I'm being told v12 is not even close to getting released. So why
are you 0day guys testing with it and reporting issues? Are you testing
unreleased compilers and reporting bugs against the kernel?

What's up?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
