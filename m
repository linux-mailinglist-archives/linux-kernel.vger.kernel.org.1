Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4026C905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgIPTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgIPRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11386C0698C9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:24:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so2588539wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzlEMFrfJPNBczBcEKPI0Pi7LHr93uDvegVnUkyAZww=;
        b=BW86NJLHAUE4C0+h1pek8uu7ahlAiaZycOIfyDhh9dQEfVJTvulYHFbzKJLhCg46Vy
         7ZJ7gZ9Or2puEMbn5aqUH9L5jd225tFSR6HNPOaH5+XS88oVC8CgZiI1Nr/bZMnJ2HFj
         Vlf6ixLKrzC1K2oYsLn9S3hbjcLRFWXaA6cPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzlEMFrfJPNBczBcEKPI0Pi7LHr93uDvegVnUkyAZww=;
        b=HQ1byKU7HQCvGEEaTJDN3/TkSmHQ04j62yORJmbYKHeYidXiNVhgDJu0Ur2vcIDjv9
         DWNk8iYs+n5/U/8sVlp/xGsq4LYn8xbSriqms7uGATq5VDZLUrnZpFRozpTkADkA0ila
         pCF62QBLljW844CIifusjEe+9x7XIxTkqoi+Bxi+eHP+BX4gR9qvPW40C3pFqY6IzmC2
         FKO0BZitnpY6pbO1Lk+4RzXovlnIPlL9BFDjCLWlH16fPhfyjPD0HlH3LtLwYPTJn6d+
         L1wPsUt4XgrKa3s/12EOzZkpbv61km3OWiHoVQFeMY7ThWBgK6Kif3n6s/xhfA9fh9Yc
         UemA==
X-Gm-Message-State: AOAM531u2MwgsWwEqH67C8DKUFGIW70ng3qAF2YlWcy6QwuJAarIwGUQ
        NBGdf6Vq4MD3CLo9nxXJj9FkjQ==
X-Google-Smtp-Source: ABdhPJxDS25ARMjRBo/UsC9dsAEMPUX6NsZNUAwjZFJ4gujR+XMjOxBBLtzjuVcFwtx2qVH2IqmnMA==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr4372215wmh.71.1600255493476;
        Wed, 16 Sep 2020 04:24:53 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id y6sm32793151wrn.41.2020.09.16.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:24:53 -0700 (PDT)
Date:   Wed, 16 Sep 2020 12:24:52 +0100
From:   Chris Down <chris@chrisdown.name>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5] mm/vmscan: add a fatal signals check in drop_slab_node
Message-ID: <20200916112452.GA85476@chrisdown.name>
References: <20200916025359.70203-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200916025359.70203-1-zangchunxin@bytedance.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zangchunxin@bytedance.com writes:
>From: Chunxin Zang <zangchunxin@bytedance.com>
>
>On our server, there are about 10k memcg in one machine. They use memory
>very frequently. We have observed that drop_caches can take a
>considerable amount of time, and can't stop it.
>
>There are two reasons:
>1. There is somebody constantly generating more objects to reclaim
>  on drop_caches, result the 'freed' always bigger than 10.
>2. The process has no chance to process signals.
>
>We can get the following info through 'ps':
>
> root:~# ps -aux | grep drop
> root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
> root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
>
>Add a bail out on the fatal signals in the main loop so that the
>operation can be terminated by userspace.
>
>Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Chris Down <chris@chrisdown.name>
