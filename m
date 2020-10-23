Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9858C296A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375541AbgJWHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373808AbgJWHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:03:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1793C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:03:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w191so844377oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drivescale-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCd0pPobEA/PZztJyMtT5WV3iM9MtpPXO0kYevYU6KM=;
        b=BtiW/WFL+lGL89dZDdLFS2nIJ2AogIGnkvqBj9K2Tw+CFC19MU9F/+Ina2wk63P4cp
         OqmKZzCvCBKgsU7ng7OxdTkWbll262HbtUmWBIyOF+WnThtjhqdMlryQ19QCVcLH1/bn
         k4T+KsPY4KXWAeDrfk9uwphgIIR9F2unKiJLtxFaADBmKfxgGlrDTQNuVsRScPrznZz3
         +dVuBDL6gtjeUg5IDImV6CcexV1Z3fh/Xry0j8H8uzxM6VTx+kPzzu8F7g22LlUr++7N
         W9IDHqXNNd0seAGYwOcUmTw6vPNeVpTaECKLetog9PAYzzibgF/6YA7L/bz/GHYponpF
         E1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCd0pPobEA/PZztJyMtT5WV3iM9MtpPXO0kYevYU6KM=;
        b=uk6pkR6pB/TIecyOnhCJZLNxU18s04Pnp+J+mrQZ6LixNVoPcA7Bo/JWb3QYvW+6Ft
         HbfUsfIskgYoAb443N6yKt+hxmhDW+GcsKmY6i2wFidqYRhRJy8kC0KJC6Fl4q1B0K3H
         Z1cryrQeFh9oWOnYQDFhgAyHFgyC+GsLgIp2sYZkNwyRD9dyu2kIyYqcEMqA0efEHzFj
         YErL8AySfnui6CZHbigNQjCaqtIUW06ojFAzVzerTLuYaHMYimdePZ8hPs/CycW7Jnla
         yul+WqXTWwKazIT1okr2pYWqSySd18+tjzwhe2LKWThNJF4shjixhbp/wBLuFR9k3Ms7
         mvTw==
X-Gm-Message-State: AOAM533bCUBixdhYPbx84yqbUbQClrLSQ0BMKEWYM3RvAGMbEztveLS1
        65uU/II7YmGazjsKfebCQPXLuINI6D8t3aB5ki+A4A==
X-Google-Smtp-Source: ABdhPJwahUJxA6Ut6/8na0FefXcjRxFmgp2p3BA/GYVMPt2n15RTcscJX2gRnoml8TiBj7GipqNoFcXnDwBIGgQYD5M=
X-Received: by 2002:aca:eb11:: with SMTP id j17mr695855oih.171.1603436633829;
 Fri, 23 Oct 2020 00:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201023033130.11354-1-cunkel@drivescale.com> <CAPhsuW7vn9trTBy0vxd7D=x3Jj=Wo2cTbQNZa6dw2BS5dnfLLg@mail.gmail.com>
In-Reply-To: <CAPhsuW7vn9trTBy0vxd7D=x3Jj=Wo2cTbQNZa6dw2BS5dnfLLg@mail.gmail.com>
From:   Chris Unkel <cunkel@drivescale.com>
Date:   Fri, 23 Oct 2020 00:03:38 -0700
Message-ID: <CAHFUYDp3zJ3GhBBMeDXRv+5LhtVERLqGuidtq2_6gGQi1yZrig@mail.gmail.com>
Subject: Re: [PATCH 0/3] mdraid sb and bitmap write alignment on 512e drives
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't offhand, but point well taken.  I suspect that showing a
difference in a benchmark is dependent on finding one where the
metadata has been evicted from the drive cache.  Let me think about it
a bit.

Thanks,

  --Chris


