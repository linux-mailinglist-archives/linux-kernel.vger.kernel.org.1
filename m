Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95C2C7ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgK2SmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2SmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:42:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C5C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:41:37 -0800 (PST)
Received: from zn.tnic (p200300ec2f2658005ddda28e79f318b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:5800:5ddd:a28e:79f3:18b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DBF71EC03FA;
        Sun, 29 Nov 2020 19:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606675294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kngO1dRzpIyC09uaDEWNOHR1IK8qESegfQKKFYzLUQg=;
        b=CmJ6M9PIQxiiaY8wq8sBTvE0EIX0NqLU3RTwOEGcGEa1utt0sgC+X8D/J3PXKf0grA4ceo
        xBwljsYeYJ6ZPe4aOFtQ/YQJV/uO9TQsdrhP1dDHNhvvxcL9pI6hWdw9LAkTd8VAqtNg61
        5+hvb4T/SC4hvQkS7iw7GoNAB6In5Cs=
Date:   Sun, 29 Nov 2020 19:41:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] efi/urgent for v5.10-rc6
Message-ID: <20201129184129.GB10404@zn.tnic>
References: <20201129104209.GB12056@zn.tnic>
 <CAHk-=wiaj3E-UWvwQVuBYzy+=T8MmTyqzFJ34u5sY+Yt9Vnj2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiaj3E-UWvwQVuBYzy+=T8MmTyqzFJ34u5sY+Yt9Vnj2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 10:32:31AM -0800, Linus Torvalds wrote:
> This is not a problem, it's just a note for people to try to avoid
> surprising me..

Oh, sorry, forgot to mention: he surprised me too and I asked. He said
he's updated his subkeys, yeah, perhaps because they're about to expire
and the updated keys are here:

git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

commit cd6bb63b8f84d50b17050f21ec657c3882bcf72b
Author: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Fri Nov 27 10:04:21 2020 -0500

    Update 3D200E9CA6329909 (Ard Biesheuvel)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
