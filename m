Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06227EF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgI3Qmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3Qmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:42:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:42:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so1707102qtn.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lVLDUENS5HtvTi16CbvdwsaqFFfIVLSej05+iUQc+vs=;
        b=R6nUSnBm+5YV02WI9vt2g2rJwl9S/gQZByWVGatI7kdjLOVsZ1p1BEG09Z6FbbT0vy
         YIafd35emRgBE3TjkG7eTu6QtQSuPkK4WjhaMcLOkb9xt2/Lk+j8ZQAn/kcQmjwJcCmE
         NnzEsP89x6Gt/O0UsmJG3Bt1K9P360ATyxJ7D5kFxGJtWXA2SXSsoga1UQL7ptNABX2I
         rNJn+YsPgr6YYBuIfDXQ6FqxgKAOjdmWQLQflvMu3N2N8lGO628lG0HaYfFR+gMmGA2h
         i/HWNkEok+iMCaEpi4ubdQezKBdITZ1eoAX3wJaYX5ZsXoolumzUS1uKVJylTQ/9rMOb
         ctSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lVLDUENS5HtvTi16CbvdwsaqFFfIVLSej05+iUQc+vs=;
        b=H/Zs8/nJc+gyN/hvcqBkEf/So82RoCI5F0G3cBFCtbOThrHNsUURJxDAKU9Mt624Eu
         xdIO7XZ5FKsV1TNBOdnbLhP4AWc2iiccRR6c4L1FJ/N3D0Iyl1iR1yRiEJXZAx5o1dOG
         gt+pPmRQYn+5IdiYmVTZPE2UqZgp4wMPdw7wygoAdCq4Pa6zqim867lMHQQ7Vc5OG9n3
         H58Z6rpQ5HiGWKfHL9Ov3S5ov+EJGj2Y9vnElrgn3qmq316j0XpDSO4NLSPbWCaTvSSS
         eQqXrF99LNnnbbbzSLo53FT45dqvHqTp+S7dOnFB0JNYwe7Xjt18ueOTg/QvKeSMnJhV
         ud/Q==
X-Gm-Message-State: AOAM533AFgMOFhOR1kL2AuSGolFLts+Gu7kldgzpPwrmyic+pe1Kkg0/
        9gdDUvcWZ2gf2BMHkyj5z/AK3Y9Qe5OTC7O6u5mJbw==
X-Google-Smtp-Source: ABdhPJyorcExL69VYti3el7jIkzZYoeUTzQ7ALybF4p/zwGl4AYpWHyCDapPdbeehWSDBPdirAkUuLaLCjgFWyDmY1g=
X-Received: by 2002:aed:3584:: with SMTP id c4mr3059581qte.84.1601484168220;
 Wed, 30 Sep 2020 09:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Wed, 30 Sep 2020 13:42:37 -0300
Message-ID: <CAFmMkTFGRM4KdV70ATu4hhk61cJ76kztvt0fww7JKcpxt_JGZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Platform integrity information in sysfs (version 9)
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to restore
Tested-by: Richard Hughes <richard@hughsie.com>
which I removed for experimenting purposes with git-send-email.

On Wed, Sep 30, 2020 at 1:37 PM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
> This patch serie adds a misc kernel module and extends the intel-spi drivers
> to publish platform integrity data in the sys-fs.
> Please check the comments in the following patches of this serie for further
> details.
>
> Daniel Gutson (2):
>   Platform integrity information in sysfs (version 9)
>   This patch exports the BIOS Write Enable (bioswe), BIOS Lock Enable
>     (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of the
>     BIOS Control register using the platform-integrity misc kernel
>     module. The idea is to keep adding more flags, not only from the BC
>     but also from other registers in following versions.
>
>  .../ABI/stable/sysfs-class-platform-integrity | 23 +++++
>  MAINTAINERS                                   |  7 ++
>  drivers/misc/Kconfig                          | 11 +++
>  drivers/misc/Makefile                         |  1 +
>  drivers/misc/platform-integrity.c             | 57 ++++++++++++
>  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 +++++++++++++++-
>  .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 90 ++++++++++++++++++-
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
>  include/linux/platform-integrity.h            | 19 ++++
>  11 files changed, 288 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-integrity
>  create mode 100644 drivers/misc/platform-integrity.c
>  create mode 100644 include/linux/platform-integrity.h
>
> --
> 2.25.1



-- 


Daniel Gutson
Engineering Director
Eclypsium, Inc.


Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
