Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C472B271B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKMVgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:36:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:36:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id i13so8141108pgm.9;
        Fri, 13 Nov 2020 13:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jm0UQg+mdszuwGSP+rSGtDVxYjXFAKTIf/hP3qOCt5s=;
        b=n1oMl71ey4nw84qSa7Ff98YjFNCQwsWUwhOZTLM63m8M73DuV2EvqBjkrydDnmyMVD
         h2CsDIdBsAlkIB7yjPsmzqUfkOcjJWtJWn4F6gsOGgmToST+LBkEjtl0lElUKmbB36qh
         Zatwxwpy1S9GDG/6Xssvg/5kUNvrC6JiMXT0fH0r6Wv9HMOyz+ESMrAWGJAG+5IB/5lS
         Bs8BJJlFldHyy9TxpOhsBM2oPLuyqp5bvnWbpeSATvvJhs6aF7CrcH7As4DQpEYy5hkq
         7lfC/+VytOqglMxFgeHIJpgQR0cFtCbgY1xu4PzNm1bLPvQfiQgDE4DR8AD+tnK2uxKV
         s0yQ==
X-Gm-Message-State: AOAM531l2XrxsMnnP/Vo1nfw3tAzYdrSaBdQ9h/EUo/5Mtl2OCoqzG0F
        pMfpN1f+b0vwpxNae5aUA64=
X-Google-Smtp-Source: ABdhPJyd2mq3CcH87fe4TuuOQePNIWrpkvt9hnJ7sQTx3mTF7rd18fMqO1nNSZ6lKYfYZ9gwY9KR7A==
X-Received: by 2002:a62:8cd6:0:b029:18b:ad92:503b with SMTP id m205-20020a628cd60000b029018bad92503bmr3670399pfd.77.1605303379651;
        Fri, 13 Nov 2020 13:36:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id a84sm10727208pfa.53.2020.11.13.13.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:36:18 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
Date:   Fri, 13 Nov 2020 13:36:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> But if you think this has a better home, I'm assuming that the guys
>> will be open to that.
> 
> Also see the reply from Ming. It's a balancing act - don't want to add
> extra overhead to the core, but also don't want to carry an extra
> scheduler if the main change is really just variable dispatch batching.
> And since we already have a notion of that, seems worthwhile to explore
> that venue.

I agree,

The main difference is that this balancing is not driven from device
resource pressure, but rather from an assumption of device specific
optimization (and also with a specific optimization target), hence a
scheduler a user would need to opt-in seemed like a good compromise.

But maybe Ming has some good ideas on a different way to add it..
