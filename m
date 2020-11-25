Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A82C38E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgKYGB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKYGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:01:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DBC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 22:01:27 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so673715wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 22:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/Y/9EeumrjJ4YYQypT1GLlT5BM+5I8sD10B18T8n3M=;
        b=DHvLHIwfcXdJ6X2sqR6B6780le2ANtUbawW9irRS+dS0qEEgn+QKO8wZWKqxyx/bFw
         ERCaaq0frsbO/xeBQ7D9X5XMsryZb6RmHD9g44jXufKYDzbEx8HB4eOMXyizzNaKk11t
         Pmr3aTyKEwWEzpEciHdKkDQsITfj9rynhQ/0ywoEnrE+RZ81efo1w0EbsWs9P3TW4cZF
         Jfbd3L+0fyAy30kT0d1YaOXsfGS9kFl0u+fOqSxoowKau0wlAHtGhKc1tf4Twvd6Sxw7
         COd0c0GFQ3ZPscOxcTse+la4HBMAL+W7qoy2TeYCoOVFS8mEhLKhInWgxmTNf2WieUgM
         qMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/Y/9EeumrjJ4YYQypT1GLlT5BM+5I8sD10B18T8n3M=;
        b=U2BgsU1jqOF6bR6CPmQ9WhvToQ0Pdlth8evyecPfkmoU2bHYr3RvKyXCRBeBK+Akb7
         MzYNMSQrSSDyihh4XYmr3wlgmkm1UJq4F+wKmYC6KO5T48mCoopLm5Lx8C4P5yWbw02a
         feMITv2dXEhkm2oSwAKj2IVIGiUYF84ZpnPGSDjPk1uW/3WaM5YKZoDkDnsZ6AZX5XQ8
         9wrJ1XYqKi2h3vSJzvQR3MFUI+JKbSl/CCWcXeh0KOhiuCBHtH4ms+XFCKAiwYqL7yga
         T4zVsu1tZp2U83nfIejSzFEXZNdRywHVU4by2eGlcTVmU6gJSQ3WYcz+6Yy4H3SdS61W
         bkvA==
X-Gm-Message-State: AOAM533+QSrxtYk2XhOC3fm3PdFzJuySoMefGxEnxzfbHUSMXZnHaWjC
        u+CTOIai7xMesmn2I4z3jRc=
X-Google-Smtp-Source: ABdhPJz1pzEjnoD5lzDBGgdvh69A7h1tsxub8SlBj7DrRPELehPva6hu6NXenMQhwdqLVBV6jhJetA==
X-Received: by 2002:a5d:570d:: with SMTP id a13mr2027496wrv.193.1606284086344;
        Tue, 24 Nov 2020 22:01:26 -0800 (PST)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id h4sm2621660wrq.3.2020.11.24.22.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 22:01:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 25 Nov 2020 07:01:24 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Ubuntu mainline kernel builds now failing not able to find
 module.lds file
Message-ID: <20201125060124.GA25831@lorien.valinor.li>
References: <CAH2r5msNpjEaBV2er7anqRsDE-9vYRZnsDif0+odOJAYL_aV6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msNpjEaBV2er7anqRsDE-9vYRZnsDif0+odOJAYL_aV6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Oct 30, 2020 at 12:43:24AM -0500, Steve French wrote:
> I typically build cifs.ko for testing using the latest Ubuntu mainline
> build - but building a module in the 5.10-rc1 kernel - while booted to
> the 5.10-rc1 ubuntu mainlinekerel - e.g. "make C=1 -C
> /usr/src/linux-headers-`uname -r` M=`pwd` modules
> CF=-D__CHECK_ENDIAN__"
> which has worked for years - no longer works.
> 
> make: Entering directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'
> make[2]: *** No rule to make target 'scripts/module.lds', needed by
> '/home/smfrench/cifs-2.6/fs/cifs/cifs.ko'.  Stop.
> make[1]: *** [scripts/Makefile.modpost:117: __modpost] Error 2
> make: *** [Makefile:1703: modules] Error 2
> make: Leaving directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'
> 
> I don't see a file in scripts/module.lds in
> /usr/src/linux-headers-5.10.0-051000rc1-generic/scripts directory
> 
> copying from scripts/module.lds in the 5.10-rc1 git tree to
> /usr/src/linux-headers-5.10.0-051000rc1-generic/scripts fixed the
> problem but was wondering if this is just a packaging problem with
> Ubuntu (missing a file in the kernel headers package for their
> mainline daily builds?)

There is 596b0474d3d9 ("kbuild: preprocess module linker script") in
v5.10-rc1 causing this. So likely the packaging will need some
adjustment to cope with that change?

Have you by chance verified it is not a problem with the upstream
targets?

Regards,
Salvatore
