Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC62FEBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbhAUNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbhAUN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:29:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3EBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:28:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 6so2597073ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfhaMJYLoML7Y22BrUgxjVOkVeb6b5jyB/SWAlkSAAA=;
        b=yg/3qXQQpHmWkucO4vOujODLkimtJry2Obbr+4KNPw0Nwy4Sf+OfP/mZ+1cCBEy+6N
         BzNeheO/U1tGD9atl0QvMY9LfBJt03NcZdZ/yqxDhbbFl3p2tHhh7ctp9WrE7MI5qjUb
         SX/pY3ujErsukqI8Q8gRnXKU91SYLeB2NTxcTebKEAS237W9VS+MoQfq3/AAaG9ynXYZ
         n+1RSp/I8ZsclB4kc+5YOBdL8g+OXQGi6GnYgJAR3A3HDhOra7lH1V5pxUzl67LKNhjF
         YfKpH+zk+kU2L7dB/UywWiovzTS+CCwIMZvjVMraIQZWbssZUs1qOalnavgXMC9HcZuv
         RdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfhaMJYLoML7Y22BrUgxjVOkVeb6b5jyB/SWAlkSAAA=;
        b=Mpy3Kp8iI4U4K8YyFJqfmKhIFuaViVWzBmnlbnaPidk+fnGuW2D8YF5OfBVkOtol0l
         vmvrtFd5FUaAeOjJ/ROyQQy0kPVhI3BRZ+z06sQ8pfpKVTxfc76EGfMWryY2xYjtq9iO
         7r+DmnxSnh2bBh1t1Xssr6h8Cz5glXf4mGEME6NbYDgji0TKpjdJ1l8VdJCdErwVOgcA
         hRGSv3LdsWUyOc+zJMUDMx/qLp3zPi8ptsdkV2z6E+5DUaxFYgN2IHFkLmSNgpFOjbtK
         sA+0aJDcCw2V7JBp0Xyw9SC7V0CZxwBwpa+Y8YhqnwGzAOC8eDlB6+T+ihghIwp7UMW2
         I1cA==
X-Gm-Message-State: AOAM530D8HG3RU80IMIRN/BL5rNubBGYK/KD6d0Ds3ak3ktdnvtPAhqU
        EGEoMzlAb/h4Xgbnuear6zejcQ==
X-Google-Smtp-Source: ABdhPJxbJ0xuGRoqkN6QYXdsmNuAuLeEgWPW6hZWUBo9DdsCwq/nMg/5pMx7SNLoEdYBaQlkY/f4Qg==
X-Received: by 2002:a17:906:14ce:: with SMTP id y14mr8995342ejc.366.1611235727873;
        Thu, 21 Jan 2021 05:28:47 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id ce7sm2238183ejb.100.2021.01.21.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 05:28:46 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:28:46 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pan Bian <bianpan2016@163.com>, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
Message-ID: <20210121132846.4t4ijlogfi2pndpf@mpHalley.local>
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2021 05:47, Jens Axboe wrote:
>On 1/21/21 12:22 AM, Pan Bian wrote:
>> The allocated page is not released if error occurs in
>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
>> possible memory leak issue.
>
>Applied, thanks.
>
>General question for Matias - is lightnvm maintained anymore at all, or
>should we remove it? The project seems dead from my pov, and I don't
>even remember anyone even reviewing fixes from other people.
>

At least from the pblk side, I have no objections to removing it. I test
briefly that pblk runs on new releases, but there are no new features or
known bug fixes coming in.

Current deployments - to the best of my knowledge - are forks, which are
not being retrofitted upstream.

For completeness, I get a number of questions and request primarily from
the academia. These people will probably accuse the lack of LightNVM. I
understand though that this is not an argument to keep it.

Javier
