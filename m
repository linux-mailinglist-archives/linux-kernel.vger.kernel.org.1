Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A900B2CC3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgLBRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgLBRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:40:07 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:39:21 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so1990569qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGDDLpBXGNMg0LMolwGSeuNTRKQu3sxPBzrkwGCeCV8=;
        b=CRYaomH7zz71puhu+kMqSSkTSmpZpb22SXX5agzTtcAHK1XuFkv+sNcPwRLDiwl2iM
         DfK1bjPEBfr0ijAj6unk6UgTBqtmzcb03mc4FIaY+nY90iBKR9TvdydueKinRTsGXL9n
         Utg8gB+vKZI0s4mrOkISQRbWqcwoXQl4QmShDUcMqFD9wl4B8rhSrpXkBHcOWBn9qHSJ
         M4AO+sMAjut7KO1iiZfzbTCSArhL3+Z/Uuxx6SmE+LWoJiKlvgS0GoD6Yl0pQuCz9cKP
         dx82Gho0fL5FYiIqfMSe1/yMkq4KIBIFSpdgfkdtJRKMalxCmsiyPimVr/wvIrtr/VPc
         VPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGDDLpBXGNMg0LMolwGSeuNTRKQu3sxPBzrkwGCeCV8=;
        b=EMePZJ7sGdVTGqIU5bccI/MgpaYseed6VNVsyN8aH/LWDr9izEkOY8Kr0pkF+SQf16
         QPadlmO249zYAhZ/G+1Q/Y6L0iUT+t8z3ZLkkVfb9LZFUK1c8p2DxhDvmJe56tOVYqM2
         cu3G55zUnnyuShHk4cPm3DRlk17wIOUhdibBnzfahTnjWYyypI+PuXvkg2YH6MfwP8bS
         20KE/E2eRmlMksCa6NKtgxdcV/tUH4Rc+xDAR9J6qwQpy7X/s3FessKqYzih0B7MTcWm
         AiuGx/nd+XXbTcXWpoDpq4i9O9WAkUvFd6Y0F+wyQ/0/kssIGo6DBLO8Vhd87zunT9ug
         03+Q==
X-Gm-Message-State: AOAM533Slpg3T056QnyOZPkLyQZrfK8ZeGn6KbOHC9AkvsLI+VcYRxAw
        91xHkpstGV2Wbl4/HP4jGAZtD8QE6JV3qR5ej3kU2A==
X-Google-Smtp-Source: ABdhPJwJ5CP3xL/u9S7A6l5zYggC8BATzFrYqGlpBxtoUWCKus+HAwcGQ++rLe76lb1hP8z3tEnbzJDsjMi1CtyP/aE=
X-Received: by 2002:a37:4acb:: with SMTP id x194mr3593249qka.295.1606930760481;
 Wed, 02 Dec 2020 09:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20201120032639.24386-1-mw@semihalf.com> <5b5a1367-2632-2754-bc8b-7d57d0205232@intel.com>
In-Reply-To: <5b5a1367-2632-2754-bc8b-7d57d0205232@intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 2 Dec 2020 18:39:09 +0100
Message-ID: <CAPv3WKeQ27kUDE8Z4c7BWKBBX_CJRJe-t2TmHJ1ArTXX2V_PKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] sdhci-xenon ACPI support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ziji Hu <huziji@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 2 gru 2020 o 09:30 Adrian Hunter <adrian.hunter@intel.com> napisa=
=C5=82(a):
>
> On 20/11/20 5:26 am, Marcin Wojtas wrote:
> > Hi,
> >
> > The second version of the sdhci-xenon ACPI support
> > is now split into 4 patches instead of a single one.
> > There are minor functional differencse - match_data
> > introduction and using dedicated ACPI ID per
> > controller variant.
> >
> > The MacchiatoBin firmware for testing can be obtained from:
> > https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
> >
> > Changelog:
> > v1->v2
> >   * Split single commit to 4
> >   * Use device_match_data and dedicated ACPI ID's per controller
> >     variant
> >
> > Marcin Wojtas (4):
> >   mmc: sdhci-xenon: use match data for controllers variants
> >   mmc: sdhci-xenon: switch to device_* API
> >   mmc: sdhci-xenon: use clk only with DT
> >   mmc: sdhci-xenon: introduce ACPI support
> >
> >  drivers/mmc/host/sdhci-xenon.h     |  12 +-
> >  drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++---
> >  drivers/mmc/host/sdhci-xenon.c     | 120 +++++++++++++-------
> >  3 files changed, 110 insertions(+), 62 deletions(-)
> >
>
> Not withstanding Ulf's comments:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you, I will push v3 right away.

Best regards,
Marcin
