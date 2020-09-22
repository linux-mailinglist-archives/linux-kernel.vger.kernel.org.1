Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF68274538
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIVP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIVP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:27:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CACC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:27:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x14so17520388wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=daWCo1RFCRJHeJIJbYudV3s6gpJF4K5dmJezag8Qxqc=;
        b=PQ0Av58MFvLr8hCz6Yr/XxwJJ7Rgqi5vRs6SigDx5kZJM55s9csvPupwqeaTQWbb5z
         TRGOieLlELVhujXUHDOon7IzLBsGs3ni5pwKbtN4mB5zBPYampC9UdWB+vt9L+9B+kA3
         R5vvd2tolQMyPqDvZ3F8UN102erJ643KTs9FuimjTL9q7XVs6EIOZuAzaz6Nhm5enw7s
         9jMD1N9hAov6lVgtCVQx4WoWiHmWIAtsOIkf8+5Z6ycPjYAZHMv10udgKsbxF+JwHDxd
         msuvSW9jl3394JT8quDkK7Mx9/08S7nGKzMTHlj5eIue6YMna08FEjFemZ4KefCcu3Z3
         4Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=daWCo1RFCRJHeJIJbYudV3s6gpJF4K5dmJezag8Qxqc=;
        b=q1Ok6kBhl3PGKx0IroYK/j8AXK17ORClvGYpU1vu1B70GnODjd2GR1a753TM4ihdom
         tCK9rfRE25P2M8RdWvF9kUVoijL2Gmr9Ys/6Ihec2iFGJiVo24PUHXKX+erKKUnf2Xs5
         9F1azSU9KizMLWQu45wjljlNmEi7y0i5TpeU4OScHqNg7VFZiCiImskcxqoA/Gse2XsE
         xAyoWFTc2lhg+bDw5GWh0KqVwNCh2dmQMHEfC1u5h/9Ii9AldwynGo0gcMoE/m3yKK48
         tIWVZNSGAN/E0LDH9e6HX2CBu9dQqSOk8+0m68DrceXdAS+FMUPdQyB0pUehXC8Dnaqb
         RLNw==
X-Gm-Message-State: AOAM532Kf/wIC7QdP/WJA39Uiqj00FbX4L/G31ORXNw70q/oauw6ykc3
        BFUZWBTAwQtBp9TVJ0U3KrEWHndIU2psSg==
X-Google-Smtp-Source: ABdhPJxIF3wfnvfDxTeIOMmGPLFmN7hQs1E4eU47akeBeJuybRbsqN+aPPzVy9tpPtD1sT/n/nNwzQ==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr6017594wrq.83.1600788434458;
        Tue, 22 Sep 2020 08:27:14 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f? ([2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f])
        by smtp.googlemail.com with ESMTPSA id f6sm27290103wro.5.2020.09.22.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:27:13 -0700 (PDT)
Subject: Re: [PATCH -next] thermal: core: remove unnecessary mutex_init()
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200916062139.191233-1-miaoqinglang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c4c2d70-e901-74e4-185a-8f8bb105f03b@linaro.org>
Date:   Tue, 22 Sep 2020 17:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916062139.191233-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2020 08:21, Qinglang Miao wrote:
> The mutex poweroff_lock is initialized statically. It is
> unnecessary to initialize by mutex_init().
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
