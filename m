Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5862CFD55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLESbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgLES3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:34 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B279C061A52;
        Sat,  5 Dec 2020 04:00:48 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lt17so12633523ejb.3;
        Sat, 05 Dec 2020 04:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWSMmsvdVxKuhpolz3WcT+qZQ+fgvXEXAvPTAffLCug=;
        b=JGTwmA59uEWRI9bUaJeGOFF+xIu95XoNUPVI/CLOTHAYfP1PlV2PcstarnBgaw+uqq
         0BFRwsas+fer8FycAZykr/aPOLgwXk7o7EPyl/MIzK79L6h2rzmK9bu38Fz58FbUO/fp
         p+PyeH8eEewFfQST55Vi/wcHH7WVCRb4x7Xnik4gZED+pVgjKAzjCuy6w6s8nqAYihcU
         bHZrdqeJYRmqINi+tf947SaiT7mW9PZO5wbtZer9kbznpSNZ0M/QGmMZwjaUd+/BFpuF
         ckwwqgGRs8XFHrp0/kHZy4Su22zDpzBDzs0QKqAmHPnxQcsfJ65xNKtHhhnsWVzI4KuR
         dWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWSMmsvdVxKuhpolz3WcT+qZQ+fgvXEXAvPTAffLCug=;
        b=gXaUgjzM4Dz4eUcHE8ONlhnBU6I5n4QkfUb0mI6B+sMCB3gpnyVAFvVY2Nbt2mT2ZY
         YhDmRy7EI9lGscYd57j5JfgYFq2b+sY81u1eSmp2ApXdNdJO9e/WlDtwcWVYfkUsRYu4
         VYa3V21P0ohwyg9Pi+JcddFW29+luKPa+7z8EQTe4+J2COIr8ruAIJVakzvok9WdfhOb
         6o7MNnHzC/AJ/pja1MHCJICjhdU1Rt4tfDLtwPL9MEhCdnz3NX/VGnuqPXhZLUq9nQol
         S0GQ1Cb8diqg8wG++GlbW7lhz5INrNdHiHfNGu5FKGz4ND25BU6oiLtvtUFNgNwQPb9F
         yWPQ==
X-Gm-Message-State: AOAM531E70M+flhWl/nwC0Qulb2NdR4cDkgLbaHSv1M2BygBkFknDNZW
        aw3gfsBom6xVLaevrlWnwICKFRk4DEggPfmNU28=
X-Google-Smtp-Source: ABdhPJzi9TxnxflMPPIdMv5ysTacLOy22Wk29jrF7FMrEzCTyuy6RWv3UxhJOkFjmXv+gVQ1YbCviUMBuPaxRPujetg=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr11055133ejz.2.1607169645914;
 Sat, 05 Dec 2020 04:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20201130060320.GA30098@anyang-linuxfactory-or-kr>
In-Reply-To: <20201130060320.GA30098@anyang-linuxfactory-or-kr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 13:00:35 +0100
Message-ID: <CAFBinCA=A+M0dgebTRF3y6chd205HN5ORgqBxw1gpu++7QC8Rw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson-sm1: fix typo in opp table
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 7:04 AM Dongjin Kim <tobetter@gmail.com> wrote:
>
> The freqency 1512000000 should be 1500000000.
there's a typo in "frequency". I hope that Kevin can fix this up while
applying the patch

>
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
apart from the typo above:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(while reviewing I noticed that we generally use 0.3V less for each
OPP table step than the downstream kvim3l.dts - that's a discussion we
need to have elsewhere though)
