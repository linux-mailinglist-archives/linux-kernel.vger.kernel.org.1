Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867E2D101E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLGMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:10:20 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36866 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLGMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:10:19 -0500
Received: by mail-oi1-f179.google.com with SMTP id l207so12224842oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf4f4C3kkK3xkC5PEHsF24NiLGtD172vjUD1vi5tQTc=;
        b=h1R90lYqlQeeq7ejT/nvdxtxLPKhs5LIAnRGnT2EBYdskUqfWt0CVRk775MC2PUL4x
         JMTDp9ORCIQuQk3Pl5hmCHHx5giMJl1fOemA3KFe5KjgekKk72+zSsmhA2mLHyc8hG1H
         SHFeKqjJkdpryxNLxydO/BjjISX/DPyKnrw7x/SPPu1jwUzE59pdpZ/pbLRdmtmVwxE0
         NsAorEXtSe4hVJ0JOZFMC9Rsj7Bi2JL3CB54u6Iqx76hAoZp7cJMG79Fv1V+N/qmhLmR
         W5xH3IRv2MMC4U33yM0d8nd9iGL3OazUpJa1sTLOhadIHOVQEoEP6yhVK9y0TUwTi11/
         ENbg==
X-Gm-Message-State: AOAM532AOolHa4aroNU00NSQqlQkNvbzFKQhUBYAJlpK8102pmA/3bpo
        mLMo35Wd/zORtrefBUjIripwQRW3HDHSFi8PqUSRABvlf7o=
X-Google-Smtp-Source: ABdhPJzYI6ZoWUYeRuiEWXBzV3L2dm+taMvez/yyxn0R4kK5f/y0seWKWMF7FQ1S68gN4HNmvqlbVLDaRfoSXkn00BI=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr12066693oia.148.1607342979004;
 Mon, 07 Dec 2020 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20201207120611.1315807-1-geert@linux-m68k.org>
In-Reply-To: <20201207120611.1315807-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Dec 2020 13:09:28 +0100
Message-ID: <CAMuHMdWJVgWmAOVDVcLfA7Hsv5h1tzqOt6EfgyB_eO_Jn+ESZg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.10-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 1:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.10-rc7[1] to v5.10-rc6[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/arch/powerpc/platforms/powermac/smp.c: error: implicit
declaration of function 'cleanup_cpu_mmu_context'
[-Werror=implicit-function-declaration]:  => 914:2

v5.10-rc7/powerpc-gcc4.9/pmac32_defconfig+SMP

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0477e92881850d44910a7e94fc2c46f96faa131f/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b65054597872ce3aefbc6a666385eabdf9e288da/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
