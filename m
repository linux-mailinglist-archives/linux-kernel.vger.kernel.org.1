Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D9126AC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIOSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:38:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgIOSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:02:22 -0400
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 093451EC01A8;
        Tue, 15 Sep 2020 20:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600192907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YJ4+RfMP5JuxEQmTK3M3Od/avV6LZmSclkOLF+yYwn0=;
        b=X790oYgWAdSPujkzfLKywkZiwQ2yxyQ7GKiYqykKwKyaKPFf37ISDH8MWTeKngV3KcXdOO
        XskFiNrMnyS7jpiOpd7S/4/Dm39e4+wBLvZTOUwik8bA+SyAPHSjF+hV9ZCXsOXgkcd8iF
        Fzi1zVOx/ZTIrPljgzcz/RkjYrHNsrI=
Date:   Tue, 15 Sep 2020 20:01:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915180141.GU14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <20200915173430.GS14436@zn.tnic>
 <CAKwvOdnqJJ8Ot6sRvVUTyuwA_zhRQXOnMU9KS6aVcTqRGb3JmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnqJJ8Ot6sRvVUTyuwA_zhRQXOnMU9KS6aVcTqRGb3JmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:41:24AM -0700, Nick Desaulniers wrote:
> We want them finding bugs in unreleased versions of the compiler,
> before those bugs in ship in release.  This is a good thing.

The bug report should probably say that compiler used is an unreleased
one so that I can prioritize better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
