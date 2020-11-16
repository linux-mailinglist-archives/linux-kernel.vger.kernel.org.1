Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578292B4055
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgKPJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:55:16 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45688 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgKPJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:55:15 -0500
Received: by mail-ot1-f41.google.com with SMTP id k3so15376178otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6lHjI94zzK7eLVsFL3eG2XDr/1Nb0qPcYi18jWCW9os=;
        b=gmUvbBwOZTtltxKCW9z2qc5u5KAUApnDvFMPuXz9QmJnm0IsBuAHoJffmj0q6/jJWd
         2aW94Nxs7bB8jOryRpbAXtEbtcjWWaN2Y3bquo444h3XUGPx80GcT9un3dJgcFPB7Gpw
         8Ry8k8j7gpZ08MGu+aBcQHXpoOOMmd1TjNeO+NoFpvvZwcRF8gc+twhmDGz1RxWzpsNj
         BC3EAGM0nGG01NZOasK6r06U5kMyYs9UnDnf3vE92G5oZdzfV6EDi+uGoJuYx13UsnyZ
         ZdZbZnEa2OVeBIembUmqhoLDTFKdK4CLVBr/IR9s+uPpbowglnABkmTI2U61G4ZTD27l
         i7Ag==
X-Gm-Message-State: AOAM531x7dWGM2QO3iyNlP2+3TVeN4m9X6/4N0lS/aKcaw9zZq4I+WFZ
        7g3HmaI4db/RpswSN0x1kVmk0ZvI5BJstEnirmtXWre/CP4Vng==
X-Google-Smtp-Source: ABdhPJyZ4tc3wstQv7O+PCfYbCAu9Zgl5i0wx4uyI8XrY3xR2QovxBnjJ//stAoPC15GbiGFuryvnGjscYITl1+IJ5A=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr9959036otc.145.1605520514815;
 Mon, 16 Nov 2020 01:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20201116094437.1878639-1-geert@linux-m68k.org>
In-Reply-To: <20201116094437.1878639-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Nov 2020 10:55:03 +0100
Message-ID: <CAMuHMdVZrzKi9Ui4OAZb7M5SPLCS26_ixx6rkNrfYZ4NgEpWBw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.10-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:48 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.10-rc4[1] to v5.10-rc3[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/drivers/iommu/intel/dmar.c: error: 'struct pci_dev'
has no member named 'physfn':  => 338:57

ia64-defconfig

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09162bc32c880a791c6c0668ce0745cf7958f576/
(all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f8394f232b1eab649ce2df5c5f15b0e528c92091/
(all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
