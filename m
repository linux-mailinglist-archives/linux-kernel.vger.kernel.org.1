Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA782B6BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKQRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:37:13 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35640 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKQRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:37:12 -0500
Received: by mail-lj1-f171.google.com with SMTP id 11so25261416ljf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKXm/vQ3AmydnaC7cSbwd0eGYk6zaZFDrwhiM96jKi0=;
        b=MRtLtM4YvGptgwid9PWtYWwzCS2Ogi56OTMSV4POpqmEU/4N8eTO9pPV+hRAztufuW
         5RjGwNOQhDkg0zKS30E2ZfO/6EjQ/rtllhUTf0kylJVpNgxrK99HIkxu5COQmPoSXZ3o
         4ZBzNMTmO+FJuTNhQVITj2f7UVqfnsJv1pU067KQVLCq5Ndk4tRadrwEUQj89QtvoYgW
         9gwEamVTBzdwRt90TOx8cebYy3mGrfIxPL3rUQ0PvtYDCgaPVvhtWrGf0cciKFCs2wDK
         VpD7mjfpmq/eZBsY2JWkA0gq5JDFwWvNKErtQhrDrr7CPG1N5YErmLhLKrM3QykYp/4I
         kekQ==
X-Gm-Message-State: AOAM5301BMAFzN+I4c6yh7z03chAgQbWVHiPoZWZjqR7I720N6zwbb/r
        kS9TopvDnu1UWdV8TkNviE5x2Ou7EejN8g==
X-Google-Smtp-Source: ABdhPJz4yIdpMhJ4fTZSoNYd6yQKLTkFKcmu5aD6BGalrMwRvaT92kGycteUdhuzFIKYU5JXipZ0Ww==
X-Received: by 2002:a2e:b5bb:: with SMTP id f27mr2506868ljn.363.1605634628608;
        Tue, 17 Nov 2020 09:37:08 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a16sm2999012lfg.16.2020.11.17.09.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 09:37:08 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u18so31212058lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:37:08 -0800 (PST)
X-Received: by 2002:a19:4a41:: with SMTP id x62mr1974211lfa.398.1605634628065;
 Tue, 17 Nov 2020 09:37:08 -0800 (PST)
MIME-Version: 1.0
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan> <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
 <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com> <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
In-Reply-To: <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 18 Nov 2020 01:36:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Mhu7WzG37-5HYoZHKeFS6PNnh5--YS3YYOv=uSnaYLQ@mail.gmail.com>
Message-ID: <CAGb2v67Mhu7WzG37-5HYoZHKeFS6PNnh5--YS3YYOv=uSnaYLQ@mail.gmail.com>
Subject: Re: BananaPi M2 support
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 18, 2020 at 1:06 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, ChenYu,
>
> I have tried to build and run linux-next  by tag  "next-20201117".
> Now the boot log looks different but the kernel still hangs. See
> https://pastebin.com/gFk7XuBc

Due to the new asynchronous probing of mmc controllers, the mmcblock
device numbers likely have changed, as seen here:

[ 1.652275] mmc1: new high speed SDHC card at address 0001
[ 1.652568] hub 1-1:1.0: USB hub found
[ 1.658587] mmcblk1: mmc1:0001 EB1QT 29.8 GiB
[ 1.661777] hub 1-1:1.0: 4 ports detected
[ 1.670263] mmcblk1: p1

You should change your root device specification to use PARTUUID,
instead of hardcoding the index.


Regards
ChenYu

> Thank you,
> Sergey
>
>
> On 17.11.2020 11:06, Chen-Yu Tsai wrote:
> > Hi,
> >
> > Please try linux-next. There were some regulator fixes that got merged recently.
> > One of them fixes an infinite recursion when resolving regulator supplies.
> >
> > ChenYu
> >
> > On Tue, Nov 17, 2020 at 1:12 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
> >> Hi, Maxime,
> >>
> >> it just hangs on that last lines and nothing happens anymore, see 5.18 log.
> >>
> >>
> >> On 16.11.2020 18:52, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
> >>>> Hi,
> >>>>
> >>>> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
> >>>> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
> >>>> boot logs for both versions https://pastebin.com/DTRZi8R7  and
> >>>> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
> >>>> kernel with default config, u-boot v2020.10.
> >>>>
> >>>> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
> >>>> The versions 5.8.18 and above all fail (5.9 and 5.10).
> >>>>
> >>>> Could you look at the problem or provide an advice about further
> >>>> investigation, please ?
> >>> I'm not quite sure what the issue is exactly? How does it fail to boot?
> >>>
> >>> Maxime
> >>
> >> Thank you,
> >> Sergey
> >>
>
