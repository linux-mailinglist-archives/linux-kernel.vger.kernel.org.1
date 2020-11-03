Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8403F2A411D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKCKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgKCKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:03:14 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A99C0613D1;
        Tue,  3 Nov 2020 02:03:13 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id c18so1484329ybj.10;
        Tue, 03 Nov 2020 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3U1CRIpx/MWyOqmEpa48IE1TM02vyyoxh0TJr6+0Jaw=;
        b=I2X1Xc7pOp9h2tU05SKde5aUeDYU9J+WbrRjOT8AmlQaQ+m+xqXnXP5sdZstRAOjSJ
         /6A3Kgr3+MkpVDqFv3hzwkwlRFzuMhIxU2OZe9TXEYdWuTyvKxEtZadoRo4adY9wN6bQ
         TJQ8eZBWZVoBd3MCktZT3K03SS5OYhoivEQLPJPd4DgPSiaUlE9ufgf4+yl0glz3tVdS
         N/iRrJZ0h2IJP7bUWmVZV4+oeY6mFLGTAEYfJGEscYabLCoO0Bx24VeMb4TBEcc2UnEs
         ubOJWUvBb9vpMjxMvRtJxEIAOkmoFp+24Z8fLCq3lptgBTNYP2h2K/YSWFcHASz2pYsn
         8l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3U1CRIpx/MWyOqmEpa48IE1TM02vyyoxh0TJr6+0Jaw=;
        b=KKjaRPQuOfz1n+TZAlaPRKTdvxi4gotgooAmgxXPLrMFylGDsZcJsa2QpnTN8oNxJO
         1tZbX7dkaDQMh73KvQuPXqHsZhHSEla+rNpIvH8IlRj21xYAEasIjF9FD3ZvzdtwWV76
         FXGaNpMe5VKIHIlL8bKJaf3j2bO09OGDrgqsClNMbK6TggUuwZkRUwSdt+f/cLvHzjRd
         xwL3nuKgKfOSdx/tzaNKyYWKVJ8HyNgcrOIqJ5IAb7x8w/FaiYCXrZ/IMo9XvOK7O/+i
         ai1hP7VcRb49NiYwXxCJnUsWPqtrwtewivIL8fg6CcVlnKaTIxtgD+C74GkDgDlXVbnq
         cIOQ==
X-Gm-Message-State: AOAM533LA9iQ13+KsQ82ukaO8kB37LGlyAzywBGjGWP6z63Ox8WGO4AE
        YV5g9EyGDPTdXGKmQt7brnHoiLg3xjTFSB7hk80=
X-Google-Smtp-Source: ABdhPJwFrA6yKwXiiNx0k7zymp/0xjInrlZ+6g5/M7+azUxS6iLhWvyJjYQGOed+fAcrzx4j3S4RAg1ZvSsBwsYR158=
X-Received: by 2002:a25:f81e:: with SMTP id u30mr27624153ybd.332.1604397793010;
 Tue, 03 Nov 2020 02:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-4-atish.patra@wdc.com>
In-Reply-To: <20201028232759.1928479-4-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 3 Nov 2020 18:03:01 +0800
Message-ID: <CAEUhbmU5jUpSAzJS3oN2i6igHXOXMAq2KR5yWhbx1q2_qF-FHg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] RISC-V: Enable Microchip PolarFire ICICLE SoC
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Padmarao Begari <padmarao.begari@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 6:00 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Enable Microchip PolarFire ICICLE soc config in defconfig.
> It allows the default upstream kernel to boot on PolarFire ICICLE board.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
