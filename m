Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D71B4CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgDVSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDVSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:55:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CEFC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:55:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so1996327qkd.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xLUryRWs2hS8C6rmdpuM1w1GZL5DMkigM47LhtMAQbY=;
        b=diK9Pqlk64BLQ1DKCWq4alJLwqOwl8lX2xNeh6ahfNizfenun/PLDEBEaoSIcU2+O2
         kty4ZXG4ZSbMldO5+OnRbMo4RjQeqZlFlxPS0kXnkP0HKz7ED2okkR0jk19mt2gOUSiI
         vHK3sbe0Xh1tR/QYvB88Lid/yNGCMfkgGygQtdtPdvdXjCz3Zl7lRjF/3CJh6jrQGQlW
         B7m4ucg4dYftjbTZ1IN9cj6hcr1+h+saAcYtxAouFgD8S6dHw0ePHREQ3TWWatqxz2Ls
         cnevsjBa3KSH+mOXAnAiFz0EuEsie6sKJ0dA7xzSDCVoZyGsIxRobey12WGXWDJ1w74c
         A4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLUryRWs2hS8C6rmdpuM1w1GZL5DMkigM47LhtMAQbY=;
        b=meaX4vVL5Z1kovNlIDruRvNRqAxEVmv87V/J6u7dSGFMav585fJuk1KPPdkEskYmdF
         GtSsNfZovMTSje3x6O6qhvlUhEj6Xrh7f/rZ/Xl4K0CMHLSUzbFe04lH2dZLjc77uKCm
         GKtwzwe4Bo0vXH+Hoty4tDYn0zEA889PvVeKIN3+Cf2ltzQ4fbTJz60kAV7TuX4YkJMU
         E3YnEel5VidQwrCIcsYzzE1KjAtwWfauQ/x8NDtm5t7I1RSUXxuZueQqT99AUhC/wuoB
         w7T0DUhbiOCIz0douKZ9aXZrBhk8gPagjjCC2ljI4fb+XQjRVPKDG+tcJGM4QLOPQ3FR
         pzXw==
X-Gm-Message-State: AGi0PuZ1VS/Rz0gXjlsmiVjPCa89WZHH68kU5p9Lr/h6LwurcPdShBw3
        MrW1HhDKVFyuQIyvU5+ilKwTEg==
X-Google-Smtp-Source: APiQypLxT4cQDVOJW5C6AxROGVfl/mi3cYixvqOcyBz8pQ58M8OWm5vyj6Ueu2R3gSlG6DiLoDcZ9w==
X-Received: by 2002:a37:7443:: with SMTP id p64mr26002162qkc.269.1587581726859;
        Wed, 22 Apr 2020 11:55:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o94sm62648qtd.34.2020.04.22.11.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 11:55:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRKWr-0003jf-Oo; Wed, 22 Apr 2020 15:55:25 -0300
Date:   Wed, 22 Apr 2020 15:55:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/2] Two fixes in handling FD object
Message-ID: <20200422185525.GA14322@ziepe.ca>
References: <20200421082929.311931-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421082929.311931-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:29:27AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> These two patches are fixing two crashes in FD object handling.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/core: Prevent mixed use of FDs between shared ufiles
>   RDMA/core: Fix overwriting of uobj in case of error

Applied to for-rc, thanks

Jason
