Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE526C86A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgIPSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgIPSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:48:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1BDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:48:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e00d1c41ee080a628ee.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:d1c4:1ee0:80a6:28ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D57441EC03A0;
        Wed, 16 Sep 2020 20:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600282093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BUNm3OyFKLbQvPjWFNGky2tnyyTQWNxcWS/uGxVfZE=;
        b=ejuT2d57ytQMOgMiRxBO3CrANdRM0j9MvgVdMPwWWl9Wbg6kfB/yJVx5ALVfr334OSlnob
        SBB8PaKEwetjP56Rgjz5NpLqUnqp9JbFlBGOZVH4vPW/iy2j0pRY6PWUKCTMgp4EvUDD8m
        BaAiq+JcCJH5GGjxprpOz7pvYkH2/YE=
Date:   Wed, 16 Sep 2020 20:48:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200916184804.GS2643@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
 <20200915215054.GA1104608@rani.riverdale.lan>
 <20200916113449.GH2643@zn.tnic>
 <CAKwvOdkjAHv_=+167x6paXpO6QsEEPivZd=tj+WGpzg+pKjgtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkjAHv_=+167x6paXpO6QsEEPivZd=tj+WGpzg+pKjgtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:28:26AM -0700, Nick Desaulniers wrote:
> pt. 3 https://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86-64/

/me adds to the read list.

> ...2014, jesus...
> 
> "But you never can tell exactly what the compiler is doing. It doesn’t
> always come out the way you want. Like a dusty pane or warped mirror."

Fun quote that. The rest is also very entertaining...

> Seems I'd learn more about that than I'd could have ever envisioned...

Thank <Deity> there's inline asm. This is also why we don't trust
compilers, not even when using builtins. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
