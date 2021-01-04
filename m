Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746DF2E9AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbhADQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhADQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:25:17 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD4C061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 08:24:37 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j17so26495447ybt.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vBpBXC/9ucY1+ky5wV7xowNsqbFwGWckofXS204rVUQ=;
        b=FHEcoMksa41Km7fKX837180GO3o30lrAwKJbxW6ZrHuJkImz/Zis2eWrIKFRQPe77E
         smf/bcOvtwBWDzodW8vI+rpEtUhvEyhoUVgGXkXiG4KSayf8tcBVExlOG7An/aTTS2a1
         M7BQkmO0T1fs60txK65LKNwctysgjBplL+dj6V1V1gWJXM/+Y7AwFIMk0wssfUMq9Ryu
         yNbEsz9g3rCMOxIwvULYnEgvHAluK4plLl/lfXiI4WUMlqgwXjZnKAHJvE3pHUIEVM1Z
         pvsOvZ/inis7jITWN5qFLfdDyiwz4RkJXlonp0XFELorjqmNbW8xOovVHVHs9wycfRpi
         rKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vBpBXC/9ucY1+ky5wV7xowNsqbFwGWckofXS204rVUQ=;
        b=eGEeOD3F9zKCqw2wsGUxBoOgQ+jr9xON4hfjcBw7fO6nhuJu6TQn0P0LeFZrDGh7mc
         byYP4cMHojpgSxQI1BNU6qOxq+GOv5+Za6MsjM/5WzW/xM1j65rJM8EnDpETcFESsHa7
         VBfF0Vnixw88nlJi28S270n5IuKXDuqMRwbcKIw0YBjKEOJ9DQv4jKfTm4kQFtNo389N
         jdAvm0tRCwZvUIafPRs9zZvLSg2jLc06XeN/080Uo4S3CHtf1bwEJLcprQO0h//MxUTG
         SpyXyGvJoSHY5GBLB+2xex95vABsS3tJmTJ2lFi/Fj1voiYPLWKzVNw+HVGeqsimplh1
         WrfA==
X-Gm-Message-State: AOAM533ykKxoK5t39WzHi7VDaQlx1+ciF2LTIVU0+dE4+m8FLDBKXNIh
        ZnSKgCu0rtrGgY1gJqhbUzpS+gP9xnY2WKE6qWUMBw==
X-Google-Smtp-Source: ABdhPJx+EDGFBTYfc+IfvHW+c6PkHSt+Bv/qUNxm4NQQgkFgBuSQHHs6LcKW9aDPYUgzlXvHE8dF7D+7e7dsZGQFzGg=
X-Received: by 2002:a25:23d7:: with SMTP id j206mr110313103ybj.243.1609777476473;
 Mon, 04 Jan 2021 08:24:36 -0800 (PST)
MIME-Version: 1.0
References: <1887c783-7a80-a71c-949f-c07c83c2d0fe@ti.com> <20201223215630.1917891-1-goegebuer@google.com>
 <20210104100819.1d623425@xps13>
In-Reply-To: <20210104100819.1d623425@xps13>
From:   Ron Minnich <rminnich@google.com>
Date:   Mon, 4 Jan 2021 08:24:25 -0800
Message-ID: <CAPAv03OXCAAPA7B8sAF-JX-8LSVHwk16Tnx_N-beRvZQXN7CVQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ian Goegebuer <goegebuer@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely we're missing something -- I am not fully checked out on
the Linux patch process and it's Ian's first patch.

Guidance appreciated.

On Mon, Jan 4, 2021 at 1:08 AM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hello Ian,
>
> Ian Goegebuer <goegebuer@google.com> wrote on Wed, 23 Dec 2020 13:56:30
> -0800:
>
> > On Intel platforms, the usable SPI area is located several
> > MiB in from the start, to leave room for descriptors and
> > the Management Engine binary. Further, not all the remaining
> > space can be used, as the last 16 MiB contains firmware.
> >
> > To make the SPI usable for mtdblock and other devices,
> > it is necessary to enable command line partitions so the
> > middle usable region can be specified.
> >
> > Add a part_probes array which includes only "cmdelineparts",
> > and change to mtd_device_parse_register to use this part_probes.
>
> The commit title seem to be taken from another patch and does not
> match the below change. Or am I missing something?
>
> > Signed-off-by: "Ronald G. Minnich" <rminnich@google.com>
> > Signed-off-by: Ian Goegebuer <goegebuer@google.com>
> > ---
> >  drivers/mtd/spi-nor/controllers/intel-spi.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/=
spi-nor/controllers/intel-spi.c
> > index b54a56a68100..9de38851c411 100644
> > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > @@ -903,6 +903,8 @@ static const struct spi_nor_controller_ops intel_sp=
i_controller_ops =3D {
> >       .erase =3D intel_spi_erase,
> >  };
> >
> > +static const char * const part_probes[] =3D { "cmdlinepart", NULL };
> > +
> >  struct intel_spi *intel_spi_probe(struct device *dev,
> >       struct resource *mem, const struct intel_spi_boardinfo *info)
> >  {
> > @@ -950,7 +952,8 @@ struct intel_spi *intel_spi_probe(struct device *de=
v,
> >       if (!ispi->writeable || !writeable)
> >               ispi->nor.mtd.flags &=3D ~MTD_WRITEABLE;
> >
> > -     ret =3D mtd_device_register(&ispi->nor.mtd, &part, 1);
> > +     ret =3D mtd_device_parse_register(&ispi->nor.mtd, part_probes,
> > +                                     NULL, &part, 1);
> >       if (ret)
> >               return ERR_PTR(ret);
> >
>
> Thanks,
> Miqu=C3=A8l
