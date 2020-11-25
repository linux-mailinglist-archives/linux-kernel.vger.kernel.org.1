Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422FA2C3B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKYIrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYIrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:47:20 -0500
Received: from linux-8ccs (p57a232c3.dip0.t-ipconnect.de [87.162.50.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E9220637;
        Wed, 25 Nov 2020 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606294040;
        bh=b70jtQ7plV/gEpUTh+1kIWUoa7Xktv5QXVN9r9gbJG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU4mXEo2thN40zHe/6xYm9HLn9Hv2bUvK1pLCnCtR9p0lnhMJWdb9uwdX+1JoHIWs
         3Fdqhoq72cOdXF0AipFThNeto9N8pRDK0XOo5bm190G3Zes1OfuyCGtYFiRO5HHerT
         ylbmVTlnB1h4RCIH/3y972O4Daquo4Wc49nFsQ18=
Date:   Wed, 25 Nov 2020 09:47:14 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Steve French <smfrench@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Ubuntu mainline kernel builds now failing not able to find
 module.lds file
Message-ID: <20201125084714.GA11793@linux-8ccs>
References: <CAH2r5msNpjEaBV2er7anqRsDE-9vYRZnsDif0+odOJAYL_aV6w@mail.gmail.com>
 <20201125060124.GA25831@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201125060124.GA25831@lorien.valinor.li>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Salvatore Bonaccorso [25/11/20 07:01 +0100]:
>Hi Steve,
>
>On Fri, Oct 30, 2020 at 12:43:24AM -0500, Steve French wrote:
>> I typically build cifs.ko for testing using the latest Ubuntu mainline
>> build - but building a module in the 5.10-rc1 kernel - while booted to
>> the 5.10-rc1 ubuntu mainlinekerel - e.g. "make C=1 -C
>> /usr/src/linux-headers-`uname -r` M=`pwd` modules
>> CF=-D__CHECK_ENDIAN__"
>> which has worked for years - no longer works.
>>
>> make: Entering directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'
>> make[2]: *** No rule to make target 'scripts/module.lds', needed by
>> '/home/smfrench/cifs-2.6/fs/cifs/cifs.ko'.  Stop.
>> make[1]: *** [scripts/Makefile.modpost:117: __modpost] Error 2
>> make: *** [Makefile:1703: modules] Error 2
>> make: Leaving directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'
>>
>> I don't see a file in scripts/module.lds in
>> /usr/src/linux-headers-5.10.0-051000rc1-generic/scripts directory
>>
>> copying from scripts/module.lds in the 5.10-rc1 git tree to
>> /usr/src/linux-headers-5.10.0-051000rc1-generic/scripts fixed the
>> problem but was wondering if this is just a packaging problem with
>> Ubuntu (missing a file in the kernel headers package for their
>> mainline daily builds?)
>
>There is 596b0474d3d9 ("kbuild: preprocess module linker script") in
>v5.10-rc1 causing this. So likely the packaging will need some
>adjustment to cope with that change?

Yeah, likely it's a distro packaging issue. We had to account for
scripts/module.lds recently on openSUSE for example:

    https://github.com/openSUSE/kernel-source/commit/fe37c160c33dc09edff1781810aa098a2c316e20

Jessica
