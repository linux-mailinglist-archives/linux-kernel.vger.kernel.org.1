Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7732D9129
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405965AbgLMX0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgLMX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:26:23 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55712C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:25:43 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id bd6so7051351qvb.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtQJ72HQtdfcAffC0RWWjlj3EllHxGw6h8fIo2FDXKo=;
        b=c20gFRT4k1+LbDU6DCix8rivM3H0Hven+F+jL8v26xgJLS/8Kq0bMQdJKaeXBFZeIK
         0SrgULTgkelJ9h0xkPQZ3tXqHsK2IdX9y0tHHRLu5LyzPjXRtKe3R7fEAKjpgMQhUaOT
         gqIarCWD0KOrwj/Xemc6+DPlDaKAx/sr2c0SNnSSGi0STCttOi+DaIfHAcwXyjHfeijX
         +NV8fARVH/k3DDRxjjzUazdFT+eu17cTf/Q4UrEjLJ8vaCBahqaMi9c/V9/qmAoJCmo2
         8Mp4mfTWWT1UUXx6L7oi1whCxuqwAv9RZQSBYMvdlbl5eUVuDz8ykWfWgks2epfLKmoc
         Sn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtQJ72HQtdfcAffC0RWWjlj3EllHxGw6h8fIo2FDXKo=;
        b=k6Pcty+Z5GDWC7AlaSxJUW2KAMP1bwX39WWoXgDJBp8JKb9Jqyk+mSHSXAz1bMkl+B
         nGPFYpsTMh7o/EJ5Hi5WbvoMYyktpdZ2r2Lw+M1ELsEqUfpNVM+6d4T91sPB1XkJJuZt
         OW9dRCSW++EcoFV6qIeF2utgYCLI0hakl1Rx/1EgSm7K9gvJsHDB9JLfVBKmXmWD8dip
         dx495VP5q5Ro8rbdVT20OjUSEmi6Y07iQ70AdYkmkNuTfyeXpM4ZvNI/v13EXfTghvjb
         dbBZBryrMl7+Pct+CCtGh3/Ss+9NdIj0dh36XeaaSI/ZCzlg4Et/5oK0AVDr4TNU+gMI
         IBqg==
X-Gm-Message-State: AOAM530c+FPpA31ij3Sb9TJp1hFO+57gr7RHj9We7vHFVywc//lFX7aW
        ZQm0cRK4RIYdReOAfvGHpcNE0JoP4yNforAYEsE=
X-Google-Smtp-Source: ABdhPJyH1OaT8lJP0r7mWKBxAGtDW5OL1rUPU//e2Go/Hk1RUMYbd7SIA0MYUoCS+yqpcQPYFHEZ6PGVacMO15N0oAQ=
X-Received: by 2002:a0c:dd85:: with SMTP id v5mr29860078qvk.60.1607901942475;
 Sun, 13 Dec 2020 15:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201102711.8727-1-p.yadav@ti.com> <20201201102711.8727-2-p.yadav@ti.com>
 <20201208181050.z747aiiccoxj6xqz@ti.com>
In-Reply-To: <20201208181050.z747aiiccoxj6xqz@ti.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 14 Dec 2020 00:25:30 +0100
Message-ID: <CAFLxGvz2LnHBFK61Dp7T-aSqdLY1xVLmuHQyOgxMQ9bmcZQK_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR flashes
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 7:17 PM Pratyush Yadav <p.yadav@ti.com> wrote:
>
> Richard,
>
> On 01/12/20 03:57PM, Pratyush Yadav wrote:
> > For NOR flashes EC and VID are zeroed out before an erase is issued to
> > make sure UBI does not mistakenly treat the PEB as used and associate it
> > with an LEB.
> >
> > But on some flashes, like the Cypress Semper S28 SPI NOR flash family,
> > multi-pass page programming is not allowed on the default ECC scheme.
> > This means zeroing out these magic numbers will result in the flash
> > throwing a page programming error.
> >
> > Do not zero out EC and VID for such flashes. A writesize > 1 is an
> > indication of an ECC-ed flash.
>
> Patches 2/3 and 3/3 have been picked up in the spi-nor tree. Can you
> please pick this patch up?

Yep, patch is in my next tree.

-- 
Thanks,
//richard
