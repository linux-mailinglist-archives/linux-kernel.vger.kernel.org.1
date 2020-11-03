Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34DE2A483F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgKCOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgKCOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:33:56 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34713223BF;
        Tue,  3 Nov 2020 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604414036;
        bh=AI3MJKi+8NlG0NUnKfyZPXn/M3c91EUFPcLsQs6i8tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d0xeM5Ek6s5llXN0wLXs70r3pogcIHz2aoRJCG66YjkcXuoMBpDzlNTd3lXugHoj/
         EfzXrhtba2r55D6tfv8rsKGYxOcuBDYGaDXacTCyVG/coPkEzcUNUMADOoeMCy2d1m
         Dvj6sNVeQOoslVrH0fpPYBrbxkUXe5n/pzBNOTm8=
Received: by mail-ot1-f45.google.com with SMTP id m26so16095870otk.11;
        Tue, 03 Nov 2020 06:33:56 -0800 (PST)
X-Gm-Message-State: AOAM532vK5ruut7t2pzGIPfGYJk1FSl0kKTjhynNCshjyxWQTOISEQ+B
        Fu58+4wNeti5lJzSpMKozn47wzOHdpNdNfQs9w==
X-Google-Smtp-Source: ABdhPJy8vWxRn5WQaaoYci6+TPtyTE4+D6JKCjszw14qRN1DVkE0IhqL+Sc70WUTd9LPSglJzuWO3dH3H+FuH/6onDQ=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr14673770oti.107.1604414035551;
 Tue, 03 Nov 2020 06:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20201103135004.2363-1-peter.ujfalusi@ti.com>
In-Reply-To: <20201103135004.2363-1-peter.ujfalusi@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Nov 2020 08:33:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjhfT1-hb211uQXUVnM6fi44KiDaTtWmNuN0GTCyz8YA@mail.gmail.com>
Message-ID: <CAL_JsqKjhfT1-hb211uQXUVnM6fi44KiDaTtWmNuN0GTCyz8YA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: irqchip: ti, sci-inta: Fix diagram
 indentation for unmapped events
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 7:49 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> One space has been missing by the diagram update.
>
> Fixes: bb2bd7c7f3d0 ("dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling")
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>
> I'm very sorry, I did not realized the missing whitespace in the original patch
> and obviously I failed to run the check.

I'm assuming that has been done now...

Acked-by: Rob Herring <robh@kernel.org>
