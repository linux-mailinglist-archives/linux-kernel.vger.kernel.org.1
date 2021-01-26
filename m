Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA86303A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbhAZK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbhAZBbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:07 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6EC061BD1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:13:06 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o18so11177430qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RCicovIuFlmz+ypg8L3PoOuWlGavLF3Xg9FrMyiBxf8=;
        b=FB2Tpuc1HrWHU67D7lihDbhcABDw5J5jULrlvaEJiPnINhch/RYMx7KL9QSB7Af8dY
         eH5T39U+ajK31mQxL1tWTDvzMpIG97rSMoZXoSjD8DhGhUGc35qANZRwTXlDuQluhV13
         Ql5lQPMXrM7LhYGrk7FkUEgp8wsEtvO5FzDN26ha0sAcxusN1/qGjE7U5vjZ158aS0+G
         MPy3uXN88BmRua0FNN6IoBJSSK7zVWM4st6ypV63RN9lQ9q9+xjmW9rJC9qnDzaXN7t8
         lBtssPvQLIz/CZJQMZIXYo/GnVdnm2+8Y4kXGKOPFxcqVA9HhwPemMQrEhpXii7XrXJ3
         ItJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCicovIuFlmz+ypg8L3PoOuWlGavLF3Xg9FrMyiBxf8=;
        b=Vd/kFoxuAA8EFzTbseXsblWWE4JMuVW9LjMPMcd4XMxDC0yd/XTpPJGdiLaih1VJ/r
         WjEk03R71XKrQ5S56qvke3qVZ3o1z+xY/PCPysyCa4aPfepLrVh9yUUEsFzaJNKYIx17
         uu43yOXG8GwA7QptiJoQqXy1WvJgvH0rtlgVe94MkOVinzhQo0TlNPZGJrELeT2MG5EJ
         aOXR2eCPTYkVP0eEjtNAdO8Re7gZk68zPS9FoFX0mRCNL5gKy9ONYD4KkYWP+cc6Rgvr
         s3u/XG3b2u55LyUsTby47+uwMy7/0XcHKq4dfVczSv2Klb7C3/1elVMM324bZ4MNFV5N
         wzWQ==
X-Gm-Message-State: AOAM53019OgIDqZZ4N1dnkOhPutYN2+uKLgFXn08TzsPfgnI/BOAVpZl
        E7bfn8JMrQv07b+IAaW+yv1V698YrAsy7lJF
X-Google-Smtp-Source: ABdhPJxpdPeFFvMV3gAxS1etvOF2FWSYe21i1REZljAHSmM3iwf+cRwhsoyKqoNP4Os8WkMpKLF4aA==
X-Received: by 2002:ac8:698a:: with SMTP id o10mr3184010qtq.242.1611623585887;
        Mon, 25 Jan 2021 17:13:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 16sm12266715qtp.38.2021.01.25.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:13:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l4Cum-006tPi-OX; Mon, 25 Jan 2021 21:13:04 -0400
Date:   Mon, 25 Jan 2021 21:13:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210126011304.GZ4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:

> > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> > > mlock, while certainly be able to prevent swapping out, it won't
> > > be able to stop page moving due to:
> > > * memory compaction in alloc_pages()
> > > * making huge pages
> > > * numa balance
> > > * memory compaction in CMA
> > 
> > Enabling those things is a major reason to have SVA device in the
> > first place, providing a SW API to turn it all off seems like the
> > wrong direction.
> 
> I wouldn't say this is a major reason to have SVA. If we read the
> history of SVA and papers, people would think easy programming due
> to data struct sharing between cpu and device, and process space
> isolation in device would be the major reasons for SVA. SVA also
> declares it supports zero-copy while zero-copy doesn't necessarily
> depend on SVA.

Once you have to explicitly make system calls to declare memory under
IO, you loose all of that.

Since you've asked the app to be explicit about the DMAs it intends to
do, there is not really much reason to use SVA for those DMAs anymore.

Jason