On Thu, Oct 22, 2020 at 10:42 PM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 22, 2020 at 8:31 PM Christopher Unkel <cunkel@drivescale.com> wrote:
> >
> > Hello all,
> >
> > While investigating some performance issues on mdraid 10 volumes
> > formed with "512e" disks (4k native/physical sector size but with 512
> > byte sector emulation), I've found two cases where mdraid will
> > needlessly issue writes that start on 4k byte boundary, but are are
> > shorter than 4k:
> >
> > 1. writes of the raid superblock; and
> > 2. writes of the last page of the write-intent bitmap.
> >
> > The following is an excerpt of a blocktrace of one of the component
> > members of a mdraid 10 volume during a 4k write near the end of the
> > array:
> >
> >   8,32  11        2     0.000001687   711  D  WS 2064 + 8 [kworker/11:1H]
> > * 8,32  11        5     0.001454119   711  D  WS 2056 + 1 [kworker/11:1H]
> > * 8,32  11        8     0.002847204   711  D  WS 2080 + 7 [kworker/11:1H]
> >   8,32  11       11     0.003700545  3094  D  WS 11721043920 + 8 [md127_raid1]
> >   8,32  11       14     0.308785692   711  D  WS 2064 + 8 [kworker/11:1H]
> > * 8,32  11       17     0.310201697   711  D  WS 2056 + 1 [kworker/11:1H]
> >   8,32  11       20     5.500799245   711  D  WS 2064 + 8 [kworker/11:1H]
> > * 8,32  11       23    15.740923558   711  D  WS 2080 + 7 [kworker/11:1H]
> >
> > Note the starred transactions, which each start on a 4k boundary, but
> > are less than 4k in length, and so will use the 512-byte emulation.
> > Sector 2056 holds the superblock, and is written as a single 512-byte
> > write.  Sector 2086 holds the bitmap bit relevant to the written
> > sector.  When it is written the active bits of the last page of the
> > bitmap are written, starting at sector 2080, padded out to the end of
> > the 512-byte logical sector as required.  This results in a 3.5kb
> > write, again using the 512-byte emulation.
> >
> > Note that in some arrays the last page of the bitmap may be
> > sufficiently full that they are not affected by the issue with the
> > bitmap write.
> >
> > As there can be a substantial penalty to using the 512-byte sector
> > emulation (turning writes into read-modify writes if the relevant
> > sector is not in the drive's cache) I believe it makes sense to pad
> > these writes out to a 4k boundary.  The writes are already padded out
> > for "4k native" drives, where the short access is illegal.
> >
> > The following patch set changes the superblock and bitmap writes to
> > respect the physical block size (e.g. 4k for today's 512e drives) when
> > possible.  In each case there is already logic for padding out to the
> > underlying logical sector size.  I reuse or repeat the logic for
> > padding out to the physical sector size, but treat the padding out as
> > optional rather than mandatory.
> >
> > The corresponding block trace with these patches is:
> >
> >    8,32   1        2     0.000003410   694  D  WS 2064 + 8 [kworker/1:1H]
> >    8,32   1        5     0.001368788   694  D  WS 2056 + 8 [kworker/1:1H]
> >    8,32   1        8     0.002727981   694  D  WS 2080 + 8 [kworker/1:1H]
> >    8,32   1       11     0.003533831  3063  D  WS 11721043920 + 8 [md127_raid1]
> >    8,32   1       14     0.253952321   694  D  WS 2064 + 8 [kworker/1:1H]
> >    8,32   1       17     0.255354215   694  D  WS 2056 + 8 [kworker/1:1H]
> >    8,32   1       20     5.337938486   694  D  WS 2064 + 8 [kworker/1:1H]
> >    8,32   1       23    15.577963062   694  D  WS 2080 + 8 [kworker/1:1H]
> >
> > I do notice that the code for bitmap writes has a more sophisticated
> > and thorough check for overlap than the code for superblock writes.
> > (Compare write_sb_page in md-bitmap.c vs. super_1_load in md.c.) From
> > what I know since the various structures starts have always been 4k
> > aligned anyway, it is always safe to pad the superblock write out to
> > 4k (as occurs on 4k native drives) but not necessarily futher.
> >
> > Feedback appreciated.
> >
> >   --Chris
>
> Thanks for the patches. Do you have performance numbers before/after these
> changes? Some micro benchmarks results would be great motivation.
>
> Thanks,
> Song
>
>
> >
> >
> > Christopher Unkel (3):
> >   md: align superblock writes to physical blocks
> >   md: factor sb write alignment check into function
> >   md: pad writes to end of bitmap to physical blocks
> >
> >  drivers/md/md-bitmap.c | 80 +++++++++++++++++++++++++-----------------
> >  drivers/md/md.c        | 15 ++++++++
> >  2 files changed, 63 insertions(+), 32 deletions(-)
> >
> > --
> > 2.17.1
> >
