Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B34D240323
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHJIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgHJIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:04:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385AAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:04:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so8555822ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2rGage70Jk5h0hvfFUtPxz+GuGpMqZrJcGzTBL46E8=;
        b=atzowz9SOphxx0a37O51EcGyBxaCNxJK5KNT8YE/hy6R/h3FcDTmlnk7ANBzGyJt1D
         WjG02Ed5JdaJ+PVsWHeFbPNl5dy6z72+8K/CJVaCVS9CgWqjF3cSi4HeCpDxbwBf42K0
         wShtwdqUlQG14UC7OhgJkXC+nUSBWM9/kBKGl/HUsfz+1WKZjaRCY0RWDLmpq+hoIbZq
         ARPgAGAOf32u/B9ILg4YHZBEnh3huWTJ9QYZ7eLiSGlVJUjI2rg0wA+/toCFJbC6bSsB
         ii1PERAazUQeO2OfLaFFpfvGNm4hzRg3DnMqh7qg7Zgp3jwTu/yiBJHFxcH0aVmMIEPd
         TbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2rGage70Jk5h0hvfFUtPxz+GuGpMqZrJcGzTBL46E8=;
        b=MWAN2qTP7dgkQsX1emSYymHMMF79r5p0w+qVCL4NFS/afxtiZlNS7CwlXPE5uE8vhN
         nhKRgK/OdwlIB4L6JwOI5dIMDJS5CEfxibihBRv6S0Inr7O2MNcm56hX6z3kToICqfMZ
         q25gDHOjaueGXqsEzmrPBN1O9sQu/H8iAY/gW5eHauW3Q4T/u4JwNFQCw2+qZYbUs0+S
         PwaRVl5xcODdUWikYvYrbk/pJq6SrYJbRiz5OyAHsLAIMf6Dj/++rL0DuAMICQC3vMrM
         mYNLCqnaq1njMTfjRSc2k/eyRNwc/5gy6CzRvI2eAE8opJVmYNzgX5KgM64C2hbhTJAv
         X6VQ==
X-Gm-Message-State: AOAM532EFCoscYtZsxvTB8smkTMPI8Ueozgja3vcUAA4H+V8w1TknDdM
        FWzvRu9Cf5DqeQhFPwJ2t/XUBc+vY2gnyNTKYIw2Zw==
X-Google-Smtp-Source: ABdhPJyers0WzewoH8+10vmN5DZUr86ob+cLHqutbtp3jkGybBSDFsktjvhIBCpkC2iaIFZU2u1mTfZxtrZNW38+MSw=
X-Received: by 2002:a05:651c:1350:: with SMTP id j16mr11206533ljb.227.1597046656643;
 Mon, 10 Aug 2020 01:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200806073221.GA219724@gardel-login> <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
 <20200807153134.GA222272@gardel-login>
In-Reply-To: <20200807153134.GA222272@gardel-login>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 10 Aug 2020 10:04:05 +0200
Message-ID: <CAB0TPYGz=GN4x2-Msh4Ras6EgRTkGET6iALnp_v9pGSrGr1KgA@mail.gmail.com>
Subject: Re: [PATCH] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
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

On Fri, Aug 7, 2020 at 5:31 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> Thanks for the review. I'll fix this up and send a v2. Are you OK with
> me adding your Ack to the patch?

Yeah, sure!

> And also should this geta cc for stable?

LOOP_CONFIGURE was just added in v5.8, and stable is v5.7 now, so I
don't think that's needed.

Thanks,
Martijn

>
> Thanks,
>
> Lennart
>
> --
> Lennart Poettering, Berlin
