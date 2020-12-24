Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B22E2592
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgLXI4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:56:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59232 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLXI4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:56:18 -0500
Received: from zn.tnic (p200300ec2f0e530094f4200f7ad20a46.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:5300:94f4:200f:7ad2:a46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3938A1EC0453;
        Thu, 24 Dec 2020 09:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608800137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+Tza7xSUzo+dq1Adw8Luii3U8dAhT2UD7gbFs83zlx8=;
        b=PNfRnUo9QPbtTCEDGq4lNQzBxwiJwPtykXcvr1XaLlEEEHMrOP9j5P0I1JFwm/po4EKmiL
        EWKhYdHF4HKThcNe0qdilcMAVXdpjkF+Skohbx6YBJjbAK48Gd+4A+icoYzX4vnWIFfbze
        89ifoeE023yREAN+Ok7mdFXc/QaClyQ=
Date:   Thu, 24 Dec 2020 09:55:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
Message-ID: <20201224085533.GA5108@zn.tnic>
References: <202012180909.WhlTpWrS-lkp@intel.com>
 <20201223183606.GB29011@zn.tnic>
 <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com>
 <20201223210405.GB28724@zn.tnic>
 <CAMj1kXG58+DdfA9RDE9gnELf8ZT0dTX+g8D+3W0pVM8RUSF_OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG58+DdfA9RDE9gnELf8ZT0dTX+g8D+3W0pVM8RUSF_OQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Dec 23, 2020 at 11:43:45PM +0100, Ard Biesheuvel wrote:
> I hope this report is not holding up the PR for efi/core?

I was just looking at that yesterday...

But nah, lemme send it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
