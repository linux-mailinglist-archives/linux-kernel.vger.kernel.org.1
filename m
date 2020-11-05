Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FB2A7FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgKENku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKENkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:40:49 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D42AC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 05:40:47 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n12so1829994ioc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qEKdqAfGTmW30k1XWvYZCcm59Epg8FtdNjTuIk383BA=;
        b=fY5vNxHYfx5xOgFnkvUSi0+5A6vW8Bd1RFy1QW/Ghb7nSkAtLtdLCAIxkfnKHvcvE1
         agnoHGPip4x3Pi2LSt7C4mOmv0YRV9FQmoVCmkJkrQyzwYuYQnZ6IQ9NghyMAhzQ8vO0
         OBd3gxyjjG6qwDQq2e37RWCqfjbvxhniinOPJc0u8Y91LWP2IQNsfM9fR9/yrDbDqUrf
         t3/eeou0/gn9ocYw6PKxPWCUp5L6WXKbtasZGSQ36sQv7XvYeK7n1hxRKL+kbHddhP19
         mXtgeliR1jjryWkXM9+WubA9IdbPekwP6BR77zrXE7zdieWnX2639OHLeHsa3uu1cEj0
         U3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qEKdqAfGTmW30k1XWvYZCcm59Epg8FtdNjTuIk383BA=;
        b=VlhMR+J454Br7AvTIwwBZJwm559F1ig7XZiboHmGTe8I2JocDMi8jempuPVeUTvZWT
         ANIERrAlzUiABhmgbILbFfwT2nJkHdBEyAXoJaLBwtC8Gh1gfm+j+i2qNlAHHr+g9PbS
         mggEiQs1TPIdLplKcLK6jQSOq0hVHj52Tkqc7plwOE8bproDHD79CtlPVVOQ11RjpxNp
         gfVPc1MqCBFpYvGI/2NWEdn9JCOf9F0z3uMkEOTUSUDUGgraivfnhD2eGgoeI7CE47Vx
         NTEEHmLNNIVMG+PKOhgMIW3NPI42J0/jxucAx0naDrVGfd0pXx/yGVyIMdc7VDwZaFES
         CZ6A==
X-Gm-Message-State: AOAM530uK8Ij9bRdgzr3ozt5BpG5hZuy0uEQt6wuV0pKY8SiORu9DKD1
        Ps5J3HxsE+J7tDOfVpFAfjhZJD2VcGAbXzOn
X-Google-Smtp-Source: ABdhPJzR4+r3/BfoQYUUl4h05nAE3j1Dernt7E5EJQ+nNf3nJBBvOBBWzH3fLJYXKmylvkONdGH/Ag==
X-Received: by 2002:a02:708:: with SMTP id f8mr1989941jaf.143.1604583646586;
        Thu, 05 Nov 2020 05:40:46 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y17sm1200674ilj.7.2020.11.05.05.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:40:45 -0800 (PST)
Subject: Re: [PATCH net-next 0/6] net: ipa: tell GSI the IPA version
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201102175400.6282-1-elder@linaro.org>
 <20201104163138.6c5d534d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <9805bd9f-aafb-d148-ad67-09e74bac127f@linaro.org>
Date:   Thu, 5 Nov 2020 07:40:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104163138.6c5d534d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 6:31 PM, Jakub Kicinski wrote:
>> Note:  the last patch in this series depends on this patch posted
>> for review earlier today:
>>    https://lore.kernel.org/netdev/20201102173435.5987-1-elder@linaro.org
> But in the future please don't post dependent changes like this. The
> build bots cannot figure this out and give up on checking your series.

Sorry about that, I didn't realize this would be a problem.
I will avoid this in the future.

I will be sending a steady stream of patches in the coming
weeks.  If you have any other comments or suggestions that
would make that easier to manage, please let me know.

Thank you.

					-Alex
