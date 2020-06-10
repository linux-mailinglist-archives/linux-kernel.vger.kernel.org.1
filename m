Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258C61F5709
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgFJOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgFJOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:52:43 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90FC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:52:42 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y123so1399672vsb.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8rp+MArSRRSpQFZbpuYYbVfBKFL7AdnnK2tR2ekGzs=;
        b=NTX/q4qGHr9EjYtkkXB7Nj9DSl33xCzTiVxJhZzHrH3IcQIbJcROsY12VwdxliLX/V
         k2XNVmqHAz4QAOrCjP8zCyLPKS/dMfyUA++4zpCXnQaxNBvcoCnFmIQmLE9+WpCFKDNb
         WrM9FK8yuorcC9QeTKqkQZjQETjpEm2xC9x/81T1vvwe2pNOH+RDsxTZGQ0oJ0zGMTOH
         qY2g0ksDgrJubYc+x3EQaPgHLvOz8e5HCi0vjRdSmQz9cYacsSYRmqPxC1GKXD+yOiQ/
         CsJ04GyO9ioleQX5OqMuXUlnYu5EmeHGb0UUfNEKE1D/bqZydCxa80kfRDxY9sJbSGbk
         J+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8rp+MArSRRSpQFZbpuYYbVfBKFL7AdnnK2tR2ekGzs=;
        b=GkQzlvGevE9xMUuCQZHo7VDjNDi4w/I3UUr9d50oZ9a9kIhZY61wQ1Sa+TtZnQRqEj
         KJIax/it9D8LWARXTpJkHV1PiygDPW5l5WIFP6urFDZaYJaniEojRmquGNiNApa570f3
         Pb9LSijY5FysP09ybdNiUON7d2QGUiVOUTIrJsV2vp2tGqai8QZF00quvkD/1qAnu22F
         n2iiNBX7XrLmdrbYdKmemQqhhYUcsToJ1CDoYWVFrOL63+qJtMm6fDnHGQe1dTQnfFOM
         faeRYk3kRKRG6Ws+YMXTR8+j49TOfccULHMcUMHsbpw7C9U1LlUctKV5Iuhqk9ArJZHy
         lZLA==
X-Gm-Message-State: AOAM530fZg19KBEXqu+71Jpo9VFZgjz1oHHESFRm2A4YZhCf4mSyj72+
        VvOB6cp881+dffPKUFaj2mARtCSdGmA9S8Vh6xJrtA==
X-Google-Smtp-Source: ABdhPJw6aMJ9dyy4G/daFrXMNngDBFvzxNsGSUQNmxPAlbpy4epgww2/u+lBmaNyLn3UM7NX8xS/DrAfDxhNdVyKGtM=
X-Received: by 2002:a67:db88:: with SMTP id f8mr2729187vsk.165.1591800761473;
 Wed, 10 Jun 2020 07:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
In-Reply-To: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 Jun 2020 16:52:05 +0200
Message-ID: <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
Subject: Re: Consistent block device references for root= cmdline
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Hello all,
>
> there have been numerous attempts to make the numbering of mmcblk
> devices consistent, mostly by using aliases from the DTS ([1], [2],
> [3]), but all have been (rightfully) rejected. Unless I have overlooked
> a more recent development, no attempts for a different solution were
> made.

According to aliases attempts, I think those have failed, mainly
because of two reasons.

1. Arguments stating that LABELs/UUIDs are variable alternatives. This
isn't the case, which I think was also concluded from the several
earlier discussions.
2. Patches that tried adding support for mmc aliases, were not
correctly coded. More precisely, what needs to be addressed is that
the mmc core also preserves the same ids to be set for the host class
as the block device, mmc[n] must correspond to mmcblk[n].

>
> As far as I can tell, the core of the issue seems to be the following:
>
> The existing solutions like LABELs and UUIDs are viable alternatives in
> many cases, but in particular on embedded systems, this is not quite
> sufficient: In addition to the problem that more knowledge about the
> system to boot is required in the bootloader, this approach fails
> completely when the same firmware image exists on multiple devices, for
> example on an eMMC and an SD card - not an entirely uncommon situation
> during the development of embedded systems.
>
> With udev, I can refer to a specific partition using a path like
> /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was proposed
> to add a way to refer to a device path/phandle from the kernel command
> line. Has there been any progress on this proposal?

Lots of time during the years I have been approached, both publicly
and offlist, about whether it would be possible to add support for
"consistent" mmcblk devices. To me, I am fine with the aliases
approach, as long as it gets implemented correctly.

>
> Kind regards,
> Matthias
>
>
> [1] https://patchwork.kernel.org/patch/8685711/
> [2] https://lore.kernel.org/patchwork/cover/674381/
> [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
>

Kind regards
Uffe
