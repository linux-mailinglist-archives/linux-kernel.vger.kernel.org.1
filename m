Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91528D446
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgJMTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgJMTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:12:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE02DC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:12:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so267282pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CIUw9wLfc3OZIwg0Uswy6MSqpPUNtbGdZo6diLuevVc=;
        b=EXeSCJlDVG9TCpBADW8wsFfEAvnVjHepPWPVcg3NIrEuwsKLf6vzdNl0dlyN2C7xaY
         nwbyhAPN+29WdAmM9JdTa1oU6pgF3JqYy2eJum0h2c4IB35tFsqHPgNHBNMuPRCV+gLD
         LLdK6bQ3ICjAI1KuWlCNh0gRbS5NU+o411j8Y8jK2alh3aFULadINjJMQi39f044+gPs
         JNe0orhgaveZJTmSZNFKao3PR6SXN0KpNTbeHsMmiIysPxOqgAVNIELrcTkPIvAy/6iD
         dAbmOWP1cuabe7IzPib/+ZVI5Ct+R0ApbBP098NnT8YvgX4bhsatwCwJvqNnbMNRtpPo
         SwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIUw9wLfc3OZIwg0Uswy6MSqpPUNtbGdZo6diLuevVc=;
        b=efjqnY8rXNfyMVlBXSGQgrIEid0Hk0iSF1wmKYEiF8F22OARfsCHzxO5xEKI1lctg/
         J/JtgVg87UDxgLwoJiFj0QUZIzYNHs+36n7EwCPrqJKizmFIbwEptIwjxtL+nnmy1zNZ
         hJPIlqQxWVsfOD4mND/sDl+EExaS31wl15dSt746olIJPpyzeuJ0x7OeQLgGQyaEc27c
         A6jM88k2NE3Sw5RyT2ins3EPkNe148a7kJRNJgcCTpEsbgs7cbPeFmaeZxNdtqb424mi
         68lsWppMGfY11I+uy50LA0fDRtqY/9tEKfIuatJVI9GC8DfM9dk6yUPHJTiWIQMg9GH0
         hmdQ==
X-Gm-Message-State: AOAM532HdpwG+ItqTd24jsVWf3awmHCNX5On/L2GSqGKU+1djGGYq8Su
        1vRbDxgCZcpNSDhiY3kQiRHNRtcscxxWnCII
X-Google-Smtp-Source: ABdhPJyhAEdx3kXb4x/uh73WpkkE0fKigWWIsTZPI9d101pzSUD3B7hTrUhg/uUS9AUir4IhYkrKHQ==
X-Received: by 2002:a65:400c:: with SMTP id f12mr831973pgp.355.1602616368957;
        Tue, 13 Oct 2020 12:12:48 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d9sm661579pjx.47.2020.10.13.12.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:12:48 -0700 (PDT)
Subject: Re: [PATCH v2 06/24] blk-mq: docs: add kernel-doc description for a
 new struct member
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <197771e2-4344-91aa-1ff8-3a826f7f7235@kernel.dk>
Date:   Tue, 13 Oct 2020 13:12:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 6:14 AM, Mauro Carvalho Chehab wrote:
> As reported by kernel-doc:
> 	./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'
> 
> There is now a new member for struct blk_mq_tag_set. Add a
> description for it, based on the commit that introduced it.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

