Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CF28EEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgJOIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJOIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:47:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5410C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:46:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a72so2267570wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfnRK5cVX6azZMqBqUfHbjQvOcd148r5sIa6MP8wh/A=;
        b=JI3OP/nkE9bQKpG4ifkR4FVb7nHZOMWL3s8qxbyik9PVQ4XLBy9KO0qkeph94YyP6k
         XdN0rsvdqpxChgu91LUssRKNl7ip1VnuhMGRkRKrDCF14x7AfGiOPtfexDHjO43qRT1o
         t3lCdy92X7IKvSLpKBTe/StmAOTBSt+duPBco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfnRK5cVX6azZMqBqUfHbjQvOcd148r5sIa6MP8wh/A=;
        b=EPsrXWmgTrxFKls+q6IGBMCaCsAo31u534SwQEfFwYOKL12tRb36LkNT7g1ccYaBnS
         PZ0X0qqWOyOnljWwUMgRW8dX5ZsmtR7dcnHinCkpxQ6kwmruApk0xfmXh0NHVjBrX/Ju
         ENuZQuCEsxKOr2/8N+zqkTfd2B8dg9crQpMEht3m63WelokXUug9pvCymk/pBWawnU5h
         C9gvT5OhwZKm7fYBOAR4wRG8nYg0WJe3C1Cxjn/6YHRe2rSNKHYar0T9qYwOD2Sz3DU3
         FPZFQpMpvuhbrZaPZVtkiMVYtVlAJhAQfWUwvz/8YYChw+n5nrf5QiRpbqwdwBGkkyLy
         ZrtA==
X-Gm-Message-State: AOAM531T13P2HM2GR/hrsHPc6tGyQcuDVQV5emi5DJik4RaIkDvj0VnE
        daVzYSgoEuD/+soReg2gm67DAxgEchHqUB1t6vaH+A==
X-Google-Smtp-Source: ABdhPJxNphEIA53NFxSRPBrfZeZ7M9POQUCzTal5jT3zSrlzJ58Sf7TBd3Eh0rkz0/EjjC/ILesmCAQSDCdKDvrKunM=
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr2998028wma.4.1602751617285;
 Thu, 15 Oct 2020 01:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201014131703.18021-1-geert+renesas@glider.be>
In-Reply-To: <20201014131703.18021-1-geert+renesas@glider.be>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 15 Oct 2020 17:46:46 +0900
Message-ID: <CAFr9PXmv-2h9prVuuWe29ae15LPtk-k0XUA04ywv8P7oiJpbRA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

This looks good to me.

Acked-by: Daniel Palmer <daniel@thingy.jp>

Thanks,

Daniel
