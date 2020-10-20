Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09424293CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407313AbgJTNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407136AbgJTNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:08:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so2100048ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMjv69Q8ygJTDYUmtmqR5brlN9bQw64VIyI24z18jzA=;
        b=cqQOg5TlBhSHYK8ucEO8iGioZ3ug3JvxYTXOjTVruEHdm9SvDU5nrkAwp9nMQNNSiO
         EcwqyjcskunxgNXegcl9ilsGpyw0hpdo0FDdRoKIi+U1Q92X+dvrugsHSrDUQuM5O8NE
         db30d7d6VKywjCwMbZQyAqPxAxPxjGSAHsAN9PBY6JVofOH281yX0TUdUceYJ5s4nyf0
         G44npvNgm5E817+gLEokiS/RfoNI3E4xmOF9UEZooKfdhCoCBoT/RTPjSfK63YG4hpwu
         ZuopdYqg7vHZ+TmaHzpOqEKOq8/UT/t3M2wt1Zo2m0E9mEx0IcEPq/eBQZ2hwPrhdnJT
         +cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMjv69Q8ygJTDYUmtmqR5brlN9bQw64VIyI24z18jzA=;
        b=At1p7J1PC/DathlCx03aYn87uUgMsL2VsIUMy7Gjlmr3dBb8cJWhkGVQAuamScwhHO
         e7iaLQmm6qpKHK+L+eiRi+4zdVySUI9EmyZ+vzP5rdo9qVCH53KVZtTgJ8PIr0fw2sL3
         AjDeW/39VbtKHZZIHdlEZ9r1mO7tMQvcUZQ5wHO/rWnel94bbOPfzv8nRP0NrsTGF/Rl
         M1SvgI3qCwBlkHtXPNHmacACcmktcJg7N8k55lF9GXOn+GhaRrqOeUuxlWCoMS364xNk
         PRGYK59EMBDM+i4g9+8ZIlNYj3igusRFGZ3eZtwnk7nKP31+uOBxPYs9Gj8UsZSCbfVG
         OmkQ==
X-Gm-Message-State: AOAM532YbalQBk/WCY+8Y6kBqi/oGo391t6rBc9TlomTU5qBKky9bku7
        9ESxGTYsUlyNrUX1eUhMcDs9g6ceIGcflg==
X-Google-Smtp-Source: ABdhPJzm9BWlfeceU/Pa8coannvqHVejEwNaW+D/pLKRy4IBr4U+OwVIbd3EIC8zCU9He1KiPKZ4fw==
X-Received: by 2002:a92:9119:: with SMTP id t25mr1811593ild.90.1603199331115;
        Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o19sm1767373ilt.24.2020.10.20.06.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 06:08:50 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove the calling of local_memory_node()
To:     Xianting Tian <tian.xianting@h3c.com>,
        raghavendra.kt@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com
References: <20201019082047.31113-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1db7f790-b4df-435b-25b1-d99222ed7c50@kernel.dk>
Date:   Tue, 20 Oct 2020 07:08:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019082047.31113-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 2:20 AM, Xianting Tian wrote:
> We don't need to check whether the node is memoryless numa node before
> calling allocator interface. SLUB(and SLAB,SLOB) relies on the page
> allocator to pick a node. Page allocator should deal with memoryless
> nodes just fine. It has zonelists constructed for each possible nodes.
> And it will automatically fall back into a node which is closest to the
> requested node. As long as __GFP_THISNODE is not enforced of course.
> 
> The code comments of kmem_cache_alloc_node() of SLAB also showed this:
>  * Fallback to other node is possible if __GFP_THISNODE is not set.
> 
> blk-mq code doesn't set __GFP_THISNODE, so we can remove the calling
> of local_memory_node().

Applied, thanks.

-- 
Jens Axboe

