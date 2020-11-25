Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69742C3D17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgKYJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgKYJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:58:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67596C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 01:58:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so1277082wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 01:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IGoyXBsorWkLQoXFObTVk+nYQCTZv7J02NxoMaKjTAY=;
        b=Uj5LRdofKuT8+5FuGdVIteQYraSKJiu7/YfKp8bInFXi+d70QuXk1UUvcs117qs9DF
         xpgv8U4MZw5rAFBG438njOVGOeDntbEyDls/bx+XrHV5ULhNCDI4UgkwmdFDrIk8s9vj
         Owabze74c/NFpNRl7Etx2ax2UQEpeYmoTzfHGPzhipelcb2qTEhTWYRCC3UwDSIn2dOJ
         ooxPjoN5/UBk4M1gPlKVDfX7Ncfb9rhsEdeXpSx8MKMWsAO1ygyClyaC1FjEK5DpiHBJ
         Jrgbc375NF22Ti0GBpdVS6+g6n68qV2dKZBW9xws7yVXSvD+lC9zyH10RxCT5SezhjMS
         8G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGoyXBsorWkLQoXFObTVk+nYQCTZv7J02NxoMaKjTAY=;
        b=nvVFDOiwdx1QjR+f4DFpRKMf2p75oSlBdOPDGP+VkGs8q+DEkfYypnVB2qOOAsMMi9
         ZZLT/Np3VbbXeplNoZvtpZyJIz35J+A0mkOyojJHsoajquJxuYFVnKZT+WLl2uz46OKd
         ldPy2ytGExt8lgl0hDYygeeaMYEqhRD0yTlOA3+wD6nozZe/zwWRk1X5K86zw5qaIVUW
         cTtfjk+is2mmWeTIG9QuFG/7P85nTSrVUorPjHUiN2zfbISfhfFfIuGDaTbQKp9B0dtH
         EeUHnkIT0oNDSEEDNv9i5p5AMM7hb8p7DklftAsBcmU/ebgApyCnuIOrs54RReejfIr+
         k41g==
X-Gm-Message-State: AOAM533ZmSMfvGfdbZ2hc5+I+Hz7YY2aMWFLNyyq4DS9079tgEfKlPsn
        FveeflieIbNdjVIbOPwRBmDLlQPRocuvufGE
X-Google-Smtp-Source: ABdhPJwwJEoDVfiJEDcAdp12hLdqEk12t7E2J/3yeyUwAU16zYFlKjqpQdsIf/Z0BjD+fAhAB5dELA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr3269628wrn.340.1606298287868;
        Wed, 25 Nov 2020 01:58:07 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b4sm4153093wmc.1.2020.11.25.01.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 01:58:07 -0800 (PST)
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Avoid sending power requests
 without QMI
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201125054255.137067-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a92ba901-283f-e0fb-54e0-af6c87bbd44a@linaro.org>
Date:   Wed, 25 Nov 2020 09:58:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201125054255.137067-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/11/2020 05:42, Bjorn Andersson wrote:
> Attempting to send a power request during PM operations, when the QMI
> handle isn't initialized results in a NULL pointer dereference. So check
> if the QMI handle has been initialized before attempting to post the
> power requests.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Applied thanks,

--srini
