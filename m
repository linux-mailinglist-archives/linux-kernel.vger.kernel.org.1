Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE02976CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbgJWSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465177AbgJWSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:20:56 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:20:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w17so2277226ilg.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tGH0KxAuUfEqEQSA/wPpDyz3C0EygW5ob8CmE2nbYgE=;
        b=K4uLjNuhKf2aARCJKa8vDLkfPOrqIxz2vtYLaCdcDz+Kfp840MDLnJznSeI1L0tPsz
         zbQ50bHxmwsrJsTbH1w/h0hFTq8nHwYnCp2p+O1p/LffHc34xImzz7vzQ2qFsfc5cCqH
         MPLmH4WY/J7X55OtA4wzI6T9s0mP8nNBVcp+e+7IWgCjDAf7BnVh+65RyvttF04BVAAH
         tOuP9GFT5UK2agbEXI0JJAgmzHF3aYtKj9C9NmHmp/7gKpuiA2e0MswY6vuaONg/tWMd
         ulrEj7MxrJPSRdur933rkqHgfs8eCjlZ0zQgxrSNAFu2MkYtCnGFXK32FU9jU62+H8v9
         E8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tGH0KxAuUfEqEQSA/wPpDyz3C0EygW5ob8CmE2nbYgE=;
        b=k1jyJWJQXhG1mLHJUgrtG+qSspWNlR0lnQc1Rw+IAtvRHX8T7RiTau6Wbc7N0FfnpB
         GRATZa9XdyzTIdfQ+yKSA/BpciwpANvMgGj5te2+W263cFQh8uuS630vBYQALjE/WfIX
         zC8wIZSpoFxQXH0knrjn8dZW7gGxEKAqUibDFfaziStED9/YOxqwtm6gufROtjDzCx/M
         GMVwU1SO92HwqbVKKN/AuU2vNMqTdV/gy9gj+ey1JZ88cNDCPS8fWk6Qb0gm3CahFvXw
         LKkTX6cQ+TUVNQD8/TZCPLCz7AEzH+2j8FlxfYqj8CqgJOnbB67jzN0Eqcc0CeMIHsUz
         ObVQ==
X-Gm-Message-State: AOAM53128T67g3gJsAbgHoPYgWZlp/3hR2uYJqmbdLT4d+2lI4KHHkoo
        6AhqZoreAqGyLa3PBqqZUGqn5BHSgt/sIg==
X-Google-Smtp-Source: ABdhPJzmGb8eQvwa+DPW7bgcyfKJWuCVzKCSBgN5Wb0Pk4tUujzEqRpN/81g5tA793qs8MP+CWmizw==
X-Received: by 2002:a92:5b46:: with SMTP id p67mr940694ilb.150.1603477254496;
        Fri, 23 Oct 2020 11:20:54 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w70sm1321978ila.87.2020.10.23.11.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 11:20:53 -0700 (PDT)
Subject: Re: [PATCH v3 07/56] block: blk-mq: fix a kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <da771fd9e5281537f39c6e927a199b681ff6204f.1603469755.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05f72376-6f3e-e216-ec15-8f5ce9d6e55c@kernel.dk>
Date:   Fri, 23 Oct 2020 12:20:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da771fd9e5281537f39c6e927a199b681ff6204f.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 10:32 AM, Mauro Carvalho Chehab wrote:
> Fix a typo:
> 	blk_mq_run_hw_queue -> blk_mq_run_hw_queues

Applied, thanks.

-- 
Jens Axboe

