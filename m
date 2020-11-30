Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF72C85CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgK3No6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgK3No5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:44:57 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1832084C;
        Mon, 30 Nov 2020 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606743857;
        bh=RuL1VPb/aH3ouO0yRSUZBs5Sdi2gPTNK5Jp6oAALH5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RgLE1V08ucz64n1ocMed+WEWNV+LReCz0rhZPNUYglqauUixajLLZS0ySCRJmtQdZ
         XZ78OspTY3dDraF1qyqJR9uZpSywTiaTsYfs6AyC6oHM4Fr51ckx+84A3ltNmY1xYt
         qEXIAYod6LD+6k976Bn5d71NrwoGAYfA9a5a+yYw=
Received: by mail-oi1-f178.google.com with SMTP id v202so14126328oia.9;
        Mon, 30 Nov 2020 05:44:17 -0800 (PST)
X-Gm-Message-State: AOAM530twa26Ydfo6r+0aHLk1Dz5+tnbB/42NdFpSxuetI94IA/Nk24c
        ZPR3WTIZly66odlk6vDUGmkzOEoslaVH2nvcGy0=
X-Google-Smtp-Source: ABdhPJwEQ1XYt0NhUsEH8AoSwfpK7gARdHvypcO5F5o8vmSxNJbh+Q3XTUjF4p8KSSTk+sTK7WHpVBI4Wt+LTzFbsZw=
X-Received: by 2002:aca:fd42:: with SMTP id b63mr3731072oii.11.1606743856339;
 Mon, 30 Nov 2020 05:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-9-daniel@0x0f.com>
In-Reply-To: <20201130131047.2648960-9-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 Nov 2020 14:43:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2oqc51Aw7fyjW7t_zzRYX4Xxa7SS72faj7zvcZfyuaFg@mail.gmail.com>
Message-ID: <CAK8P3a2oqc51Aw7fyjW7t_zzRYX4Xxa7SS72faj7zvcZfyuaFg@mail.gmail.com>
Subject: Re: [PATCH 8/9] ARM: mstar: Add smp ctrl registers to infinity2m dtsi
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 2:10 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> +&riu {
> +       smpctrl@204000 {
> +               compatible = "mstar,smpctrl";
> +               reg = <0x204000 0x200>;
> +               status = "okay";
> +       };

You probably want some more specific compatible value, in case there are
multiple SoCs from mstar that have an smpctrl block and they don't all use
an exactly identical register layout.

     Arnd
