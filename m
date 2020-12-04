Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171282CE93B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLDIJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgLDIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:09:05 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95134C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:08:19 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so6485868lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/mrV+UfekstzAPZAR/BZqgJBM8NTINvI5BvFSyhVb8=;
        b=MHHTKKLtN3X0h1uGCWutC9QXTyE9mKz66mm8ZrV50l6vVhQaBhP8wI5p2PmvjXx7Am
         xmFKqvBg273DblS1qUb7kBw77bPFLjKskN1hWyD/eX/bWH9gth78Xctjg8hcZMm93wp0
         8QmD4g/Wb25w95iwwDz+7nBdb/9sLpaWAy6B+dVs5++6T/CzcScZ5rvIqBouNKVlpIrx
         euvybfw4Z2mSVlPz5UJp5tpPNS1VkFhvFsKzTGHnS/ScZE02L7L8hPVrJ8bMbtSjxGVR
         qoSZnr3DuHgwmzdD8+1HLxPkD5S6fdgOsxTKIhKn1zv2ake5E+Hl9Yh8mtbtpm75ygX7
         /jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/mrV+UfekstzAPZAR/BZqgJBM8NTINvI5BvFSyhVb8=;
        b=FJmVXnegwrHp/EgPX7bKB74diYnoLhFKxbzBRYV5ntjQVpwAIwjlNMpcu9Sd/7J0nR
         TN1oUV3F2izSbDnTTyIlQl/NFojhGSTJ5ZgMQEsWrTcQGGJ9FIoTMr/EjP15gP4T0/F1
         mwyKRm7/e8j3hkLL1h/ojQDWLgwUUENsKuZwSFA3TDFWyKJPBRstZpWLoih1sow+4kT4
         ajfE3VcBZHgjlMAse6JmrCIKQjNeAeSzeN8TDzrvUompnjZMa6TeE3XbHrfTZq8Bgzgo
         cqLbiVUSNIWyVhD5cQnhoh2Emq66jvI0arJHr7rGSK7m51YQmi8rx34pXoyB3jJBQX2A
         ryeg==
X-Gm-Message-State: AOAM533MBGvJ2OwTMRCkm8J9GP7rE7gDeYauvFuiLCQgqAlmgixGsBaZ
        qyt8RzpYiQ/1mvw4HFN883kVe6jh3LkQwdBF5wIrQg==
X-Google-Smtp-Source: ABdhPJwhXqKTI0FGGRpsIW8hRJi7FEZBvm6KPPv3mkcz/LHy5rMukNUTMrIchrtkgGM8OBqsj3JDlGP1ChJ5p49UaPk=
X-Received: by 2002:a19:8d8:: with SMTP id 207mr2685981lfi.441.1607069298148;
 Fri, 04 Dec 2020 00:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20201118191314.4019887-1-geert+renesas@glider.be>
In-Reply-To: <20201118191314.4019887-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:08:07 +0100
Message-ID: <CACRpkdY5iTsW371gB334dXqr1H7iycd248y5k62ZUx9ceC7HPw@mail.gmail.com>
Subject: Re: [PATCH] ARM: uncompress: Fix dbgadtb size parameter name
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 8:13 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The dbgadtb macro is passed the size of the appended DTB, not the end
> address.
>
> Fixes: c03e41470e901123 ("ARM: 9010/1: uncompress: Print the location of appended DTB")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this in Russell's patch tracker.

Yours,
Linus Walleij
