Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00876239CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 00:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHBWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHBWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 18:10:23 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9BC061756
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 15:10:22 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so9859939qvo.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/9zZ5p0SBsYcCXdanUrC5EB8eHdMPxe1+JMyKoRc10=;
        b=E5aFGH1zhPwSIpxPBGW2p4cDlOq1GdjukqzSGRY7lg1+fl71R/Sobad6/Xe6h3qAfK
         Q7OpYW4iHyziHVd56/ynbsHOqmVYq4mLt8EN/PB5Cw/t+RPHc9gE/iL8jR3BL1C2FH6/
         yZB208L6AQV6NJRM4UFTOiAT091SYK8djQj/DLSpccwILqIMkvR7dCQvCj20/m4e0nTW
         Zrrte/TFrGqh80o+blo7awO2x4he1GY5sDjvod50Yr9KPVqIv0ezSsItF3WdyBmSQjpE
         Fdmvp1p14o3tdhYYhhRS1pmu4HlOlDKdEKF20MCsmZ/2jl+y26bOxs+iY05lshkWrsk0
         O6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/9zZ5p0SBsYcCXdanUrC5EB8eHdMPxe1+JMyKoRc10=;
        b=YpJMkIAq2L721S2CLi6XINA1yf317qsAZRiJqUNl/x6u++IoQaDZ0Oj5gwF9UFZRCY
         ekJ2dDZaGGjabhGAGfLQruACIn1aHAqH6FNd9NPVqevbwBbsnqNkOFw8d+KqaDTYiOOr
         lTJoWvxkCtSi6OKj2ftSh+eI4Egj0os3MaioN6WBzMnFd7kQUakRmdGUNZ91kYiGw4EJ
         IWD1xi3x15Ep7JssvZrfszeQ+u0yqXD98SXnqGH/5Hskma3oLQToxZ4cjEw0r8pKt8C6
         4KJDWhFl+MH36EdYlnJGG9T6dRG12fuH6e+vcSTrEZ2apSUaUl6xHQvakiG96jvEuYef
         er8A==
X-Gm-Message-State: AOAM532riQTYpZqkbZ3y9vUdRp6Zd54PBo/B9Ohl5yRqH5GwfvTGj43L
        MMfpkzGALtR35qvC3eqy27cODg==
X-Google-Smtp-Source: ABdhPJwuPyEEkUubTt/T0DTBZkrG/a1mit/K5GcIGmqhcC6v077uwjpHAS1lUty8mywd61HFxQNQMw==
X-Received: by 2002:ad4:51c8:: with SMTP id p8mr4370005qvq.31.1596406222034;
        Sun, 02 Aug 2020 15:10:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h13sm19138339qtu.7.2020.08.02.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 15:10:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k2MBQ-002pjS-Ao; Sun, 02 Aug 2020 19:10:20 -0300
Date:   Sun, 2 Aug 2020 19:10:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH net] rds: Prevent kernel-infoleak
 in rds_notify_queue_get()
Message-ID: <20200802221020.GN24045@ziepe.ca>
References: <20200730192026.110246-1-yepeilin.cs@gmail.com>
 <20200731045301.GI75549@unreal>
 <20200731053306.GA466103@kroah.com>
 <20200731053333.GB466103@kroah.com>
 <20200731140452.GE24045@ziepe.ca>
 <20200731142148.GA1718799@kroah.com>
 <20200731143604.GF24045@ziepe.ca>
 <20200731171924.GA2014207@kroah.com>
 <20200801053833.GK75549@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801053833.GK75549@unreal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 08:38:33AM +0300, Leon Romanovsky wrote:

> I'm using {} instead of {0} because of this GCC bug.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119

This is why the {} extension exists..

Jason
