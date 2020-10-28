Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72529D9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbgJ1XG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390075AbgJ1XG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:06:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:06:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x1so1251646eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=obX9bOfBc5uikoFMarb3dNU1LogIPrbFVnFPCam7D9s=;
        b=Gy+sIahMxUApJBBwADXHtP9oKZmq9WOrAPXB9bJWMCLxyYQl22CBrKvU3OKhA7ZAbN
         Zkxs7rKZ1glFXqBA+nDP4Nh+I/5ypuJhD3PPkuXJEnQZtIuGYGlTTJRgPDayWN2au9pP
         jzYnYewCUQon28ISS19O6pd3uI0qI+KssN494XGBEyybM3KFme8muyi/zmp2C2nt9Ss6
         kubMy6fvOn0nveo72eGyblra0v4VU7CEkEvXl9Ojo3npCwq27G9zV/hdO4krJRR2cOxC
         ti4N9hKS+zs/nWsfP/27lCCATIB4TdK4LHtz1QJ71EoC2X9n/PW1UU23NB1nia6y7sMX
         kDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=obX9bOfBc5uikoFMarb3dNU1LogIPrbFVnFPCam7D9s=;
        b=i57eIoQlsMh+1nsmOhoAGdSFUR8AAQuYoXMU/OAMAp+pCuT/WvvXr9Bj99qIYp2Iuo
         8E+4reT/w/ZMxOurUxZcjWPKBlWhbP1muFjxBo3cdddZy3+1bSysJFAz7fzaZUcPrKGr
         9ZUKGdR5KN99YpGZHnDAXwceiKYNOVTQYbIcwCLQ5hRS6F5UJIDy2xFa4E7xRWbZ1ee3
         St7ZsfvzhSM1s3Uh/dh8BJwOAlVliN8Mb3zGAmmd6ybOElcbrHGgoZi+u998ekNbJZlZ
         usXHMli3S9IT2ffQQhmYiDZez/irwoyEhg8ENo4QH2Xx+2nu8rQv+y7eqLgIj6bU3st7
         hh8g==
X-Gm-Message-State: AOAM531xXaFb8pcEwCsbShq6is5QxKf5Tcvsy7b+eHp2TN0NQ7WEDeet
        bmj2+Dz5/+WQ3dK0hG1phXOALW2jkBApqQ==
X-Google-Smtp-Source: ABdhPJwiD7zU2hdGncHxTC//AnN6ATPTo0Cfz9yxiGD7wm0p3+gr8xeT014iGEUOF1AzkWJEcxeoqw==
X-Received: by 2002:adf:9361:: with SMTP id 88mr8873458wro.37.1603894858300;
        Wed, 28 Oct 2020 07:20:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y201sm6549626wmd.27.2020.10.28.07.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:20:57 -0700 (PDT)
Subject: Re: ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
References: <f441bb6c-12eb-a565-c34d-950da2b045d7@canonical.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <66ba82c4-f08a-2e35-385f-8822934b2c54@linaro.org>
Date:   Wed, 28 Oct 2020 14:20:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f441bb6c-12eb-a565-c34d-950da2b045d7@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting this,

On 28/10/2020 12:15, Colin Ian King wrote:
> Hi,
> 
> Static analysis on linux-next with Coverity had detected a potential
> array out-of-bounds write issue in the following commit:

Sent out a fix to address this!

--srini
> 
> commit aa2e2785545aab21b6cb2e23f111ae0751cbcca7
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Mon Oct 26 17:09:47 2020 +0000
> 
>      ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
> 
