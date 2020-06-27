Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBE20C4B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgF0WZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgF0WZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:25:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D1C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:25:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so6080644qvb.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B7GpCtb/sR/TjCdWqWZIsoVoP3af+VvPEeIrSBxtNwQ=;
        b=ALBY/7OwEiOqs4GU7y1mMMiUAO7d8R/zMkOaYa2sunQGk6iCtyuYONJshXcxOblkeS
         ke3ez/h975geKvV03lXJdffAbEq86yU6xL4sprCC9UROXEg6951nNjyLK2CWUOa6IiAT
         Nk8mhHzaY3Z9LI1hO4V2kpsHJtqSuc8mKGy29vA5ghe7uJrf8Jj6ILMQLPQTts5WLgsl
         HFJkR/MokZhuFeZNeeg5qzOBWUzgeCVOx/lwgb4MVis3LKwqUK1Jedy74CUw26JDcAVR
         7Mi2uoaGqNfImIjzSkLJQZ8Gn6lE/Eprr2FLOXvCr/KIcFU0ehlv7WzkRjH2eAZgBJHC
         h8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B7GpCtb/sR/TjCdWqWZIsoVoP3af+VvPEeIrSBxtNwQ=;
        b=G4YoPPG5qHgLLCMrlRlE4lhBV//CQs5bDQaU+3TJ/T5Pw3gX6LV12kyDZOY8f1PT01
         mtjNkOGMqu4MDjquTeYtnA73WJ6cGl4rQgMH/GL3vBPrOUlCTozME/FqhK9DED2dfUz6
         DhFNQpJz9MAdkmPebCvAKJ/RYCfdbLNdvO6VE8U5hu59t+mqCG5zxKb0z9k8RqpoFSfv
         CbJL3xPOp9EK0teVU74ATcFp3/79U/cugSu2rX6RwUpHBGpW4VnVM/ZJ/y4Z03Ru7XLr
         EnQC7jaRB4l6xY1NLjuKC86bVIVvcbJQpzue/kXMNKIoQg67hYNKgGNKE5oVR4vaXbXC
         SZ6A==
X-Gm-Message-State: AOAM532n/DeifIGknurl22JiMwM1EmeVB+025c8tsCsO0G8HdvpznZ7R
        NDNWsJk4Lx+VuCgJDwiZJq4GNQ==
X-Google-Smtp-Source: ABdhPJxlXMh1W9yDUlNTSm+3IU2P2JTP2cJj/PP3kid1a5TVpbuIyOC5ajObbm4cht3FuYpwxRv6kQ==
X-Received: by 2002:a0c:f281:: with SMTP id k1mr3159188qvl.219.1593296728910;
        Sat, 27 Jun 2020 15:25:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 125sm3067882qkg.88.2020.06.27.15.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 15:25:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jpJGJ-000iUW-Gu; Sat, 27 Jun 2020 19:25:27 -0300
Date:   Sat, 27 Jun 2020 19:25:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
Message-ID: <20200627222527.GC25301@ziepe.ca>
References: <000000000000107b4605a7bdce7d@google.com>
 <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627130205.16900-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > So, to hit this syzkaller one of these must have happened:
> >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> >     runnable/running
> 
> What syzbot reported indicates that the kworker did survive not only
> canceling work but the handler_mutex, despite it's a sync cancel that
> waits for the work to complete.

The syzbot report doesn't confirm that the cancel work was actaully
called.

The most likely situation is that it was skipped because of the state
mangling the patch fixes..

> >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> >     rdma_addr_cancel()
> 
> The cancel does cover the query state in the reported case, and have
> difficult time working out what's in the patch below preventing the
> work from going across the line the sync cancel draws. That's the
> question we can revisit once there is a reproducer available.

rdma-cm never seems to get reproducers from syzkaller

Jason
