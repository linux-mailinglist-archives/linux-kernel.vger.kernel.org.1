Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAF2C2006
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgKXIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgKXIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:31:51 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892E5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:31:49 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so8662419ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16QF7XhShhktCs4QGKdZlDBAWyTS6RGhCF5bhmI9nIU=;
        b=XKQu+a7MWxQNywkc5tChjFZhLkTlwFMs4SacKOtS1zcg+S92ttYuFtCfH2ATOJ5Zjh
         6TGaoDqak3t/uLXBEbi/VvoQF8q5/L80yWskqa8quj529FfQIYsOlej1HXriY3wu0CyA
         KANtvB4KScmqfn/J6zPmZ+KqbFswnARpu0l7sG7Ace0a6SgPhTFNn7U0iX3pxswsJUEZ
         Kfzi2su+V9351kCnkcnPm5bYeaMy+ZS3M1IyBzJ29qtO6fvza7JEUXOU9S0X8+GFhN85
         2p8oI+li0YP9v5H72ERFnodmVpDMNM+r0gPWQUeApbiGMx9soN0ay+6I/5Pd0E2rAVxM
         U81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16QF7XhShhktCs4QGKdZlDBAWyTS6RGhCF5bhmI9nIU=;
        b=NmIQ4i8UNb2MbQFA7Tf/S+mvVjYqiZIxWh0+FthMGJNO3E+vurkrE6MutQmGzKzMWR
         puJGgyl3U1I8J3uqlrlSdI6pwfydWwl8O4qI3yQQU5OjvL65Vz3B0LvnKfbaklSPVsMw
         8WjeEdMMUcYmOSegnH/w6uF/py4nT0fUpvLBbqHbbUW68KU4oJYD52xZLTSL6axzTZH3
         3MBm3wto4Lkm62BmligyeI+HRKO50HXtBqrTSVKZaigocRj1r/uEXj/2LL/PrbfEd8Es
         6IG9ARQ/0MDYZErhX/8nojEqZaPvYU1oqgbU+s2jWI0qbMlMlLIFeg7W02hI7ckhCf47
         Jsqg==
X-Gm-Message-State: AOAM531xv9s4kmtK+nTrSkAx6QbLZLwlRDXAG7HHJEscDg37doB4pIQp
        jAJ4Av71PVea3hzcczMAAS/csNHikEpZ9OnsnL3K0w==
X-Google-Smtp-Source: ABdhPJzdm74z6S8plIzDqYnOXlksQUFMLdzxuDdR6uL9Sl8hgVbkjIYKdKpoHzgGULA/DXjfo2LC4401wFjtMge48fo=
X-Received: by 2002:a2e:93cd:: with SMTP id p13mr1315195ljh.144.1606206706953;
 Tue, 24 Nov 2020 00:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113132429.420940-1-eugen.hristev@microchip.com>
In-Reply-To: <20201113132429.420940-1-eugen.hristev@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:31:36 +0100
Message-ID: <CACRpkdYdPp_ihSEHkPaLa0_mcX+8ypnPZ4dn0d-PY9Mes1XntQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: add support for fewer lines on last
 PIO bank
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     inux-arm-kernel@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:25 PM Eugen Hristev
<eugen.hristev@microchip.com> wrote:

> Some products, like sama7g5, do not have a full last bank of PIO lines.
> In this case for example, sama7g5 only has 8 lines for the PE bank.
> PA0-31, PB0-31, PC0-31, PD0-31, PE0-7, in total 136 lines.
> To cope with this situation, added a data attribute that is product dependent,
> to specify the number of lines of the last bank.
> In case this number is different from the macro ATMEL_PIO_NPINS_PER_BANK,
> adjust the total number of lines accordingly.
> This will avoid advertising 160 lines instead of the actual 136, as this
> product supports, and to avoid reading/writing to invalid register addresses.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Nico/Ludovic: can you please look at this patch?

Yours,
Linus Walleij
