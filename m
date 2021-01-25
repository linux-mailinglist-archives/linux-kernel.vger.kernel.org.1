Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C67302FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbhAYXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732822AbhAYXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:17:02 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07718C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 15:16:22 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id dj6so7062311qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pr+2CvKWSXQlcfbagHzf9FCH1wHTJk+YNUukuggEowE=;
        b=MPHMowxrctdI061dZikfB78k3kxJo7RV7pqbovUiUMGwLMx5mqeqVdd8BY75mLwS/U
         86aVmxSp3sp0NfyjYsQORyQ313BLeOnaF7UX0hMGJTbhPPTepqaouuIKpVXygcWMsM4Z
         QsVhyYYFAeq1iiJUujMomSxuVWJUU3HZcn+eO2EOg6EaKLJhuGCMEF+aAeneZN2CZgUP
         GS4DEay3LHU1iFNBJ3pB0b/I8zPMgmLsSITxXEQbpsLsYzU5KZ+Gf0hjrx+zl4KQ8TkW
         6K78hQCeKEqBkB2Cp6MuJB0zcVq6xgrOEn2t1t6hpBpHYXFzcBfAXmNCTo367HUJsMXA
         o23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pr+2CvKWSXQlcfbagHzf9FCH1wHTJk+YNUukuggEowE=;
        b=BsKg6TUldnr1afCMBw+6mMzjwTzyGlDDAhDUasAF4/8dA8GdcZvPydxmwdYpkPqceT
         cdkaYvnHjjZzAD0RVJPOl9VbksbbDkmbXT/z31vtttT1Z5TCkNs1pEcF5/lAqLQ19wGg
         +7xPkN6ZkU20LmFFes9U0nTs1YNxrOOL5JdcuAcpnLMqJTMfTT9mMlleal1MeTCamWtw
         ctUlOqJsE3Q2AZsiXvZUyEwmD21H+a/8hhoxk+tusdVkJMAMXzmOnXA0tHQIbCjJmGL3
         AYdrKzbVHlojQuQd/IKui9whGIqikp/zh84HEGCD0nmffwKI8FAG9tiUvmI3yQVC1Sc5
         ZnEg==
X-Gm-Message-State: AOAM5317CHF3zGQdNjWEgbMmUQBp8bP1T0MKlPiDQVPOyoha2hUNK3fc
        iMm7RkFhnHT0ferixD58sZdpgA==
X-Google-Smtp-Source: ABdhPJyGDZ0yKVIVXVyamsLCpnaLzzwlkeMkZZGH66Bz7h7jySB+qEi/pLU/0Wjd+fPB0jo3AzFjjA==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr3118919qvj.15.1611616581170;
        Mon, 25 Jan 2021 15:16:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id w9sm13608151qka.76.2021.01.25.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:16:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l4B5o-006pqt-00; Mon, 25 Jan 2021 19:16:20 -0400
Date:   Mon, 25 Jan 2021 19:16:19 -0400
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
Message-ID: <20210125231619.GY4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b655ade2534a65974a378bb68383ee@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> mlock, while certainly be able to prevent swapping out, it won't
> be able to stop page moving due to:
> * memory compaction in alloc_pages()
> * making huge pages
> * numa balance
> * memory compaction in CMA

Enabling those things is a major reason to have SVA device in the
first place, providing a SW API to turn it all off seems like the
wrong direction.

If the device doesn't want to use SVA then don't use it, use normal
DMA pinning like everything else.

Jason
