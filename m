Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A23049E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbhAZFUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbhAYJrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:47:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF59B22D02;
        Mon, 25 Jan 2021 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611568008;
        bh=wrKmysGam3Lwbbad0YKj9d4UiWR6n9OsdTZ6BQwDYiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPW3GoROsrSnoLgyT9gB3S5qpvLx20z1OVwQPLQpSsfM1qIwOckhVyFr7vhEj6anM
         61cdjnbk8NcHstneAwrQ9BolM5gFnq4cfHRhVUkwxC9Hxi1m0888Kdu30f78ajcfAc
         DWpjzDIcbjj7tDUFJFfvWbucHPmzqLAKb4D114S6evPdbGkfeta02MBnY5IMcgHSxN
         Ze1D+lr1onk7U2BecZnXQ5eR3f1u39SNNl7BiSbI4w50rx49C8ClLtLRAP60apZnGP
         T/wA4wGR1WtnLvE9ReQ9cVQdx8gMeGTmhe1k5++Ab4dRwckztDCyRe1MB3bkN9q4fa
         H8elj8qnapEag==
Received: by mail-oi1-f171.google.com with SMTP id h6so12761390oie.5;
        Mon, 25 Jan 2021 01:46:47 -0800 (PST)
X-Gm-Message-State: AOAM533GIohC+vOnaHGDY7X+WsMh0efqeXvESAxNwdsZ4BWqPLyndeVS
        j+viLKOkD3fJA+ZwtvW8aUgV157OV6uqfWpPDYo=
X-Google-Smtp-Source: ABdhPJx42+Adii4EyOsX4ocLFTXB6P6IugoyS3FcDYjL/7H7HMXnofNNq8fn3+tI38ZrpM7hQUY7tEUtGlLz1tSHdPs=
X-Received: by 2002:aca:be54:: with SMTP id o81mr616678oif.67.1611568007124;
 Mon, 25 Jan 2021 01:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20210123034428.2841052-1-swboyd@chromium.org> <20210123034428.2841052-7-swboyd@chromium.org>
In-Reply-To: <20210123034428.2841052-7-swboyd@chromium.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Jan 2021 10:46:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3NinqnO0udFp21DyB1gdqa=vdavWgEpysfJFFs=V5hjA@mail.gmail.com>
Message-ID: <CAK8P3a3NinqnO0udFp21DyB1gdqa=vdavWgEpysfJFFs=V5hjA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] of/device: Don't NULLify match table in
 of_match_device() with CONFIG_OF=n
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 4:44 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
> in of_match_device() for CONFIG_OF=n") because that commit makes it more
> surprising to users of this API that the arguments may never be
> referenced by any code. This is because the pre-processor will replace
> the argument with NULL and then the match table will be left unreferenced
> by any code but the compiler optimizer doesn't know to drop it. This can
> lead to compilers warning that match tables are unused, when we really
> want to pass the match table to the API but have the compiler see that
> it's all inlined and not used and then drop the match table while
> silencing the warning. We're being too smart here and not giving the
> compiler the chance to do dead code elimination.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
