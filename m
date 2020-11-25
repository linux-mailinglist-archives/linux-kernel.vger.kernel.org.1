Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4392B2C3ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgKYIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:20:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37234 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:20:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id l36so1501180ota.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoLRFUA0UOuCTDy7THZUgyhBhgqkrrondnvPvdrtcFg=;
        b=R+Ov534YJNaK8N3ICQYYpigigF3lfSh5CUowUVMTjziDoHJ1Jx/1on8NgDx4kbXyos
         2FYd/wItYqykYSnj/PO7KWNlyeNUfWsCeowfULnIQxH62JgQmWsHHCVCEpvtce/O7KFu
         U+yYg4oKAeEm+uqzb8KSiZLXJhkDazbqhrYk/bStkW58Vzb5l4QAYL78AIIxNMlu8GHA
         YAPJ8qVaedQj7fyhuTAYkER/1BGZQB13x4kcRFwOyeQ9PkZGjNiO+QwcGTkrzDafwPWF
         zPc3t28l6zJlhR6h1k1jLVVfcULfrups+vk/n7PEe8/fpuuF++kSrcCduAZHrRMQ2ssw
         w2Uw==
X-Gm-Message-State: AOAM531Ma3NsybpSoHi68FxYezCbIeuUTwHyYVYXk3FyzoIMPtbjwME/
        UC990WV+1V8hPNTekGyGIMDAt3d2+tfs89boc3iIqfBH
X-Google-Smtp-Source: ABdhPJxwvqnk8L+RYTThMXySQlr48viGfbU8m6s+yiQa/XSMu2Zf8WqhbfSOwgVCyYMHbrR/H3486uXECtcjzMisV+Y=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2041047oth.250.1606292422883;
 Wed, 25 Nov 2020 00:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20201124185738.3541314-1-geert@linux-m68k.org> <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
In-Reply-To: <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Nov 2020 09:20:11 +0100
Message-ID: <CAMuHMdX7FvJAPtGaAa1=V3X-LVA9oB+MK7GNg02pj5874MMLVQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On Wed, Nov 25, 2020 at 7:14 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> On 2020/11/25 3:57, Geert Uytterhoeven wrote:
> > There is no need to enable Virtual Terminal support in the Canaan
> > Kendryte K210 defconfigs, as no terminal devices are supported and
> > enabled.  Hence disable CONFIG_VT, and remove the no longer needed
> > override for CONFIG_VGA_CONSOLE.
> >
> > This reduces kernel size by ca. 65 KiB.
>
> Indeed, nice saving. Just tested, and all is good.
>
> Can I squash this patch into the 2 defconfig update patches of the series,
> adding your signed-off-by ? Or would you prefer that I keep it as a separate patch ?

Feel free to squash it into your queued updates.
No need to add my SoB, as the full updates don't pass through me.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
