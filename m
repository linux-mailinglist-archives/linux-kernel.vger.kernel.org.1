Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5412B7C77
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKRLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:22:28 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:46786 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgKRLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:22:27 -0500
Received: by mail-lj1-f170.google.com with SMTP id h23so1890061ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkzv4PdI93h5icC6IvqM3sQ0B5wkULX2IuLOdv7sckE=;
        b=A2kX0EfxON2NK4eOJlq+bFfYNsFm1eFEUli9FFZUViuUX6SvwPYyQxBK55nSOTRRzq
         8axE/jspza/F1OkRpuXWPWVm0ZRt5qgeSuI8X14YiLOSeeyJ0tnu6270hsuKo3I8w2Rj
         9L+b1F3P12Yjn9tjUfpkmg838/GOn4DSazPudb5pmWs7QM/N1lVilWy3JaLwfAScjXlO
         qALqEUdPVGswzyP+zYNbvGDlcOlGH2C/hmkWEmA8BJH2XOLJ7Ct/pjyKbQo/GNhB1o8C
         y6ELkm0yE5/HWcFkl7+7VXT/fxC9vyCvzI8b17svd/pr9QR2aTAdgYByV33rJlbq1bRI
         7eOg==
X-Gm-Message-State: AOAM531TBnVmL8g2s5+NrY8u5RenbkxUeFsfB9zo6ynoo+C3JRaXOSkO
        +IGz/BZGXPi+m3aMKrwrFzItlLE6CIe3UQ==
X-Google-Smtp-Source: ABdhPJxAiJmq7RFquvGDItvomCjbWTrqeO11uRashSqipBx36PA5Ez+o7RXIMkwwuLfPj/cqPKQapg==
X-Received: by 2002:a2e:8ec4:: with SMTP id e4mr3631845ljl.135.1605698545147;
        Wed, 18 Nov 2020 03:22:25 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c19sm3389965ljk.35.2020.11.18.03.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 03:22:25 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z21so2384517lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:22:24 -0800 (PST)
X-Received: by 2002:a19:ca05:: with SMTP id a5mr3268226lfg.571.1605698544818;
 Wed, 18 Nov 2020 03:22:24 -0800 (PST)
MIME-Version: 1.0
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan> <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
 <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
 <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com> <CAGb2v67Mhu7WzG37-5HYoZHKeFS6PNnh5--YS3YYOv=uSnaYLQ@mail.gmail.com>
 <0fd12dbb-75d6-163d-f0e1-bcb43887f5bc@orpaltech.com>
In-Reply-To: <0fd12dbb-75d6-163d-f0e1-bcb43887f5bc@orpaltech.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 18 Nov 2020 19:22:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v64XLf9uyaXj7AR8RB1An=3LvhT+J2k30TJ_4ghGp7zhBw@mail.gmail.com>
Message-ID: <CAGb2v64XLf9uyaXj7AR8RB1An=3LvhT+J2k30TJ_4ghGp7zhBw@mail.gmail.com>
Subject: Re: BananaPi M2 support
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 7:14 PM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, ChenYu,
>
> thanks for for the help. I tried to use
> "root=PARTUUID=a09ef512-7f29-47b8-8e9a-db5d1d58d8be" in kernel boot
> parameters,
> the new log is here  https://pastebin.com/EL3uaRpE.
>
> Nothing has actually changed, the only difference  is that it now says:
>
> [    1.750270] Waiting for root device
> PARTUUID=a09ef512-7f29-47b8-8e9a-db5d1d58d8be...
>
>
> I verified that a09ef512-7f29-47b8-8e9a-db5d1d58d8be is the actual
> partition id from my sdcard.

That is the partition's UUID alright, but not what PARTUUID expects.
PARTUUID is the partition table's ID + "-" + an index to the partition.
If you're using an MBR partition table, and the partition is the first one,
then it would be an 8 digit hexadecimal ID with "-01" appended.

Just put the SD card in another machine and look under /dev/disks/by-partuuid/
to see what the value should be.

ChenYu

> Thank you,
> Sergey
>
>
> On 17.11.2020 20:36, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Wed, Nov 18, 2020 at 1:06 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
> >> Hi, ChenYu,
> >>
> >> I have tried to build and run linux-next  by tag  "next-20201117".
> >> Now the boot log looks different but the kernel still hangs. See
> >> https://pastebin.com/gFk7XuBc
> > Due to the new asynchronous probing of mmc controllers, the mmcblock
> > device numbers likely have changed, as seen here:
> >
> > [ 1.652275] mmc1: new high speed SDHC card at address 0001
> > [ 1.652568] hub 1-1:1.0: USB hub found
> > [ 1.658587] mmcblk1: mmc1:0001 EB1QT 29.8 GiB
> > [ 1.661777] hub 1-1:1.0: 4 ports detected
> > [ 1.670263] mmcblk1: p1
> >
> > You should change your root device specification to use PARTUUID,
> > instead of hardcoding the index.
> >
> >
> > Regards
> > ChenYu
> >
> >> Thank you,
> >> Sergey
> >>
> >>
> >> On 17.11.2020 11:06, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> Please try linux-next. There were some regulator fixes that got merged recently.
> >>> One of them fixes an infinite recursion when resolving regulator supplies.
> >>>
> >>> ChenYu
> >>>
> >>> On Tue, Nov 17, 2020 at 1:12 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
> >>>> Hi, Maxime,
> >>>>
> >>>> it just hangs on that last lines and nothing happens anymore, see 5.18 log.
> >>>>
> >>>>
> >>>> On 16.11.2020 18:52, Maxime Ripard wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
> >>>>>> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
> >>>>>> boot logs for both versions https://pastebin.com/DTRZi8R7  and
> >>>>>> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
> >>>>>> kernel with default config, u-boot v2020.10.
> >>>>>>
> >>>>>> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
> >>>>>> The versions 5.8.18 and above all fail (5.9 and 5.10).
> >>>>>>
> >>>>>> Could you look at the problem or provide an advice about further
> >>>>>> investigation, please ?
> >>>>> I'm not quite sure what the issue is exactly? How does it fail to boot?
> >>>>>
> >>>>> Maxime
> >>>> Thank you,
> >>>> Sergey
> >>>>
>
