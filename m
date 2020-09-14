Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E77268BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgINNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgINNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:03:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882DC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:03:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so16660753qkn.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FgP3rku0+UL9c5/hMEsqEuqUjGamvOGAgXg5Y89xHUc=;
        b=Ps4vQp4CDC3IUR0LmFIIvzZzCuBQcXhUd3Fvx5aXJEOMsZLSc/PedBrDb5UB7FLpuD
         YxotgyJ8L2MP99o48FgkD3qEgef21tnjHSq9Tr/1HxPYLFgeW4MsCX6C6zntUrlW7UQu
         YhgEpUAT6wGALZA71YzTG8Dnc81enhcnP0i9FpJo05W6dCpXWWoGcIH9sr0rbyDG84tX
         WqthP4YMXIYHrAcMv4JGiaKqO6w5aVCzzwe67jQ8QWv45/qS6AzdqXCcenfkCA14Kt9d
         zKZjf/6GHDuirLxItqBjEROvtBI1JfnBivyzfmk6JJ91IKnolcbQPNdE4GmfVqSeiPXB
         bWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgP3rku0+UL9c5/hMEsqEuqUjGamvOGAgXg5Y89xHUc=;
        b=TVmYmRHNLUJ84MLbsrQuLHiopEuafh/2Qfy7ZLi8MpfPE+X4Q/uZCDxptJDITflmms
         xmX7YIAOCdGAE8mYP0SOSbU7NzoDMExS9eIe4HD3ZqcdBdSmyjGupGAR9ImhpFze/Prv
         D0IWGiDP1tpAAHNC1xvIviiM7u3m3ydIO1Qesk9EDC/hi8WweWWejQ0CVEP+i96rCSxZ
         a5XmBP5WVsySiyp59ZG8JMlI6jGmIiDDi1BNvKaGXsuhucuQzuHJpZYCUjI/W4i3hb/3
         gigcGJJHKVYwmyuS/UHCIbKCI1p8j4GbG9VMklBB5d9nuMpVNpAtD9FE7cY69xrzVXmx
         vwUw==
X-Gm-Message-State: AOAM533doYb79RjaMhPCi+6AnWR3vjmWKDbvwkD6+yC22lod9Kne7Cwm
        Glvht4yDKsVzAKKmhKPIhP7S7Q==
X-Google-Smtp-Source: ABdhPJwYRqqpaRKSxCSt+RD5g5q3F8+NzuDZnPh8D8Hdl2yd4r2CasN+Zk7bCLAp6sKG0Y+V/8+bWw==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr12881154qke.372.1600088627109;
        Mon, 14 Sep 2020 06:03:47 -0700 (PDT)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:7d5:712f:391f:a185:3859])
        by smtp.gmail.com with ESMTPSA id c70sm931788qkg.4.2020.09.14.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:03:45 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 799DBFC007E; Mon, 14 Sep 2020 09:03:44 -0400 (EDT)
Date:   Mon, 14 Sep 2020 09:03:44 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: omfs: use kmemdup() rather than kmalloc+memcpy
Message-ID: <20200914130344.GA4515@bobcopeland.com>
References: <20200824211755.597245-1-alex.dewar90@gmail.com>
 <5efaa7be-1890-0169-d133-8dd40b238d6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efaa7be-1890-0169-d133-8dd40b238d6d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:04:15PM +0100, Alex Dewar wrote:
> On 24/08/2020 22:17, Alex Dewar wrote:
> > Issue identified with Coccinelle.
> Gentle ping?
> > 
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Acked-by: Bob Copeland <me@bobcopeland.com>

However, I don't have a git tree for OMFS so you'll need to send it
through vfs tree or so.

-- 
Bob Copeland %% https://bobcopeland.com/
