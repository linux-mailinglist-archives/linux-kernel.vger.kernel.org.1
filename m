Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277B51B2B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgDUPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgDUPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:51:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D3C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:51:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c16so6944548ilr.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucc26Bj81AjJz1d/vC9eI8ex7RUUxpik4V5yYcotuFw=;
        b=bLiEezq1puvn33tEiH/uMc12FH9WXxAqpJV1nlIBvxjFLwkxlqnpdwngQnbulmdmFa
         H+WCcRWCgW6qrwC5aFEUV5aWShHQyPPFW48v2J9kYUjS0Bw4FrVKdhioL8h3YttZuY18
         4QOXHZhiVvqmBd3winT4yFkc8yv8G7I6NDzp3xXpDEx9wks7J+oc/5RpWGkEQfOFE1kU
         Zj05wGIBGNXYOh3/F2cZ4RCa4v57HzJWm/wjGXEtUtuGqY8s3pYlz1YJbnOq0TLpGyhi
         bkbTAFTvRCzqurxhXOAVn/c5lpEGBF9jUlTs1R/gQ4neVgTKbMw+NDp+E4ExgXF4tnES
         qugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucc26Bj81AjJz1d/vC9eI8ex7RUUxpik4V5yYcotuFw=;
        b=WlOXE1M6RGikda8ZJXEzvw0yUmule0XGz3RpO1aRYMA6KyYUJ16lTBfUWivWjTYZsB
         q2YmeQhLAd/DNbvNCGOSmH63SEX2e0t2+12AHzhbEE2yWjcs4NEFt661g+u42JVWjO7H
         q6Vy/E8fEI0zNqJf91LxplgPwZEiYzDMRJ0OpwPNvB+BBA3mpzYFEJ+Gq2L/mipzlkFL
         yYP11BVzcKGTe063a0l1oqRubw4Lz/Sn21iiQom6yofUpBRwrGCxk3xtvahx2AW5hLEl
         e8xXyHPdIVYry8YCP+/lwkSRwzFEwzK9oBdE19ux4E8Z3u+lsndCB0lLNbuocbAChRuG
         znig==
X-Gm-Message-State: AGi0PuYU6/uoqMTPTLsRyiVCDitsSucq1B+d8l0aeuDglCB+59iC4Yni
        oap7Uqw/LQEPGTTS8mxImBKaLDTbYmUxag==
X-Google-Smtp-Source: APiQypIJxzyhZTQeTb7npJKsKQymReUDPbDW+nECgF2KFNC/f4kH7ZfMv6U/8+cvtAzS9yY5kciqqw==
X-Received: by 2002:a92:48d0:: with SMTP id j77mr20967506ilg.274.1587484291866;
        Tue, 21 Apr 2020 08:51:31 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d23sm831038ioc.48.2020.04.21.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 08:51:31 -0700 (PDT)
Subject: Re: [RESEND]block: remove unused header
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6AA21C22F0A5DA478922644AD2EC308C73C54781@SHSMSX101.ccr.corp.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <284a10cf-3829-d891-3193-c468fd0e8fe6@kernel.dk>
Date:   Tue, 21 Apr 2020 09:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C73C54781@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 5:48 AM, Ma, Jianpeng wrote:
> Dax related code already removed from this file.

Applied, thanks.

-- 
Jens Axboe

