Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710F28CF20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgJMN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJMN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:29:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B5C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:29:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ecc00e0dae233c87b7dc7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:cc00:e0da:e233:c87b:7dc7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E98F1EC04EE;
        Tue, 13 Oct 2020 15:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602595791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i+hEKJiajtto6JTq1NMKyrizEj2yU9W6t1lch/sEvzw=;
        b=KO0TXpV3UbmbdqyiD6Vi6Ws8r3IA7qX4kkNhTgEedh+LwNTvSH4u6O2LESZOWbeO+4ye5E
        k4wbQWDzOap+xPQX0pnhuA2J/M9QiHzrkEaDcZ3JJFPzn0PgtBbngrWqdDrt+0fyYnXmIK
        DXcAkmy0cGSmcA+w2fmcP61pOLhF+Vk=
Date:   Tue, 13 Oct 2020 15:29:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
Message-ID: <20201013132940.GE28215@zn.tnic>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
 <20201013111158.GD32151@zn.tnic>
 <25632026-b498-022c-f37e-444672d57ecb@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25632026-b498-022c-f37e-444672d57ecb@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 05:33:37AM -0700, Mike Travis wrote:
> I'm working on the correct code now, and I have UV4 & UV4A machine time
> starting at 7am (PDT) to test it.  The UV5 simulator does not yet emulate
> console initiated NMI from the BMC.

Ok, let me put it another way: is this simple fix good enough for now so
that it doesn't trigger the build error on Linus' tree or not? You can
take your time and do all kinds of fixing later but we need a minimal
fix *now*!

Pretty please?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
