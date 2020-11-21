Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E02BBCAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKUDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKUDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:31:13 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E8C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:31:11 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id o11so12023381ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S5oTLg78JQBWGWJuxlIEKrxaMSCrcYlXfYqW0izwtZE=;
        b=YJx/7mGxfgih7VuDfPueJ8xD24jp1nomS8yHDUKckgQf/tWK/KRmkGx0pTsu9X2J8q
         UeKzlHMX+52VjkblKl7liHneowPT2lCa1nBtQYllCKvBIisu6V+8naaSlhgFBTodnutt
         3sRjlEPW67hrsbm+Jq/bQkrFfBwDyaXBdJb0g145Th+wvZHaExoR+NSfYdZYOWQUoXTn
         xVWqkNBUXHNDKPzrLps4CpZ9DZxrPecjqF46Llx3OnwvG0s45FCYmn3PpA+eu64Y6rdk
         RRsZZiY8udTA8xlqKadcc/ZSSHES8PrGk/omJ6MdNzKOg+X/1CEk38xJZvnxIyebKqgy
         SzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S5oTLg78JQBWGWJuxlIEKrxaMSCrcYlXfYqW0izwtZE=;
        b=tBNvlVzGipHno/GitORDP9jRVJMEpwLwo4VpvidTcEJkFyypsKOsCfJIXKdl8taOCx
         4q+af3hWcSJwylJPrjZnjguun4qRvhp71FqtVJS2jh5SJCCzHGwNBTIlaIBDPylKw+hp
         sTAk316z3eU4UwMOV2xhJkihdppFaoRrhm03VqCp6AiYNaw/6wWD4T3i7WlA43hKJoxf
         AZYaE67zMlTYX55OkmLlsUzrF7fynOiowIgCBGKsjBUweArFYT8epVBv+Nq+d+wIQnUi
         Yx4a6srCVS6FqyeV78/3ZlEjHmd7+Qdn7Kb6fQPN0JrLz7a0pnGpdFdBKMAQQKx1eUCd
         CBNg==
X-Gm-Message-State: AOAM532VKidFLyuB6DPGSkvQymN3dYeqX7rb8A8KlifjHK4QU0HpmXvq
        g7D+xZ2mUDF4r6bLd6aiEW+ymX+vKlaOpA==
X-Google-Smtp-Source: ABdhPJwKGtfwDTa0z8IImutIH5wzsEwbU10FnSM3mAB+j17A+Du5XXzMvseGxio0O/YGmN/VdaWMAQ==
X-Received: by 2002:a6b:b50d:: with SMTP id e13mr26685621iof.168.1605929470694;
        Fri, 20 Nov 2020 19:31:10 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id u11sm2454107iol.51.2020.11.20.19.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 19:31:10 -0800 (PST)
Subject: Re: [PATCH net-next 4/6] net: ipa: support retries on generic GSI
 commands
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201119224929.23819-1-elder@linaro.org>
 <20201119224929.23819-5-elder@linaro.org>
 <20201120184923.404c30bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <88104bdd-f464-326a-264e-570a8e4a81c0@linaro.org>
Date:   Fri, 20 Nov 2020 21:31:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201120184923.404c30bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 8:49 PM, Jakub Kicinski wrote:
> On Thu, 19 Nov 2020 16:49:27 -0600 Alex Elder wrote:
>> +	do
>> +		ret = gsi_generic_command(gsi, channel_id,
>> +					  GSI_GENERIC_HALT_CHANNEL);
>> +	while (ret == -EAGAIN && retries--);
> 
> This may well be the first time I've seen someone write a do while loop
> without the curly brackets!

I had them at one time, then saw I could get away
without them.  I don't have a preference but I see
you accepted it as-is.

I really appreciate your timely responses.

					-Alex
