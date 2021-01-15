Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF2F2F7C87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbhAONZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:25:32 -0500
Received: from mail.zx2c4.com ([167.71.246.149]:52602 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbhAONZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:25:32 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 08:25:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1610716706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQ/8LhUhES3p9+qz+2B4zfj9MfNWaKOeeN32ZSckxSg=;
        b=P0njtjmNatlwZPgASO4weBlHczjSkiYbtz7BsdMVbSf1DH0Uj1NuDlH0H+2EoWrkq4IoWf
        J26Fw5F3RU7gKb7P2Q6EyZbwfsmeELA4s7flKbC1j0JFxGKDyoI/dsTEBSICTeXH/cDdiI
        suzhVdJIbdfWF8IBpwdn2zgK/asuMzg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d1e62be5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jan 2021 13:18:26 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id r63so4991226ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:18:26 -0800 (PST)
X-Gm-Message-State: AOAM533c4YNav7KhXKTHuzU8leYJjaYay0sh0JLBZl1gkzeRBTb+Ag9b
        x5PFUrShY44p5lcTpqSF48q/Zdd4LPfyBLyHAbw=
X-Google-Smtp-Source: ABdhPJwuz8Slp6N3jxoQpWtKn2gMMHSwUtD+/9nvEe1v0G1X0XuP5fkgMINHYC/vojcI8MmCqPYgyDim+XPsFa9n5+I=
X-Received: by 2002:a25:880a:: with SMTP id c10mr17896523ybl.456.1610716705769;
 Fri, 15 Jan 2021 05:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <CAMj1kXEg+22pejvof-p_z9uxNnf4yv+4ohAsJAo_LmtQ_+Bfmg@mail.gmail.com>
 <CAMj1kXECsVbO6tqmynSTmu-aGRKKBKSUSE3ZTzJgfCRozmK9Vw@mail.gmail.com> <CAMj1kXH2N_e722TiSU6_uUs_arjkBipwUnfD8=xj1etKE11DRQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH2N_e722TiSU6_uUs_arjkBipwUnfD8=xj1etKE11DRQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jan 2021 14:18:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9rs2qFrZa2wxF+aBEfRFcjXEsWZW+S60G-=Y4Q0NPTWsA@mail.gmail.com>
Message-ID: <CAHmME9rs2qFrZa2wxF+aBEfRFcjXEsWZW+S60G-=Y4Q0NPTWsA@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case it helps,

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

[resending, as my mail server got blocked from vger for a week and my
message bounced]
