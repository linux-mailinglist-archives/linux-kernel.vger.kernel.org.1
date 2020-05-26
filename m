Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A11C656D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEFBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 21:18:26 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33193 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEFBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:18:25 -0400
Received: by mail-pg1-f178.google.com with SMTP id a4so370096pgc.0;
        Tue, 05 May 2020 18:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TB95JfcrXLdUl9kBee+SDhoQM4+heqr0oLNCpeox9Sg=;
        b=nduRsLfJbrEF+Reluzo4EvQHLwhqgVvu7CUjEly6Xo5F/hsJi8suzNmv/RLR7uRDw8
         PDSjwJgde2M9U28Nn8YFPrTg5RErOguV9X6R9Mpjl18MxCHtWMdsqmGAfZzDEehwsQqc
         9BmGHXlFVGPfjST9rXd9f4mMfNzwqcGS3r1MrgDp3LN5LY+hRc55DcZ3ME2x9jSCTGdJ
         pXwwGBFwfXhTeZ3cTPat235Q534tcrfAmEp4wfWl9Ce3wi2mxvgRWBgfCPjY66eRqXEB
         uX3lhaZQnoAuz/eGqzYN1Oa6sRHQTAMj+Mb9PZ8gTytzOJMyr2d6+TALm/v2ioZ2OMzC
         pX9g==
X-Gm-Message-State: AGi0PuYNZyjmVOIiGF2KNwdlS1Ou45IiLg9/tYu8yfKz6kEtCX0kwUE7
        TgkQKA/xhaTAguWlIi2RIuY+J6vv+iE=
X-Google-Smtp-Source: APiQypKcMdiVpEdcd6k1tCehCJfKSR47ZJ4R9cF4/38cu7GQ+m8U6H5RGIjrbLwS+uyA3xzuaPZenw==
X-Received: by 2002:a63:5320:: with SMTP id h32mr5236568pgb.28.1588727904320;
        Tue, 05 May 2020 18:18:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b435:750c:4181:403d? ([2601:647:4000:d7:b435:750c:4181:403d])
        by smtp.gmail.com with ESMTPSA id t14sm295503pgr.61.2020.05.05.18.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 18:18:23 -0700 (PDT)
Subject: Re: [RFC v1 0/6] block: add error handling for *add_disk*()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200429074844.6241-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <896ca55e-0daa-fb62-f9cb-0714389936a5@acm.org>
Date:   Tue, 5 May 2020 18:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-29 00:48, Luis Chamberlain wrote:
> While working on some blktrace races I noticed that we don't do
> error handling on *add_disk*() and friends. This is my initial
> work on that.
> 
> This is based on linux-next tag next-20200428, you can also get this
> on my branch 20200428-block-fixes [0].
> 
> Let me know what you think.
Hi Luis,

Thank you for having done this work. Since triggering error paths can be
challenging, how about adding fault injection capabilities that make it
possible to trigger all modified error paths and how about adding
blktests that trigger these paths? That is the strategy that I followed
myself recently to fix an error path in blk_mq_realloc_hw_ctxs().

Thanks,

Bart.
