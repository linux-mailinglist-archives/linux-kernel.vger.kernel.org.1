Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0C2ECECE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbhAGLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbhAGLga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:36:30 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA92C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 03:35:50 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2so3689676pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHeSNyL9PFfXjN2EbRqgvs+RdYchOryhErSWYV/YCU0=;
        b=sDNmudVQqaFyjK8PohJB2Qe/brRqLo3J/SlqCJLqZfcRPnclX1Tw4JGnNiIozMA9Zq
         vxUdGBOUk2qZkmJRc/XA5L912Fu66C2LvjIFg3D0Y7BMwjepexgrHCmvhioU2SBV1Li5
         XEuvxLZ7sTjOsVvp1uX2fwWeBIeU5RIiCZ9heOybTe9QL6dP7yP9UwnLqtqvugk0vO9t
         drRSF7KPSrsej7XmXqTqdkqCMUWJ9hhmIj5Q9LbnIhkRE6IIihzJ4fkz1trosv/Vizf1
         mI+thtCto4Q+jQugPk69GL44THnfa/CvXnh2XApr6hn3sIEnr9XlejjL4Or4q/qlMoxi
         JxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHeSNyL9PFfXjN2EbRqgvs+RdYchOryhErSWYV/YCU0=;
        b=RPOJdA44KDffJO1+2TdWW6eK8hysgYeYBBOTh8J2zEWhiRevuCMpLeS6zhIGrukirL
         YmTrEZkm2BAwOmR2zwEgh5vmKVGGAPqCgNwySPP6JeHOrmvnV5qpVsz/4pkM/z6e8sul
         8waq7Bx+wjJCQ9rWV5rJX468oJ9kLlV5jt83igg12c2UNtUbqdTy+o+MdospAngQOlMK
         /3Ls25z63O1j90USkN5TQKg6ijyXpFAqpM3Te1JWkyfNwogrEePtslYLyMhmSoFN4SXs
         pqQiV+dRBq5MxGZG9nf2x7aQLaNfn9+hp5Dy+bGhgeyoJJDeCOK+YvVrGMy1CbblbE4+
         tahA==
X-Gm-Message-State: AOAM533ZkarDXrHTle+K+ayr/ndHWIKxBBklV7EX4JWlQvGqj4JDKe05
        5daK6FihbxZq1fzG0tC7VIUaqlUes/k=
X-Google-Smtp-Source: ABdhPJxmWOSDNM4oJ4spXe64GFG/Her6VxCDRus1USqpecSIltBmwcvoo15VlJA9tRbq+/tfA9tqsQ==
X-Received: by 2002:a65:6381:: with SMTP id h1mr1433423pgv.301.1610019349512;
        Thu, 07 Jan 2021 03:35:49 -0800 (PST)
Received: from an990131127 (42-73-236-79.emome-ip.hinet.net. [42.73.236.79])
        by smtp.gmail.com with ESMTPSA id p4sm1878722pjl.30.2021.01.07.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 03:35:49 -0800 (PST)
Date:   Thu, 7 Jan 2021 19:35:49 +0800
From:   Shuhao Mai <shuhao.mai.1990@gmail.com>
To:     Tudor.Ambarus@microchip.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: Add support for w25q512jv
Message-ID: <20210107113547.GA2108@an990131127.quanta.corp>
References: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
 <6e59d200-f4a6-459e-8cba-86782413ae8b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e59d200-f4a6-459e-8cba-86782413ae8b@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:26AM +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Shuhao,
> 
> On 11/11/20 3:45 AM, Shuhao Mai wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Add support for w25q512jv. This is of the same series chip with
> > w25q256jv, which is already supported, but with size doubled and
> > different JEDEC ID.
> 
> Where and how was this tested? Please add this info in the commit
> message.
>

Will add it in next version.

> > 
> > Signed-off-by: Shuhao Mai <shuhao.mai.1990@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/winbond.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> > index e5dfa786f190..beaa6389e2dc 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -97,6 +97,8 @@ static const struct flash_info winbond_parts[] = {
> >                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
> >                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> > +       { "w25q512jv", INFO(0xef4020, 0, 64 * 1024, 1024,
> 
> We should name it "w25q512jvq" in order to differentiate it to the
> "M" version: https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%2006292020%20133.pdf
> 
> The flash supports BP locking and we can enable it if you can test 
> the locking with mtd-utils. Not mandatory though.
> 
> Cheers,
> ta

I tried flash lock on my test enviorment, but it doesn't work. I think I'll
only update the flash name in next version, and submit a new patch when I
have answer to it.

Best,
Shuhao

> > +                           SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> >  };
> > 
> >  /**
> > --
> > 2.20.1
> > 
> 
