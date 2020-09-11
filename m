Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD326682F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgIKSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:19:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F97C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 11:19:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so8598032qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUMNzPsZluP4A9WQF3+FT2V5kMfREvpaBzqUi2M9exA=;
        b=f0d5uzHehvTubKW5AXkQ2iZH08u25QqbA/58BP45d70peWpRrVpLscvQY1zhzKAmUw
         45ZKs3r42JDdoIQn0cvdIlCOMhaayxsFCQveuu3nLZstLXVH2b4lAaKGNSIQQeQpwJA4
         pYi1Axr/BkTlSVQ4CoS1y8RMKLS2H0ZPxppK2IRRDvWzp9TbacaI938kTyO6qRHuEeNW
         OFYXPFlHZkY9iTCZPN+tDq1W09Cr2s7mc3MpxCcJn/TV0kwGOJYjymH2w4FQWWxKkUIb
         kpXpZgjmRVS7yStq3JIQo9BjcDbSgSGNJTo2J7c5eaQYshJkfiWeifqR19eWxdItlQPe
         xUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUMNzPsZluP4A9WQF3+FT2V5kMfREvpaBzqUi2M9exA=;
        b=f/gwVx/g8HRb8GHkyrBBshCRD3fadcFiVOtWaLN/hZC5KCy1YnMI/+IPDIvyr1cm8f
         y2W9WvUdLu3x7AHm8vPTDoMqMEnnzzfidLfMWFQUiqA9F1oqh667Z2GaO+xbj2drninh
         pJE4hjmkKckMhmc245RWuvlWRrhlflTkrzWeycDKKFuPKKU2xL0y6Ts7/e04GKuZ07eZ
         b8COr2nRhwuVwihsIMw3bZ+9SIKkpXTdqT0pf+7mnmwWKIM2meMAc5pn/9bGZGaUB2tV
         2nNQVo+azvrB0o6yTkChMltD30o7S4h6fsUKYfEGtLcurelRu0VqCWXmage/3xbsdgwC
         BCIg==
X-Gm-Message-State: AOAM531OzYmYcG4VCyiA8HHG9T9w7bkdesizwCEMmTjKXf8XG2TEh9wp
        dmOUIgQ8g5EWEeTwBR2pEMurMw==
X-Google-Smtp-Source: ABdhPJxS51I8TpA7FH4QtwdoDh+RDwMsZ9DP69EVU43/gBXCUgmLXBu9VYXTwQB46rX9P7hTHh9pig==
X-Received: by 2002:aed:2d62:: with SMTP id h89mr3154762qtd.193.1599848380859;
        Fri, 11 Sep 2020 11:19:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y73sm3716420qkb.23.2020.09.11.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:19:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGne7-0057v5-GC; Fri, 11 Sep 2020 15:19:39 -0300
Date:   Fri, 11 Sep 2020 15:19:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911181939.GA1221970@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008e7c8f05aef61d8d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:09:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1002ea2d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600e053900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com

#syz test: https://github.com/jgunthorpe/linux ucma_migrate_fix

Jason
