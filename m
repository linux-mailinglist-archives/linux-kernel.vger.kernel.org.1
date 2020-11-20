Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2A2BA35F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKTHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:34:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42101 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKTHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:34:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id h16so7899979otq.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNNXqJ9ENfmgslaVj755f0wgkn0MqvtGANwyKwnps+U=;
        b=ahSFgDNPw6d6EqQsyjv86n/LtCvIS3bni8+4azEMFH0PWdVwWP3ViMHNAuSPKzXqLJ
         r2TEZ/EzRFTQ9324Sqd+g00yVN2Gz2LOlA0sPqrxMCW3hGKCtWnags3uu/yacAErnjzT
         4vY/E0upVOk1xXts2r5rS/lDJo0q3skPEKL3i1qzulH1gm6Rcs8PDI3LvFJrHHhxWuJ5
         pZ4bmmib4VQR8Yqu3BPbQNTREBSeryfJLRHs7qzg86xk+N4NSVxClPMEnSjEjww10bXs
         JUXUa4g3wvl3KnoCNyDy2RCIuK0dbVzMVWvtZwpOa4XhmvjRyxlk8KmEUnXnk11ASL7j
         aDmg==
X-Gm-Message-State: AOAM533o13/fOHJjhQgI2XdgMy1Z8i+gvaCw2PLvyOBeTUlwuRHjY9RY
        y9W0JtjoXmTaYhJpSGei5rSoiBmeeqXJ370Ymo9Zi5wbjs7uQw==
X-Google-Smtp-Source: ABdhPJxQXWdwAvfy3kzRBDaqKfWeJQ8FANhkQsarZdi2+r3ejjgPjBPOujM6dCfgNWlqiQvu8U8byIAm5fcm8EUhDNM=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr12104265oti.107.1605857692759;
 Thu, 19 Nov 2020 23:34:52 -0800 (PST)
MIME-Version: 1.0
References: <effef6339c919a4ef2e81a47e4383f712cdd7626.1605847196.git.fthain@telegraphics.com.au>
In-Reply-To: <effef6339c919a4ef2e81a47e4383f712cdd7626.1605847196.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Nov 2020 08:34:41 +0100
Message-ID: <CAMuHMdW08hPeD+Qe_HwzQCUjqkvawwrD+=oP6CvfKXeN6ds_VA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Remove dead code
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 5:51 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
