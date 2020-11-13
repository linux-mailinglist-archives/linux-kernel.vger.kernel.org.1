Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4262B274D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgKMVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgKMVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:44:21 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADACC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:44:20 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so8708668pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBsaCjpf4fscNVFcDQCUrtRqqAxNkOKkyOP/x0Yudbc=;
        b=Gr4rBDYmhAURHlZdqniWVzqgh0UPjNiLW5C7SZjZo6+m3uzG+myWFHJpukpFg1hZGC
         DBkt8YetnAu+1tlaW8pONEoyptygCmDHHeVcTmvuSXrG1x4GM5XEn1+KXtNDO97Erp7v
         lEAfkw91U9TIceWHaRlW3v34f+6VCYbZiv6f7N/5xa7ZSGfVidyR0Pe2zOcxkIUOxkGp
         yi6Xs18gY6D9XAcMEUKilBgjkfxljkAHUTDrFsRIzMlqWalwJin6OgKQbED41DTnQ1xX
         zjlLu6y2PtnP4QWpF9XtCmNYTJE2xHINHxT8ilUlMg+J8JPUQaWxf9EFpMRHBKz9HmUz
         gEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBsaCjpf4fscNVFcDQCUrtRqqAxNkOKkyOP/x0Yudbc=;
        b=GGwqOPejAL4JgA2F4gN6ZRLSDkA+yEaZzwP/qb4/DBhBET6T6Yrl89ilGZ2+Vcq54K
         7hW/7a/ECFv54oH1smPKZDrSbe42AOrTSED+ikhO5wLlifZkv/CQPNsc5CI6xU7NHV9f
         AcJ7683kJBP7iihQ9oHPotT/LLKqnyOHB0hwBrfZwZDWuRJ50/8Ft2bvA8KBIevdBkhQ
         RLdNwwkestQINDVRBZWTzyLTDDeWh+IWRXmtZwcBF218lojrmFDKEb2lrcWVH6Bvthjc
         waIsjrdxtIzyZqStCrUm2V9PKDPgW1e292wp5AADeuoXaPjB+ueGdjqO4Izk6QdEgexx
         Mo9w==
X-Gm-Message-State: AOAM533czH+7WOYgajWnPBBBi/BZEuKacPO9/YTaey+RDrocNUDo2UOp
        yOafAXCUUKTNjYMRxd/Ssm8ue6lFsLBVPA==
X-Google-Smtp-Source: ABdhPJzCyynwsxcziuAqEG55g3gd7FIeqfF7PAuUNlkzvPcZ1Wg+ErlM+sNy+2DMiwCJ9g1Hh4W94Q==
X-Received: by 2002:aa7:959d:0:b029:18b:5b6a:2553 with SMTP id z29-20020aa7959d0000b029018b5b6a2553mr3649463pfj.47.1605303860256;
        Fri, 13 Nov 2020 13:44:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i29sm9621029pgb.10.2020.11.13.13.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:44:19 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Sagi Grimberg <sagi@grimberg.me>,
        Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
Date:   Fri, 13 Nov 2020 14:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 2:36 PM, Sagi Grimberg wrote:
> 
>>> But if you think this has a better home, I'm assuming that the guys
>>> will be open to that.
>>
>> Also see the reply from Ming. It's a balancing act - don't want to add
>> extra overhead to the core, but also don't want to carry an extra
>> scheduler if the main change is really just variable dispatch batching.
>> And since we already have a notion of that, seems worthwhile to explore
>> that venue.
> 
> I agree,
> 
> The main difference is that this balancing is not driven from device
> resource pressure, but rather from an assumption of device specific
> optimization (and also with a specific optimization target), hence a
> scheduler a user would need to opt-in seemed like a good compromise.
> 
> But maybe Ming has some good ideas on a different way to add it..

So here's another case - virtualized nvme. The commit overhead is
suitably large there that performance suffers quite a bit, similarly to
your remote storage case. If we had suitable logic in the core, then we
could easily propagate this knowledge when setting up the queue. Then it
could happen automatically, without needing a configuration to switch to
a specific scheduler.

-- 
Jens Axboe

