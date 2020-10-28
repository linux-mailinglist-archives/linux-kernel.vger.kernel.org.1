Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7284629DA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbgJ1XM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgJ1XLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:11:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D72C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:11:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i26so769735pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9KLgU2ii04BMgmi9GJzMZxGva6u6t/mvJPjkoxUhr74=;
        b=SpwfTtMc6fpZxAapRbEYqZhJ275joqIjQxSqHFrK4Yekqe+Gh2zz6qdapj9A1/J6xI
         foQfDDB0AVcez/2sNAO+Vh7ZW8qJCyoy9o3KnSyOfL1YPG6414L3YyOl4Njh8oZ8j6cN
         k/wpFmINd26rcv9udGDVOqncEZKOYKWgN538CHGj59P1jCeuXhh4uJhVDNt/VOl8thrA
         6gQgeAs5qDBHuJGVR26BnE+b3PWJaR95jKJGVTFY9pcLxUn1YiPeNXt/l0VYXsG6V6rf
         jRAzk4WcwmAviBfA8VMWZx8MtjV20TQ/6IZFDqchgrG1GICr9zCbtwiBXkLs+Jmdbxyv
         Ab1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9KLgU2ii04BMgmi9GJzMZxGva6u6t/mvJPjkoxUhr74=;
        b=muM6CeCEEqefetrxmwQrvvFd7v5HqLhYi6i4xy+DFAUcbu985FS8ybR1harv1iHTkp
         bcU+Sajk6T8u76JB/I6HFsMGP5vvUSP5Ed7dVBbQNWjM88dUG6N8oCsNMnthCq/m+wZp
         b3Yvjn/KgJQlGBHc60aeadhEABo+rd8XQTAMO5HcP2lySN507FBhiDRk+qDyuXuDkRUp
         FsrXg2lAkuNFXNlZlRxiHzAX9IEJ5hDNMcP8biAjpAnQ62hvPvjeetltxNVwxu/t0uLV
         60ZiaOX5ONlfbr4QTDivxgXJ/J7yVrmUmAT2mzein4oSc4AN3DQvrTl/wegaRvCe/JFl
         gCSg==
X-Gm-Message-State: AOAM531Cxx4RApzeTNhIG2Vh+eEamI0WPD9x1fNFeyEV9Lupie+GzLnN
        CZIM/dnCm6o9+DdcoJyCyTNf82jrw8nCfQ==
X-Google-Smtp-Source: ABdhPJy00goGFzfZHxvXhNS7gg6ez4rHGE2d6wvUjsKkNkmVUyn+UFMehJccnUwS8rJlbF8q7y3A5Q==
X-Received: by 2002:a63:1649:: with SMTP id 9mr1419124pgw.91.1603926711033;
        Wed, 28 Oct 2020 16:11:51 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au. [124.171.72.187])
        by smtp.gmail.com with UTF8SMTPSA id q5sm449440pjj.26.2020.10.28.16.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:11:50 -0700 (PDT)
Subject: Re: [PATCH kernel v2 1/2] dma: Allow mixing bypass and normal IOMMU
 operation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201027101841.96056-1-aik@ozlabs.ru>
 <20201027101841.96056-2-aik@ozlabs.ru> <20201027164858.GA30651@lst.de>
 <28147035-500d-f3cd-f283-257066343697@ozlabs.ru>
 <20201028172106.GA10015@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f4420b19-05cd-5817-9ba4-8f6f166a7e5c@ozlabs.ru>
Date:   Thu, 29 Oct 2020 10:11:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201028172106.GA10015@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2020 04:21, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 05:55:23PM +1100, Alexey Kardashevskiy wrote:
>>
>> It is passing an address of the end of the mapped area so passing a page
>> struct means passing page and offset which is an extra parameter and we do
>> not want to do anything with the page in those hooks anyway so I'd keep it
>> as is.
>>
>>
>>> and
>>>      maybe even hide the dma_map_direct inside it.
>>
>> Call dma_map_direct() from arch_dma_map_page_direct() if
>> arch_dma_map_page_direct() is defined? Seems suboptimal as it is going to
>> be bypass=true in most cases and we save one call by avoiding calling
>> arch_dma_map_page_direct(). Unless I missed something?
> 
> C does not even evaluate the right hand side of a || expression if the
> left hand evaluates to true.

Right, this is what I meant. dma_map_direct() is inline and fast so I 
did not want it inside the arch hook which is not inline.


-- 
Alexey
