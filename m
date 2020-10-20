Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39355281E69
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJBWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJBWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:34:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E20C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:34:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k6so3239300ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SNgn8x1LkfWdEu78urJXFZ286D0Tvx+PX/T+D1sl55U=;
        b=IgmqgaillHjRBupgPlS/rSxa5A4fvBoOAPxR/09Buwozw/CJXgOMLlVlyu9fV5DRxD
         4FMLLkHTmDZbD7GeVCUjqksK9Cy57YLEJGijS1eUWscNukBe4lR9lkxStIYg80iLqFA9
         npnoG63y8xTf7DkRnuZ8Y/2Mgc0hiKPuuQTDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SNgn8x1LkfWdEu78urJXFZ286D0Tvx+PX/T+D1sl55U=;
        b=dbhO7FlRyB2R1BtWnmSfNh9WNtBE3YP1Ng8oFH4fxh4cXQJcNRJaF1P9c6vMTK39Uo
         PxvsKS4YExjpPzzAxPvmVJ77Wqc6DuNEXiCqkFPIyoKbBFghtP8m1Z+TrpSddlp2zj/F
         wFW8QtWxjQnviUSNuEP2OmpMPVDCqCjvVXfrATaf+SUhp07kj+SDYwQTU5FetLs7pUzu
         /lk3Ofp2ZY/nCj5CMAjEFvAQLBPgql5GxONo248nxIPfBM9tTLy5+At8ssYO1KqhVkzG
         mOnqU9dzF4vMkteWIyKqPNoGoT3bynvnVJWZWolQDG/ky+R7VQzn7HZzhELTgc8z9AEW
         27ww==
X-Gm-Message-State: AOAM530tl4oH0IweF4YTd0YPTxpgQdDE3qvVrZueWa/LLboifi64sp9o
        +qJM1EfUdk8/4vFDL45cLCHVGA==
X-Google-Smtp-Source: ABdhPJwukQiQGLC2KjOLkywVvqlG84GArIKDCLqoPt6By4T5ltR9BkuCqpbnNN815yJFlbhwBJUcGw==
X-Received: by 2002:a02:6cd0:: with SMTP id w199mr3937328jab.121.1601678081920;
        Fri, 02 Oct 2020 15:34:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t2sm1454893ilf.75.2020.10.02.15.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 15:34:41 -0700 (PDT)
To:     idryomov@gmail.com, dongsheng.yang@easystack.cn, axboe@kernel.dk
Cc:     ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: drivers/block/rbd.c: atomic_inc_return_safe() &
 atomic_dec_return_safe()
Message-ID: <ce2dbec5-00f8-831b-3138-cc4f3b8fdb51@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 16:34:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I came across these atomic_inc_return_safe() & atomic_dec_return_safe()
functions that hold the counters at safe values.

atomic_inc_return_safe()

If the counter is already 0 it will not be incremented.
If the counter is already at its maximum value returns
-EINVAL without updating it.

atomic_dec_return_safe()

Decrement the counter.  Return the resulting value, or -EINVAL

These two routines are static and only used in rbd.c.

Can these become part of atomic_t ops?

thanks,
-- Shuah
