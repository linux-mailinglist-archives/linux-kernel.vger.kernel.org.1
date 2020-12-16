Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7B2DBF40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgLPLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:16:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:15:59 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id t8so23563548iov.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjqtyaEXagR0cdMaIV8xobKWELgO4kFZkl7p1Qxs5wY=;
        b=mfwVEMGBbhA7vaP/3oy4bPd91C/hzsUoCAhd62/nf8VXNk4EFoVn1cdWAuE1WY1891
         +CtL3xRHQr0/VciLA56p7MGGRkI8UhFq4QdrMfrC/hQlTi7eQZVVLt+zxEEHmaxnUVxy
         Fskvuydy/PvcLY8rQfoU18zJtpZDJzqx1P+Eg5VzMHuxJH21rOITNaWxWyNjt0iqWOvY
         Sqpj9VhyrH+26DaelVNjgb2jvUTwCHR94/5ucc6MNC1m07/L5asRf8G85j6djKTjG1FD
         gWFsCB1jlP7170lpiEvsVyRXNkwtetRET0jMXPSjReQcKIn7pYJ6n/MTPfy/RqE6C20F
         qW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjqtyaEXagR0cdMaIV8xobKWELgO4kFZkl7p1Qxs5wY=;
        b=eZsFdjRSC7aayWgzmlx79iT9Elt6RjRBgh07PWXz/oa89eUjPIcGHivsB3ToM9QTZL
         55Kzld1vY3JCzz962br2vEo/pN/ImBFNtfyTz6hcXSVUw7nhoayTBMYO6qQYkb29guw/
         +07GKJ+xfQDnTmLH6G5U9CA2QyCNmnsRGxcT7vKQhrdSgtdIzAOC3vuHaFbVu+T8ocPk
         +I5PwT1jUGNuXMJhSNx2ud6dWiG9jqveb3II/iXSEDGcWowkAT/whbQjlxp+zdqYg9TZ
         xiaSMCPb1tSjM87KBa5M5aLNOo/JKAr+3udcwy5gMCIpPzVJjhyrKYNKS6WATNx/5loH
         7QNg==
X-Gm-Message-State: AOAM531S6pKAJbsuFKG5A3AmP3wPcEM6QbzyIfmU/402hNk0Xblu9yZR
        PzI13OAxHGZrWwx+qMtkRFs9to1xR/A70V9vw6U=
X-Google-Smtp-Source: ABdhPJzjwmBi8CGqCr2fDXk/QakcooFgPtXbkRTLXddqhtiu+AYtAAPMcpbRAJO9akMK1mG8pb7Bk89gz/CCFvmdVGY=
X-Received: by 2002:a02:90ca:: with SMTP id c10mr42866369jag.115.1608117358941;
 Wed, 16 Dec 2020 03:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20201215214656.649896-1-bert@biot.com> <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
In-Reply-To: <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 16 Dec 2020 19:15:47 +0800
Message-ID: <CAJsYDVKysjbMYrpv52WcY4Vz=Zdrp69gUwHP=VQcUq_3KpzMhQ@mail.gmail.com>
Subject: Re: [PATCH] Add spi-nor driver for Realtek RTL838x/RTL839x switch SoCs
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     bert@biot.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, john.garry@huawei.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Dec 16, 2020 at 4:30 PM <Tudor.Ambarus@microchip.com> wrote:
>
> On 12/15/20 11:46 PM, Bert Vermeulen wrote:
> > This driver supports the spiflash core in all RTL838x/RTL839x SoCs,
> > and likely some older models as well (RTL8196C).
> >
> Can we use SPIMEM and move this under drivers/spi/ instead?
>
> Cheers,
> ta

Just took a brief look at the code, and here's my current understanding
of this controller:
1. CS is controlled separately with SFCSR_CSB* bits
2. To write 1-4 bytes, set SFCSR_LEN* and write to SFDR
2. To read 1-4 bytes, set SFCSR_LEN* and read SFDR

If that's true, this is a generic half-duplex spi controller, and the driver
should register a spi_controller with set_cs and transfer_one
implemented.

-- 
Regards,
Chuanhong Guo
