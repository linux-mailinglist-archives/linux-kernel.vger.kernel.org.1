Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBD29D78B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgJ1WZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732899AbgJ1WZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE14C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:25:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so623153pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hvfu2O4x70zfOMPRKar/p0Ao3IuBnxAMAZDvJC8rl68=;
        b=zoof0+raMu/he+76Q9IaQ8w/GqD3T0dWynKY3ZLIejbNzYdWEPv+hT4wf64OGRdHrz
         eX6HseZHjxRB9kzvRbRKAfYDP3Bu5FYM2bDW+JDzsCJ4Bly0VbtiSxaA7KF4X/6EatYU
         TadbOvoVZBNcDYRzcNNvJTGAjaE8GnrjybD4QvfaQpgsSECkHDNJkIrW+FeTpZuE2CnK
         hnV6jBVqsIaCXlVTWrfORfZoQI7k/1fTfoA7csEqTA9eFUteZscv4KGPdip2v0yQjgeP
         RhG0A4RycKaGcmzey0lGPfF5nmF90L50aRJdED3hV5s3YW57vtS4fj3Z9qTqnCdijLky
         Qkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hvfu2O4x70zfOMPRKar/p0Ao3IuBnxAMAZDvJC8rl68=;
        b=ewRJ4ib9w5/4jKqoax3uGnTMCaAWuOKSvURCLr+FFT9v62tJsPVV4oITZl014eR7UJ
         X2436GyTUfYQ6cncPbMb7y2P1TbjGoxIXYcY36PBt/LOiNsRpitXTEWj5AwWeZSHfZtf
         CmjV97PZ9HiXTGXGx8SCsL9KyMSQCugq2fr7FEUDw2YdjH7A3mfjRKbdPTi7hnL1c/3i
         RSRKDM3FsIj5+V7ukU5pJZj68oCpZsA3CdDwKKDkFzgyWJds4YcSglebxm0o6FxF7OBK
         d88WJk1kHV+qBpgeJdpLFGwjjXsB2Qkbs7i0zIqjoZNvufwRCqG0HRYwvsfABXWVWMQc
         bcMg==
X-Gm-Message-State: AOAM531NwF//KmCYFthnV6RFGZ5oLpUP5A90F4pygQhXFuU8ukQ1FlTH
        Chqg4XmMD4F1eDjK+Xz84U6+qO0oPxDu+2n7
X-Google-Smtp-Source: ABdhPJw5nHKnt9TZvp0aBVHgiiUiftX46fk75iMXXqiiQv4OKF3yjXJiExJgv4ZU17o39DPteg5CsQ==
X-Received: by 2002:a92:ddd1:: with SMTP id d17mr5514566ilr.275.1603891847202;
        Wed, 28 Oct 2020 06:30:47 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id n15sm2747094ilt.58.2020.10.28.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:30:45 -0700 (PDT)
Subject: Re: [PATCH net 5/5] net: ipa: avoid going past end of resource group
 array
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, evgreen@chromium.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201027161120.5575-1-elder@linaro.org>
 <20201027161120.5575-6-elder@linaro.org>
 <CA+FuTSdGCBG0tZXfPTJqTnV7zRNv2VmuThOydwj080NWw4PU9Q@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d8611e9f-acef-d354-c776-f06b27365945@linaro.org>
Date:   Wed, 28 Oct 2020 08:30:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+FuTSdGCBG0tZXfPTJqTnV7zRNv2VmuThOydwj080NWw4PU9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 7:14 PM, Willem de Bruijn wrote:
> On Tue, Oct 27, 2020 at 12:38 PM Alex Elder <elder@linaro.org> wrote:
>>
>> The minimum and maximum limits for resources assigned to a given
>> resource group are programmed in pairs, with the limits for two
>> groups set in a single register.
>>
>> If the number of supported resource groups is odd, only half of the
>> register that defines these limits is valid for the last group; that
>> group has no second group in the pair.
>>
>> Currently we ignore this constraint, and it turns out to be harmless,
> 
> If nothing currently calls it with an odd number of registers, is this
> a bugfix or a new feature (anticipating future expansion, I guess)?

. . .

Sorry, I missed this comment.  Yes, I'm working on support for
an upcoming IPA hardware version that has 5 resources of each
type.  And it is a bug fix, though the bug doesn't bite us
(because the maximum number of resources supported is even),
so "it turns out to be harmless."

					-Alex
