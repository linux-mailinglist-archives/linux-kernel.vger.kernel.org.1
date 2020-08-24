Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F027250762
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHXSYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgHXSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:24:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF50C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:24:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s9so5020701lfs.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSM5pA9SWQyrteWcj7xcQCSKujeMY9ejX45tVYAfBoI=;
        b=DsE8cuz6Tnb5qD5lXMhQmBfbgz5KUNwN0GWr49phT2y0EJ71c1bWgsTkGaVRCjpxIW
         AvS1KhiLVpCAFVRHdd1pAmoDKAXHCDfPejKkBi4JI/+dRPzO6pkAHDqE6cSTnkxclpvF
         K+uzniqAUGswWvoSqfDBtFmOkpHh/P+SLTjyCk2x3l+qnSR99gEbLRKP+j9QrWvUeaEW
         bN2w2UdkHtDj75EjjFmTdkxBbd3QUZ7NmHYippV6atbmwdi45FV++tMsfKUeNSkxWNOQ
         qvQy1zR9GfxQUF5EMEGeV4/GnLExryISck/GJewEe+2aovUcpl2qJmeyM+3wKgViWH5b
         CUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSM5pA9SWQyrteWcj7xcQCSKujeMY9ejX45tVYAfBoI=;
        b=mvp77LPRYazIwzgAJ+kydQA6jMUCIyamRQ+tiEXMriXc5+jeXvAppJkpuuBN1mdLFT
         xZLRasSZUAZPhlD+alRhNOHJAuiiT/CKaJNjKMl1wLMFZK08tjtT/pVYLuOimUqF/6BX
         0yziZo8u77/3rSCibFsZcHSm6CNUnlVN/sgV60gOWKOlmsx+Z2a/0gEMmE4s99F5fby6
         jZ04HKnAOpBLVbl6Z5lEmegioS5ZG3ztyBkI8ZNh16ZfKvyfFQXd4MQijnnUIg/KJ9/V
         x3MowjXL1jvMAOrI+uLf+JVcrVNX5+G4UOIya8hC7y6PxQmkz6n1y1Uwp39AntHb/As2
         uwxA==
X-Gm-Message-State: AOAM530AMn+hqmry+xgLvdVpjFe37wmpeiERoOpTjTHr1yWawNVjxX3/
        ZvMkWehr3r568tN/Cwv8i6GM41y65rOZ3qhk+8B7kA==
X-Google-Smtp-Source: ABdhPJzh5kWNVpQmnUSWC2YPJatgcz6LX0E1Dzl49n/9qZdHiyEj+CE+CSzqUU+5wr/EC05GLEVG/YmrVDpX38FHVak=
X-Received: by 2002:a19:8c3:: with SMTP id 186mr3225689lfi.61.1598293456483;
 Mon, 24 Aug 2020 11:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200824154436.GA255257@gardel-login>
In-Reply-To: <20200824154436.GA255257@gardel-login>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 24 Aug 2020 20:24:05 +0200
Message-ID: <CAB0TPYEPWALD1iOP_5Rq0NKusJEvc_eOVVkoXRxjPtPTZU2GgA@mail.gmail.com>
Subject: Re: LOOP_CONFIGURE ioctl doesn't work if lo_offset/lo_sizelimit are set
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lennart,

Thanks for the report, I'll look into it. FWIW, we've been using
LOOP_CONFIGURE on Android with lo_offset/lo_sizelimit without issues,
but it may be a particular configuration that's causing issues.

Thanks,
Martijn

On Mon, Aug 24, 2020 at 5:44 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> Hi!
>
> Even with fe6a8fc5ed2f0081f17375ae2005718522c392c6 the LOOP_CONFIGURE
> ioctl doesn't work correctly. It gets confused if the
> lo_offset/lo_sizelimit fields are set to non-zero.
>
> In a quick test I ran (on Linux 5.8.3) I call LOOP_CONFIGURE with
> .lo_offset=3221204992 and .lo_sizelimit=50331648 and immediately
> verify the size of the block device with BLKGETSIZE64. It should of
> course return 50331648, but actually returns 3271557120. (the precise
> values have no particular relevance, it's just what I happened to use
> in my test.) If I instead use LOOP_SET_STATUS64 with the exact same
> parameters, everything works correctly. In either case, if I use
> LOOP_GET_STATUS64 insted of BLKGETSIZE64 to verify things, everything
> looks great.
>
> My guess is that the new ioctl simply doesn't properly propagate the
> size limit into the underlying block device like it should. I didn't
> have the time to investigate further though.
>
> Lennart
