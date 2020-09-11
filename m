Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC42665BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIKRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIKRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:11:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F61C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:11:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b6so11801750iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PjaHcTfFjzbLCw68IPxqcyo+o8vTrqFIU4LrLdQ6i4E=;
        b=dtr8rc1TFTdhuQX1JX6cpdjp7g5dPXot326EizN5cMg4FGGWCBF3SujtkOjH2g9AU8
         VYooSex5NOHLaQmydJQvGP2ciPTbamrxy8e63sgmRcld3qe9CBysCiE7nkIJAWTrWWzD
         5cPZyRl9Z1CgPdcCfFgCs0umR5vPyTmNsQ7ARuMaYYHRDmzXZ+nTUkdmdtXeWtLd5x6F
         HZeOjxlKX3IAgX2SHg4n37ycDB7odU4BCn88ZKZVTPuVXZ6SEHZ4H2WFRV979A/Iqjwg
         f8eUotxsYrCJSPi9GeB9lCE1tcTM+Wow6b+ZMYQyvCDgYzOgnphaaEjqYJOXrGsWBVEa
         ZVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjaHcTfFjzbLCw68IPxqcyo+o8vTrqFIU4LrLdQ6i4E=;
        b=g2UUNmCH78jsYZAFdBLfwIDmCiiJ5yfolknCQsiKh0YYWkVuUE1o9VUEVRgnpBTHvz
         VhR4rXQmUwVQi83Co2fY3O3ziH6x8i7YxAG08ADXHYogtcMe/hslK5DD1w8fhxzgEWsw
         afvTmiCLajtpjwsZAPm0f9RDS/PVeUBBp9B6Oj/TGZM6UboiXBUY0mZv4UQNISEgs139
         BlDre1ZukVaKoDVYKGcsS426PrAlMxVFSZuVmxzV7Tpw9ZFRTaYJC7alBEvdHmxQEiN4
         UT+6XsvMevCIgJfLbW8tmtH6nT8EznRgYq00U77rESnsv3/gpQjoCfKyEsuhymQerclE
         NJHA==
X-Gm-Message-State: AOAM532iY29jNYNTBRumzYf2QIYBTX6ybQKzSVxTn6RwdKWwItDsuGUZ
        gLt+yWHm08XxHT3pR5vaoDTVQQ==
X-Google-Smtp-Source: ABdhPJya9L0YSSJEFVGJqL4QEUVLucOzZ18qlV1aPXjITgOpcqQR+btExvD6D25jNhpGgt8ZHCc9mw==
X-Received: by 2002:a02:8805:: with SMTP id r5mr2931118jai.52.1599844260029;
        Fri, 11 Sep 2020 10:11:00 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l14sm1509002ili.84.2020.09.11.10.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:10:59 -0700 (PDT)
Subject: Re: [PATCH block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20200911170746.GG4295@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
Date:   Fri, 11 Sep 2020 11:10:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911170746.GG4295@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 11:07 AM, Tejun Heo wrote:
> Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
> all hweight calculations round up and thus it may end up >= WEIGHT_ONE
> triggering divide-by-zero and other issues. Bound the value to avoid
> surprises.

Applied, thanks.

-- 
Jens Axboe

