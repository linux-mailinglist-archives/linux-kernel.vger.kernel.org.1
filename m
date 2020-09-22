Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926D7274D33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIVXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:19:37 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:40456 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:19:37 -0400
Received: by mail-oo1-f68.google.com with SMTP id r4so4586873ooq.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cji0qFj1y7Q/mWiJAHJApgvwJbZGt2chl3dsq1MaaDY=;
        b=BCPF2ccAxB5pA4uDVfksusDv/bJgmgBLSA5Pg/teKJdZwhuuN66BjA9h+G+gMynN8c
         4WaaCv0i4ry6KsZmAP0i+Pw+D55NvfYg41xW9Qo93q3gkH6ZcFUOZF3GVBzFQTvtU/si
         B1+nVrCxjrHt5bbcuoiZf0PYP5nTgw/3uyIHNClvVnN2U0/wV464fwEdXZvodx0gPSRS
         JVtiDIo461VWi6XdR6awEIKvQhboFq/iU2RneJqZrIPCNAO+TIyz+TzGFpHpEEeK1n2S
         Pg2CHWjqEKhqaUWYKyAKDNHKUadswV0/oy+Sg8Ea52c4V7UAshmq6QJLPS8M59IChwB9
         FaLw==
X-Gm-Message-State: AOAM530EQFcgNtV4efiejxta8okbU4tH8okjrZsYpOdCIg7mpL5bzdH7
        IgGnTfOLFJMPKgxR7QaZvDbkaaISWRPxEA==
X-Google-Smtp-Source: ABdhPJy6fUROVRbfNDPjWwR92GIxDq7fx5QesIWxg0/jz8M/5ETU9WS8y7L8TTwSKZkt5OCalatYsw==
X-Received: by 2002:a4a:da4e:: with SMTP id f14mr4651479oou.40.1600816776360;
        Tue, 22 Sep 2020 16:19:36 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 189sm7857270oid.40.2020.09.22.16.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 16:19:35 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 95so9968396ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:19:35 -0700 (PDT)
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4538615oti.63.1600816775237;
 Tue, 22 Sep 2020 16:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200914041752.3702104-1-liushixin2@huawei.com>
In-Reply-To: <20200914041752.3702104-1-liushixin2@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 22 Sep 2020 18:19:23 -0500
X-Gmail-Original-Message-ID: <CADRPPNTf-SYkuZmTi+1bq_Fme_4M4aD4KnzJZnwKqQukD=JnQw@mail.gmail.com>
Message-ID: <CADRPPNTf-SYkuZmTi+1bq_Fme_4M4aD4KnzJZnwKqQukD=JnQw@mail.gmail.com>
Subject: Re: [PATCH -next] soc/qman: convert to use be32_add_cpu()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 10:56 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> drivers/soc/fsl/qbman/qman_test_api.c---

The patch seems to be messed up here.

I have fixed that, and applied for next.  Thanks.

>  drivers/soc/fsl/qbman/qman_test_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman_test_api.c b/drivers/soc/fsl/qbman/qman_test_api.c
> index 2895d062cf51..7066b2f1467c 100644
> --- a/drivers/soc/fsl/qbman/qman_test_api.c
> +++ b/drivers/soc/fsl/qbman/qman_test_api.c
> @@ -86,7 +86,7 @@ static void fd_inc(struct qm_fd *fd)
>         len--;
>         qm_fd_set_param(fd, fmt, off, len);
>
> -       fd->cmd = cpu_to_be32(be32_to_cpu(fd->cmd) + 1);
> +       be32_add_cpu(&fd->cmd, 1);
>  }
>
>  /* The only part of the 'fd' we can't memcmp() is the ppid */
> --
> 2.25.1
>
