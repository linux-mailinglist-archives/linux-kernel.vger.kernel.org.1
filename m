Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50D26AF72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIOVTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:19:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbgIOVOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:14:25 -0400
Received: from zn.tnic (p200300ec2f0e42002ec71013b50744b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:2ec7:1013:b507:44b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EB7A1EC0268;
        Tue, 15 Sep 2020 23:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600204450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0nhb/nBrUMRLS0RjoFkD+iZGVigN+uyq9N3z7G1NsXs=;
        b=L1FxQ7fQ3D4eMkKh9TxjWt/3uTd1FgJkVuIbMb28B7PWal6zjXRkA5qbA5h1/jn95frdkS
        oseuA0L6/rWw+uuu0+iGFTarpFHw6kogBdLZ57cQ/HiZGZZAAC6FGKyPPlJqKj17yGEsev
        aA82+LGhlLNz19f9LgdM6MAvJbHBM00=
Date:   Tue, 15 Sep 2020 23:14:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915211402.GB14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
 <20200915210231.ysaibtkeibdm4zps@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915210231.ysaibtkeibdm4zps@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:02:31PM -0500, Josh Poimboeuf wrote:
> panic() is noreturn, so the compiler is enforcing the fact that it
> doesn't return, by trapping if it does return.
> 
> I seem to remember that's caused by CONFIG_UBSAN_TRAP.

From IRC: yah, CONFIG_UBSAN_TRAP=y in that config. But why doesn't my
clang12 generate this ud2?

gcc doesn't do that either.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
