Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C322D2D33CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgLHU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:26:04 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:25:17 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a8so33950lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XU1lJ/FiyE51Ek5hTlJjhkSrQF4pKw8F/EUPUJF0It8=;
        b=h/V9VvosYnXbDksZuJ62HRfIJnAPcg2Pgv5nAm5eT1C9zk0cin1MScSPABv1L/auoa
         VjONxS2l36zyTZJDXS7BPEyqz4Q2PrH+pWkkSZStGEmgNmWPNYCy/MnhLMOvnf7XGt3Q
         yHJJNfcM0C98Iripdiw84+Z8CbYGMWxZaeKFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XU1lJ/FiyE51Ek5hTlJjhkSrQF4pKw8F/EUPUJF0It8=;
        b=qiyUo2a0cKaITgj8SvJZAjw7p/kYNulVHx275upZpjuzO2bgOvA7a2kI+c2WQ/JCdc
         /MMsMke4HfYgKeAROffakwG4kdL8cZWTNX6DGZ+K2OWyE3wr6upykppCsOumBt7vfLsD
         d5vMS7rPL2C6ya3lnUFz5RbeUGBKolp95jh9OqOxo6hb3JAMO95IHb2udJNrlF2v7bqE
         a8/I82KU0EMAl2GyNuT5qWyIgYr0KrijvbYTQ8+4/Zqu5lTIWhmV+LvfYuAkeCXyvf/O
         1jajrfGd7CnFtzAkMhC9GRf6fqd4Jfz8BCJCs311LtJbCsp1dsWGiWcdo8yqwFbWnTmx
         sLow==
X-Gm-Message-State: AOAM533bWQZCVPh1zFy4SY2EqyYQVDvEhAhUW0LjJUDXEm3AGt6zYRXj
        tc2llcPFjK5jmb/qs5BWq8cnxd1+S/bXTg==
X-Google-Smtp-Source: ABdhPJxiYRC2zJtT79iQDXJfkspQWYJ83SiHkZcifS3Sg4PXJTuJphuQL8/Z3MAqBdTxK+V6zBVr2A==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr2143231ljj.413.1607455180865;
        Tue, 08 Dec 2020 11:19:40 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a7sm748611lfg.243.2020.12.08.11.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 11:19:39 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id f11so9543219ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 11:19:39 -0800 (PST)
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr11600912ljg.465.1607455178788;
 Tue, 08 Dec 2020 11:19:38 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com> <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 11:19:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
Message-ID: <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 10:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> > So I'm adding SCSI people to the cc, just in case they go "Hmm..".
>
> Only change in this department was:
>
> 831e3405c2a3 scsi: core: Don't start concurrent async scan on same host

Yeah, I found that one too, and dismissed it for the same reason you
did - it wasn't in rc1. Plus it looked very simple.

That said, maybe Julia might have misspoken, and rc1 was ok, so I
guess it's possible. The scan_mutex does show up in that "locks held"
list, although I can't see why it would matter. But it does
potentially change timing (so it could expose some existing race), if
nothing else.

But let's make sure Jens is aware of this too, in case it's some ATA
issue. Not that any of those handful of 5.10 changes look remotely
likely _either_.

Jens, see

   https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2012081813310.2680@hadrien/

if you don't already have the lkml thread locally.. There's not enough
of the dmesg to even really guess what Julia's actual hardware is,
apart from it being a Seagate SATA disk. Julia? What controllers and
disks do you have show up when things work?

             Linus
