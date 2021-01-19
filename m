Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616782FC242
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbhASV0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbhASSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:45:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A94C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:44:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id h4so22900361qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26hOmcs1ZFwlV0P5j8AlWS9tixqHW+LF5uegLj5p6b0=;
        b=b/StF/aIqwvXqCSIC65E7E8JUoyIek0eEPFL6QikaWiRgM6mNIOZmo6s10qWo04UOR
         jP8KPOZ6cWtf1b/T94Uo9PplRKQ4R9OfCdMBFfIAmCdZ+UsO8q2pSRYfjbQ2SdRqZiOx
         hy81hcg9f+Z7H7c7igHpYnFhwifmti68635yxxLGlR4jBgSQHXZqo2ZB+CIHAfYNXchK
         SVDiye6/Bmxh7XF3wvokxanI3uJkwrxcA2u+Jbx9KG6tzR6/beR9EvOZL0x8pDOPbNfP
         q/mtnTxEa/uNwKwonDVvLQNRk/yTPSMpKi0PQqG5cKeYjrsbFhH/tkwej/IDPQDqyxdX
         QwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26hOmcs1ZFwlV0P5j8AlWS9tixqHW+LF5uegLj5p6b0=;
        b=nmnPokxTrfGhoBM3dWOGcj22rrX6rUE+xhXCfz/k8Uc4nEyU9M1LKLfOzZpx1NPTWt
         SyF9QLQ3EsKOEwetORomdxse45VDqsMOXbr1rPMbEfYvW0kxb0sfp7m19NjB4LHkH9DO
         mbor8bo1ad6PuBlHrsHJ6SmL0KMstkdFZ7wbha4WEh4CeWErEDHTgXYWco2GjKC/kQOR
         3MecTImOof6MlZ0REgcjPxjhjNGdU5YbdMi3nRIyMfN18uyoZ1fG+BnD4no+you9BHWd
         UTMn3t6ETBUN6fztEMl0nz62PylNt8gxXe/WprtC6f0W760ril075MTYilQ1rxbT6NbK
         cxPg==
X-Gm-Message-State: AOAM5313XwC+Hu7I2vMxDce1EOPGFBAxzI+UT+w63T9n5f6827j16kJB
        17Q4mcaYg9bCt22sRQ7BOKkFYZFqyxisjw==
X-Google-Smtp-Source: ABdhPJyq0pj1DSKim2tiHKCcVLAYKOKzMtvbQ76/G0aVSuKxX7RkufNfnUa1rpUvzeGDlcYmiBZoXQ==
X-Received: by 2002:a05:620a:1398:: with SMTP id k24mr5751440qki.109.1611081862587;
        Tue, 19 Jan 2021 10:44:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j66sm679287qkf.78.2021.01.19.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:44:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vzJ-003pxR-Lq; Tue, 19 Jan 2021 14:44:21 -0400
Date:   Tue, 19 Jan 2021 14:44:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, rpearson@hpe.com,
        rpearsonhpe@gmail.com, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
Subject: Re: BUG: sleeping function called from invalid context in
 rxe_alloc_nl
Message-ID: <20210119184421.GC4605@ziepe.ca>
References: <00000000000081830a05b9445165@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000081830a05b9445165@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:39:19AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b4bb878f Add linux-next specific files for 20210119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d34e9f500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7b1ca623d7cc5ca3
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec2fd72374785d0e558e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148035af500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb8494d00000
> 
> The issue was bisected to:
> 
> commit 3853c35e243d56238159e8365b6aca410bdd4576
> Author: Bob Pearson <rpearsonhpe@gmail.com>
> Date:   Wed Dec 16 23:15:49 2020 +0000
> 
>     RDMA/rxe: Add unlocked versions of pool APIs
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126612d0d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=116612d0d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=166612d0d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
> Fixes: 3853c35e243d ("RDMA/rxe: Add unlocked versions of pool APIs")
> 
> netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> infiniband syz2: set active
> infiniband syz2: added bond_slave_0
> BUG: sleeping function called from invalid context at drivers/infiniband/sw/rxe/rxe_pool.c:346
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8459, name: syz-executor401
> 6 locks held by syz-executor401/8459:
>  #0: ffffffff8fc4a418 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x161/0x690 drivers/infiniband/core/netlink.c:164
>  #1: ffffffff8c78ced0 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x261/0x540 drivers/infiniband/core/nldev.c:1545
>  #2: ffffffff8c77c470 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3b0 drivers/infiniband/core/device.c:1307
>  #3: ffffffff8c77c330 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x15b/0x3b0 drivers/infiniband/core/device.c:1315
>  #4: ffff88802adc8598 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:715
>  #5: ffff88802adc9640 (&pool->pool_lock){....}-{2:2}, at: rxe_alloc+0x1b/0x40 drivers/infiniband/sw/rxe/rxe_pool.c:384

Bob, yes, this is busted up

        read_lock_irqsave(&pool->pool_lock, flags);
        obj = rxe_alloc_nl(pool);
        read_unlock_irqrestore(&pool->pool_lock, flags);

Those are spin locks

void *rxe_alloc_nl(struct rxe_pool *pool)
{
        obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
                      GFP_ATOMIC : GFP_KERNEL);

And that is always calling GFP_KERNEL inside a spinlock, regardless of
ATOMIC

No idea how this should be fixed

Jason
