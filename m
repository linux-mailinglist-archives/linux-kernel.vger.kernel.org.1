Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E292FAE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393943AbhASCJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393686AbhASCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:09:20 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A833C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:08:40 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z22so9998236ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVKJevWzueCVAkcyRkI1o5hoDMIGCjKtPdus7P5QKvc=;
        b=ZY2lBCQwCM1jTC64rZC634Tef5GP9NUExZtzi1rSEBcQ/GC5Gobbj9Z1sLpdBKWyd7
         Jn+AQLyEzcMZXq2ZTIW8YvdrEXyY4oexkb0KlZb438EUO58UJEAO8p45W7t9wDvMepKP
         3/UzGKIvTnshrqsfHEWndH/tvm5NrkSxYfXV/4nRMp0CjxZV5OeX6jIY2Sv8QmjyMw4c
         UzvdmE5q9tegAkmpJZrpUuDoqz4p2zBJsxk1xKMmySV/8D2kPOCG9CJ4eGckb+BZD62v
         d/LFnLCRxeTZ6aAU7p+GCDIvogJZAPS4CVTaWMSN3ObDBSvG/nxhQRCjZDrRReB59J0k
         YRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVKJevWzueCVAkcyRkI1o5hoDMIGCjKtPdus7P5QKvc=;
        b=QbEjH6/xhUCPqJ2ni1UvC8NdPZ6dOKoYk52iYdBBftf1/kPvMenX0Z1c+C0XEdKv3Y
         iwEURaSm+3lxD/b/v9V6RC+ewnR2ry34Ax4BdSNT7Fj1Hi7XbVEblDsfqQqmEgFAG+5J
         H6vndqYF5yBfJxSTtKnRWlD6coEunF8nRpMh0BTZRu4l0lNZkau+/10VOu8O8sZ8coDq
         H1wgGnwBdGhyhA5FNWoKYg1pKQJawkwoUK2EKuWrE6NCGQS4J70/Y3M6BoCRG2fkM6En
         rh/Fy5PhPDktkY3CJ36u9AN6o37zh+ckRLM3WRhAd573VVcmi55wX/+Xvnlm06/e0tSA
         RfQg==
X-Gm-Message-State: AOAM530rthNs9vxn1wHqrNd1ap3+MQ1qhcnhN998bTrgcK8Kf/N5LNWO
        MCvwmxqidV9KQbtIPvymzYXdpRVqMhQkknahffs=
X-Google-Smtp-Source: ABdhPJxSFOJ1j8MRnzxzeXGhyxA6sM45HDq+vG86AtrG6/5p/zvrsWbe/GBdQutBpkeBb4jm+/3yvy0jQlpDBKbkMbA=
X-Received: by 2002:a05:6638:b16:: with SMTP id a22mr1637083jab.56.1611022119466;
 Mon, 18 Jan 2021 18:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20210118080455.33499-1-dong.menglong@zte.com.cn>
In-Reply-To: <20210118080455.33499-1-dong.menglong@zte.com.cn>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 19 Jan 2021 10:08:28 +0800
Message-ID: <CAJhGHyBVvdpSoXgVdkTiq1LTS-VSiNjwLJh5TTX1_gk==hWCfA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix annotation for WQ_SYSFS
To:     menglong8.dong@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 4:05 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> 'wq_sysfs_register()' in annotation for 'WQ_SYSFS' is unavailable,
> change it to 'workqueue_sysfs_register()'.
>
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> ---
>  include/linux/workqueue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 26de0cae2a0a..d15a7730ee18 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -311,7 +311,7 @@ enum {
>         WQ_MEM_RECLAIM          = 1 << 3, /* may be used for memory reclaim */
>         WQ_HIGHPRI              = 1 << 4, /* high priority */
>         WQ_CPU_INTENSIVE        = 1 << 5, /* cpu intensive workqueue */
> -       WQ_SYSFS                = 1 << 6, /* visible in sysfs, see wq_sysfs_register() */
> +       WQ_SYSFS                = 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
>
>         /*
>          * Per-cpu workqueues are generally preferred because they tend to
> --
> 2.25.1
>
