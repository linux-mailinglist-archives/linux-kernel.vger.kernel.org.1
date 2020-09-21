Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34374271E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIUIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:38:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36324 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:38:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id v20so16082981oiv.3;
        Mon, 21 Sep 2020 01:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pa6G2bx61W/Cf4WZHIkwrfJ5Kz2A4o6ODkqkJ4p7GqA=;
        b=SqNtkDn63EQRoH/HX02/foCj9z4yc6Q4ULNtqTBPoOaMkFaLQxoBTld/XoZVlGOhqb
         Kt0AfLOdxmtb35lqCXoQjjsuvfXUKGbDhGlyguoOEJXEPaR72m7wf5NMEzVyTXAla5fF
         /safK1sRbGqW3BWevKkuKyLKlozJ1oTJD1rC+F0j6sTQmG3sb4cZU8ygdkT2JznsLW/e
         sdEpdb96tnoxcT1vxVEZoZSsaI7FhWjtk1ArTGOamrQFaOWxWJ/buRJDtUf8LC1w8gqV
         ySkCSdop5nbjzJg/RA+P2CEPTJYmRPmAIv8h8VWrjGreX80JvnmCGRiygh07dD+U2Qe3
         WMBA==
X-Gm-Message-State: AOAM531rFBxaUo9KmR1timwja5c4z9aXs1yOcCsgaB60VFjFyQLK228H
        KszNFtz7MhddPpNLm7R2hJXU5FwccfPyxMG2KF6GAyGe
X-Google-Smtp-Source: ABdhPJxdfiBZSeHQ+m6gdcbod/Xp7BOk3ApwBWOI6WG/htW+WxutIfzqMqym28SxpL9hK3U47rczY1qM7i1pISxqEvo=
X-Received: by 2002:aca:4441:: with SMTP id r62mr15963441oia.153.1600677532744;
 Mon, 21 Sep 2020 01:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200921082716.29247-1-geert@linux-m68k.org>
In-Reply-To: <20200921082716.29247-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Sep 2020 10:38:41 +0200
Message-ID: <CAMuHMdXCQ-FgPXHVjnXujMvi_tg12AzXo5i2+i=JAnUmeNci_Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:32 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9-rc6[1] to v5.9-rc5[3], the summaries are:
>   - build errors: +3/-5

  + /kisskb/src/drivers/dax/super.c: error: redefinition of
'dax_supported':  => 325:6

m68k-defconfig
sun3_defconfig
mips-allmodconfig
sparc-allmodconfig
sparc64-allmodconfig
mips-allmodconfig
powernv_defconfig+THIN
(many more reported in the wild)

  + error: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko]
undefined!:  => N/A
  + error: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko]
undefined!:  => N/A

ia64-defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba4f184e126b751d1bffad5897f263108befc780/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/856deb866d16e29bd65952e0289066f6078af773/ (all 192 configs)
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
