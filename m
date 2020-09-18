Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50842700F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIRP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:28:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596DAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:28:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so6457270qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87exJI9IxcsmEwjFodxzp48tvLwR0SvkIumnx6ayv20=;
        b=GS37Kps2Y7cepRmntyF2JhjXN55pywjVB6NfRKm3IDQZUIbc3SnfOM2dBj10vSzVP9
         9MyByCmtgFQozubkaMoNBtDr54DeBh095RjmM8RbXmt5biYJ7EaaPWFP/UJ9b5yRyGh/
         c5mfDT8B+oNsdlnSuxpqlgb8Uxiu3i7kpM5Jt5pcu5tMBC0N/wStqQz/tQMRU3KPDF4o
         SGttK2J6uCx/4SSr9m0eWrGhYQtlkPEdz1vLjlV1G3WStrIXmg/fTjUUOuiixJ7owRZd
         CSXWxD4+bsduuRrKVYwTGdw/xxz8y0NvcYFLTXWihUYdvmEJ2M7yJ8Yyr8JI5xzSy71C
         0fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87exJI9IxcsmEwjFodxzp48tvLwR0SvkIumnx6ayv20=;
        b=gIQgVlaSigQcCWNk5AC0fd+LziiEQn98ROJjfF6KqPTL4Zlu/OtngyuAuG1lTgMEvc
         zmo5boNf4CKEFsbMoXaRSUJkZSlaU2haAvMwc8g3+ihmToVNWSt7QdEZsI8D94Pw2oHT
         7zSX3ufLzTPkzHOQU/XARpgDG92g6BZd+xoiIvmJ9lQLcwYPPQoVaL0VyD15qfB5x+jy
         QRNtp6gSLaYW9ByMzzi49tgpX/6mK9+lmeguxLYwY/8SwIxdpMrMdaGSq+eFI3t4kJfa
         QTEHgRo8UHprlwIH1mxIExNJlijIZI9U+Zwd7BVjJ5JExy2BGLHf9fVVC/TlNCOMUTU6
         ksrQ==
X-Gm-Message-State: AOAM532BTw6nZ9vphBjKC8bpso/RLX+RRcMTy2wEZXRWNYxWdTb4yARt
        OZkpIgousMgmJZTYZdSwpwEtew==
X-Google-Smtp-Source: ABdhPJxtfdYczByA+wq6Dy80t6ZWfoGQ/n9DkJW66Fk8Bud2jQd+D9ALLnqX4eZSIcD/6lD6QRePAw==
X-Received: by 2002:a37:7d87:: with SMTP id y129mr34623123qkc.108.1600442933623;
        Fri, 18 Sep 2020 08:28:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f8sm2272544qtx.81.2020.09.18.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 08:28:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJIJg-001JgL-2m; Fri, 18 Sep 2020 12:28:52 -0300
Date:   Fri, 18 Sep 2020 12:28:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, izur@habana.ai,
        Gal Pressman <galpress@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rdma@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 00/14] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200918152852.GW8409@ziepe.ca>
References: <20200918125014.GR8409@ziepe.ca>
 <CAFCwf12oK4RXYhgzXiN_YvXvjoW1Fwx1xBzR3Y5E4RLvzn_vhA@mail.gmail.com>
 <20200918132645.GS8409@ziepe.ca>
 <CAFCwf109t5=GuNvqTqLUCiYbjLC6o2xVoLY5C-SBqbN66f6wxg@mail.gmail.com>
 <20200918135915.GT8409@ziepe.ca>
 <CAFCwf13rJgb4=as7yW-2ZHvSnUd2NK1GP0UKKjyMfkB3vsnE5w@mail.gmail.com>
 <20200918141909.GU8409@ziepe.ca>
 <CAFCwf121_UNivhfPfO6uFoHbF+2Odeb1c3+482bOXeOZUsEnug@mail.gmail.com>
 <20200918150735.GV8409@ziepe.ca>
 <CAFCwf13y1VVy90zAoBPC-Gfj6mwMVbefh3fxKDVneuscp4esqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13y1VVy90zAoBPC-Gfj6mwMVbefh3fxKDVneuscp4esqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:15:52PM +0300, Oded Gabbay wrote:

> I'm sorry, but you won't be able to convince me here that I need to
> "enslave" my entire code to RDMA, just because my ASIC "also" has some
> RDMA ports.

You can't recreate common shared subsystems in a driver just because
you don't want to work with the subsystem.

I don't care what else the ASIC has. In Linux the netdev part is
exposed through netdev, the RDMA part through RDMA, the
totally-not-a-GPU part through drivers/misc.

It is always been this way. Chelsio didn't get to rebuild the SCSI
stack in their driver just because "storage is a small part of their
device"

Drivers are not allowed to re-implement I2C/SPI/etc without re-using
the comon code for that just because "I2C is a small part of their
device"

Exposing to userspace the creation of RoCE QPs and their related
objects are unambiguously a RDMA subsystem task. I don't even know how
you think you can argue it is not. It is your company proudly claiming
the device has 100G RoCE ports in all the marketing literature, after
all.

It is too bad the device has a non-standards compliant implementation
of RoCE so this will be a bit hard for you. Oh well.

Jason
