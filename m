Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3E28388B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJEOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:53:59 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:53:59 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id h23so1814318vkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ym6bsjkoVHeKT2YlsX+HlWwN/shfAKw/+hwQ4HCTOvw=;
        b=KJ+MkWhWuGC2LVG1fwszRlcVzZxqs9l3qG0znHupdzRMH5eJBIsd7UFgzbcMIOuqqk
         wQQwPrl6rnk4eqTGoAq7q3tC0U2s+w8vyHlCS4nhmyKEJ1Y15MxHJTUSLw8NSlCTf2qJ
         ji9krD059ZPvVx6WsDUgJjUYwe0xw0uBFUtJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ym6bsjkoVHeKT2YlsX+HlWwN/shfAKw/+hwQ4HCTOvw=;
        b=gMYxf6ajzyDrB147uuRbtW8oklIB+6q42WJor4OI0tkIpvohFnqCYOo3sefWMgQSy6
         Kfim3gyrS6cIgjXl7p/YohzdebqZ1xu2QBy4Zz2sDk0miTIL3+hg3Kl95KXrY8bnKu91
         5/WUvj1/E6gaA/TuomJujWfgeKgx2Ku3KlUNFdsT1p7Guw45CMENUrHmcwKydmoNXgLw
         FIxoe95ee1T4tbVcgATS90LalwSWP9K3+w9Zp+GmbT4RbglKrbTLATWorbSE23rXbNZB
         CLzNuqgyROo2F/eWuX0vnsDzrEQ43SSIHo8v01n7Xl+wgAAbYrQaQt57ovwS3U+wDU3F
         y5tQ==
X-Gm-Message-State: AOAM532piELV7+mxAJy0xRDftIJgIiB6yg2OadsNAoiFq2+vfa1/AvN2
        PKShWArtLYe9UAUWwM3XG2G8O5J9ueOUFw==
X-Google-Smtp-Source: ABdhPJzgVKKLhDCBnoFE8voc3647gSIvzImSC0cAY8ceYW3S1l0Ab4Z/UDL3ufy1bd1KS8fArKgEvg==
X-Received: by 2002:a1f:9a4f:: with SMTP id c76mr273514vke.13.1601909638207;
        Mon, 05 Oct 2020 07:53:58 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 89sm25885uaq.9.2020.10.05.07.53.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 07:53:57 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id 5so4378419vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:53:57 -0700 (PDT)
X-Received: by 2002:a67:8bc2:: with SMTP id n185mr270743vsd.49.1601909636866;
 Mon, 05 Oct 2020 07:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
 <20201003150633.23416-1-michael@walle.cc> <CAD=FV=VB-ML0=kmN-yAH7sD-sMiX9Cq1_9B9QwVL=Ed5ZrGnbg@mail.gmail.com>
 <b376b3f2e41662237d50d589e3696b06@walle.cc> <CAD=FV=VddVg=QLS32Jr-Mxh6nyiB2=1MybxGiYuuaKd+fQ4+Lw@mail.gmail.com>
 <23aa87ccb6ae4133a17885b809194161@walle.cc>
In-Reply-To: <23aa87ccb6ae4133a17885b809194161@walle.cc>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 5 Oct 2020 07:53:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoXqBJea36=5f-i_g82Tn6Zhib2GmF8G65UbPJskXiGA@mail.gmail.com>
Message-ID: <CAD=FV=UoXqBJea36=5f-i_g82Tn6Zhib2GmF8G65UbPJskXiGA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Prefer asynchronous probe
To:     Michael Walle <michael@walle.cc>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 4, 2020 at 7:10 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi,
>
> Am 2020-10-03 19:00, schrieb Doug Anderson:
> > On Sat, Oct 3, 2020 at 9:54 AM Michael Walle <michael@walle.cc> wrote:
> >> While debugging another issue I also noticed that sometimes my
> >> /dev/mtdN devices were reordered. Note that I have two SPI flashes.
> >> Might this also be connected to the async probe?
> >
> > It's likely.  My guess is that you shouldn't really be depending on
> > the numbering.  If you need to depend on the numbering, there should
> > be something that guarantees it like a device tree alias.  We have
> > struggled with similar things on MMC for years and I guess Ulf finally
> > decided that we weren't going to get a better solution than the device
> > tree aliases.
>
> But this has to be supported by spi-nor first, right? So that would also
> be something which has to be added before we can make the probe async.
> And as far as I know there is no such mechanism like /dev/disk/by-X for
> /dev/mtdN.

I did a quick skim and didn't see any mechanism like this for the MTD
layer, so I think you're right.  Something like this would almost
certainly need to be added.  As per the discussion in the MMC threads
about this, though, probably whatever you have working right now is
"by luck".  It may be stable from boot to boot, but I don't think
there are any guarantees that a new kernel version won't come along
and shuffle your IDs around.  Presumably it would be a good idea for
MTD folks to come up with some sort of solution here...

-Doug
