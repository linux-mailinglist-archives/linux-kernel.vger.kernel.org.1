Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC22FF8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbhAUXWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbhAUXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:21:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E6C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:21:03 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f11so4442290ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGtXJ9JSGxtBc9xg3WRFWW32mVSM+OhKXJJnwYOIaH8=;
        b=rQ5kYcRgKxaek75+QtT2RaTkkaOSXLf7tvSbcjzY2DdFv8GXepB+qApS1tGx0cSB+T
         C1bO3TvVY/KuRpM6zK4zgVl91lpYDM4+TOT2bhqIsqcJEPQHyomWRu+uBcCyOGF2Zpnx
         hvlnTZz1lnNsfGJWjztmol9dymRW0GSCfAqdT6Lvoj0X/QSREG/arcGxmGDvDXLcM4h7
         IggIQbxXdKD5KDoi2ojculnbBGt8HeeusoFoh0UXo7sfneScir/bBAq1I0EXGnBjr1Up
         xLSHd0KN31iPzjyeXyMs7XV3rSq8371KbFrBAYGOxsDTYcV7QhRchXEV2hNQR7wF7MKn
         iLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGtXJ9JSGxtBc9xg3WRFWW32mVSM+OhKXJJnwYOIaH8=;
        b=pB9s5cr9/UTAYbJ+i1axLGtSuhBtZnx6QAVeUUbJuGiWRMQryzkZy3n7bRgt/tsiKM
         mOxfmKcbCcI4PCmDinW05UjnkoVookZYF5R+Ih4V3zMIqeQCorJjOe+CQUQ4xRpcQfN5
         UZLbIZq10pLbI/RKFZE14JYkOHayUa4oXEGeNv6DySkZsYGrHeNeBY5G68AMaxw1e0Bf
         qVPdqAXciazbtECGRV3sfqn3PwX7OConthf9vs2t7MNG17n1xNpfaTMcJzFv9F0ntrmm
         X/UCzVIhDeoYl1I8unCvVXP0+6aPBZahrGPTuEVw5MctclqugSKNDlPSPd4mB6qAxksB
         Gl3w==
X-Gm-Message-State: AOAM531bCTu4LL4BZlZym2JiPQ5c/MNMnQgfsL/2ZCfFdRr0OV8wdb6c
        XdomUcOhyHF2nfJoJHmcgN4c8e9E2h8TqArLvbqgyg==
X-Google-Smtp-Source: ABdhPJxgoZFXwC/GJMoLTVnJ9jo6wg5JBDrPwbNgtDIDaYGc88FWKCooZ+gkYoMaXwLPzopG+G/5NzzEWXMwXq/wcAY=
X-Received: by 2002:a2e:b1d2:: with SMTP id e18mr54330lja.101.1611271262294;
 Thu, 21 Jan 2021 15:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20210121072202.120810-1-bianpan2016@163.com> <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io> <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
 <59a735f0-9fef-5e6d-f7eb-851e14a2883e@lightnvm.io> <CAJbgVnW40qrYBdsM6dC5uhDFZJJDc9kwvCWtK24Rg5GWCHpb2g@mail.gmail.com>
 <586510be-5a56-5e99-6ee6-ee20031f166b@lightnvm.io>
In-Reply-To: <586510be-5a56-5e99-6ee6-ee20031f166b@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 21 Jan 2021 15:20:51 -0800
Message-ID: <CAJbgVnXXnLvWx-TtJh1YJxPfv+=_L2+gt0vNPpYKoLCOkCBN4Q@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, Matias, I am going to look out for dm-zap!

On Thu, Jan 21, 2021 at 12:14 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 21/01/2021 20.49, Heiner Litz wrote:
> > there are a couple more, but again I would understand if those are
> > deemed not important enough to keep it.
> >
> > device emulation of (non-ZNS) SSD block device
>
> That'll soon be available. We will be open-sourcing a new device mapper
> (dm-zap), which implements an indirection layer that enables ZNS SSDs to
> be exposed as a conventional block device.
>
> > die control: yes endurance groups would help but I am not aware of any
> > vendor supporting it
> It is out there. Although, is this still important in 2021? OCSSD was
> made back in the days where media program/erase suspend wasn't commonly
> available and SSD controller were more simple. With today's media and
> SSD controllers, it is hard to compete without leaving media throughput
> on the table. If needed, splitting a drive into a few partitions should
> be sufficient for many many types of workloads.
> > finer-grained control: 1000's of open blocks vs. a handful of
> > concurrently open zones
>
> It is dependent on the implementation - ZNS SSDs also supports 1000's of
> open zones.
>
> Wrt to available OCSSD hardware - there isn't, to my knowledge, proper
> implementations available, where media reliability is taken into account.
>
> Generally for the OCSSD hardware implementations, their UBER is
> extremely low, and as such RAID or similar schemes must be implemented
> on the host. pblk does not implement this, so at best, one should not
> store data if one wants to get it back at some point. It also makes for
> an unfair SSD comparison, as there is much more to an SSD than what
> OCSSD + pblk implements. At worst, it'll lead to false understanding of
> the challenges of making SSDs, and at best, work can be used as the
> foundation for doing an actual SSD implementation.
>
> > OOB area: helpful for L2P recovery
>
> It is known as LBA metadata in NVMe. It is commonly available in many of
> today's SSD.
>
> I understand your point that there is a lot of flexibility, but my
> counter point is that there isn't anything in OCSSD, that is not
> implementable or commonly available using today's NVMe concepts.
> Furthermore, the known OCSSD research platforms can easily be updated to
> expose the OCSSD characteristics through standardized NVMe concepts.
> That would probably make for a good research paper.
>
>
