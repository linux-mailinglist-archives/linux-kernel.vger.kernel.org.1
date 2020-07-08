Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A035321945D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 01:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGHXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:34:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B363C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:34:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so254111ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNDZpJjz5/37zGpab5eadfzDdCt43fYlei6otLmkW94=;
        b=EU3f5NbDKEsP2KVSGkoUxrAZa/JIRM7Z+WcDOsT5JeC0mCWRsd1l8yradKcL3CalxN
         xgilBNuVcDu96LiPUpu7Kt9bIY3/UsOtmGETjSdStVyzQ6Tf7prfUvnZCvpH2cENjUFd
         tyV2xUeUzbLn3rrc0fCEDgA+OAnD98J7bbrhh8unuCZiPk45zNAdW07donusdMLqBlOQ
         zwu9WyZYNuNK+vjjDF2MxInbYD51wXQpVXf2XMJ0xfefOwgrSFRvnpsyI2h1QXv+kmoy
         204tAwb6QN0CmEpQx11FQJL9WbaCsQQ+YxSx9KzPERI/UPzkzZKnsS4Wm+2mqXVZ8+5E
         dzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNDZpJjz5/37zGpab5eadfzDdCt43fYlei6otLmkW94=;
        b=Ed3iYijA9iw70dboBqlhCCqMx+gjFdHVACczDPqXDNq2u0wsFdjqBTJi8zTsTmIeZa
         Ab4K/yKZWLvT3E4UF+bYauF964lMIEssvFkt5S5Y9hWcUPzcUuHmix7i2hASYL/il7np
         4ENu8o+ySvwyPcw61kPqO8pblirp2DolO3NLOVBW0HUCP5TOLbm4OqRL/q8Kh3B2r5ga
         5NWOftL8zHFJBznRqFjD8dacQ6i93OMyEd/asf0pMEEv3/mJtocu//Zm6EDV5IPP8Yyc
         PxFt0O3PinOPMWzRt1LtrH8mURUv70UNglVoreu7tyaJFXmrwMEDxRiAiFoCMefFbWOo
         06Gw==
X-Gm-Message-State: AOAM530SjZqCTqVrhx/Rb8AiF0D7KVe/9zSnUnnaGHi2umvJ7P6I5MPp
        I6x5bf73IkQIKXg6IV/62U0WLZ26XokeZBSlf50uww==
X-Google-Smtp-Source: ABdhPJyRfsD1N5VAM42yOVLaqGvMozV4Q8gJh+j60/h5/3G53DcDqMeMXmPl1V4fduOSeZwa/G0+MHF9d1ZgvU4dy/o=
X-Received: by 2002:a2e:8085:: with SMTP id i5mr29909053ljg.97.1594251279742;
 Wed, 08 Jul 2020 16:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200708131424.18729-1-masahisa.kojima@linaro.org> <20200708162017.GB549022@linux.intel.com>
In-Reply-To: <20200708162017.GB549022@linux.intel.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 9 Jul 2020 08:34:27 +0900
Message-ID: <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakko,

> Overally the code looks great. You've run it through checkpatch.pl?

Yes, I have run checkpatch.pl and removed errors.

Regards,
Masahisa

On Thu, 9 Jul 2020 at 01:20, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Jul 08, 2020 at 10:14:22PM +0900, Masahisa Kojima wrote:
> > This adds support for driving the TPM on Socionext SynQuacer platform
> > using the driver for a memory mapped TIS frame.
> >
> > v3:
> > - prepare new module to handle TPM MMIO access on SynQuacer platform
> >
> > v2:
> > - don't use read/write_bytes() to implement read/write16/32 since that uses
> >   the wrong address
> >
> > Cc: jarkko.sakkinen@linux.intel.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: ardb@kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: peterhuewe@gmx.de
> > Cc: jgg@ziepe.ca
> >
> > Masahisa Kojima (2):
> >   tpm: tis: add support for MMIO TPM on SynQuacer
> >   dt-bindings: Add SynQucer TPM MMIO as a trivial device
> >
> >  .../devicetree/bindings/trivial-devices.yaml  |   2 +
> >  drivers/char/tpm/Kconfig                      |  12 ++
> >  drivers/char/tpm/Makefile                     |   1 +
> >  drivers/char/tpm/tpm_tis_synquacer.c          | 196 ++++++++++++++++++
> >  4 files changed, 211 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> >
> > --
> > 2.20.1
> >
>
> Overally the code looks great. You've run it through checkpatch.pl?
>
> /Jarkko
