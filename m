Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790E52AE1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKJVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJVea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:34:30 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB9C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:34:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so9754933qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqrVhYzb8a0/eQL0bLvdA9MvG4msw3Tt+QSyvoYvYys=;
        b=MiFdfXn0y34YBmXHg29ocMSB24QyE5LxOqXrRnao2l/bMMVUraEQC36Kb57Fb3Kq0I
         4rEzwiiLDnBrrXg9i0DtUQvxVLgzXongPU1fNmFslvjHlrHN56HSWLVaSdl8Jcl1yyLW
         FjARNDvwLCr6B3H++aFKANlfDgZOD2HYp0Vm8N7UDXDM0gVgxYn7Bu3PXA6mismny9jf
         qHa+Jm6+ANdpLM9YPIqZHEOq6x4fOFbe4TtQuWEXwoCF93NFnSacwLfdsv7AiZfoFMni
         g0Ft2G72dnA0mjWWywlg93Fkh054ZDV9/4DZeg+rSJ4rjAN+9e+N8mYmIMYwvZ7igwtd
         qn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqrVhYzb8a0/eQL0bLvdA9MvG4msw3Tt+QSyvoYvYys=;
        b=QyJfLJgPN/DMbfFFjKGdTlOtzrGQsHSvGuYwPftfudK/ZZHtPZAoA24KF2ffkvbQdJ
         pta89DunOjB6dYdJGwT6SiSTfkB1VaHUQlNTe8x9Ty9dQGV1mWhPQIig4BFP3qjYCNQi
         v9nDDECIBkPgxRiyZlcnGV8oOz+/Tx/gaD02yBPkBaXlwQqUpc3TcAA6zlVsPcw5wn7K
         bFCNTX88MhW93GwDY7W5TCbQISwcElZinp073EZ//HZpxppSXtjWA30YsGCWfOZDLkrm
         Ylb2ZEmyLZVcyE/swuwuypBpRE/Y1YtQDUTbsre128xNrh+q8IDVe3cEd806/wq6/DEG
         77zQ==
X-Gm-Message-State: AOAM530fwpooLSIOM7oy2fKFyH++nVs353AHAQr1Lm84a3JNpo+SQhfi
        h+15M/2Z4/sm54zxWg+CdTV3WO9odRkXFd1RoTI=
X-Google-Smtp-Source: ABdhPJxpaib4kGaPCwdyKN3MVlhJeEjrVro3/yy/4EKui/MjSKZ2G+EZXgpLlSCYjQBCs8FDM+i6HwHYbwueIVd0RNA=
X-Received: by 2002:ac8:2956:: with SMTP id z22mr18964042qtz.170.1605044069321;
 Tue, 10 Nov 2020 13:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20201014065443.18512-1-lizhe67@huawei.com>
In-Reply-To: <20201014065443.18512-1-lizhe67@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 10 Nov 2020 22:34:17 +0100
Message-ID: <CAFLxGvwO_i31AF350i+9w-7wg25NToyVFFBcG2oHXW3m9sS+MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] jffs2: fix ignoring mounting options problem during remounting
To:     Zhe Li <lizhe67@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, wangfangpeng1@huawei.com,
        zhongjubin@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, qiuxi1@huawei.com,
        chenjie6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:01 AM Zhe Li <lizhe67@huawei.com> wrote:
>
> From: lizhe <lizhe67@huawei.com>
>
> The jffs2 mount options will be ignored when remounting jffs2.
> It can be easily reproduced with the steps listed below.
> 1. mount -t jffs2 -o compr=none /dev/mtdblockx /mnt
> 2. mount -o remount compr=zlib /mnt
>
> Since ec10a24f10c8, the option parsing happens before fill_super and
> then pass fc, which contains the options parsing results, to function
> jffs2_reconfigure during remounting. But function jffs2_reconfigure do
> not update c->mount_opts.
>
> This patch add a function jffs2_update_mount_opts to fix this problem.

Oh, a regression. Thanks for fixing.

> By the way, I notice that tmpfs use the same way to update remounting
> options. If it is necessary to unify them?

If possible, sure. Maybe you can find a way to put the logic into fs/libfs.c

-- 
Thanks,
//richard
