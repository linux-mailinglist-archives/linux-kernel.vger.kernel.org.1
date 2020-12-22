Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4942E0AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgLVNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbgLVNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:33:57 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:32:21 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k8so12006570ilr.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1h+XS3Jpg37m9OWU9Zgfs5kJQZ5F9azt5axjaoAFa+o=;
        b=AZpT2+SASG9nJBeXvpxrCgYcrKqMNKBOKhzbZE3iQHjPReCYhNxsX1FIcoozKiaYV+
         oeNdLumwRlra/kfdUg8dNPyqt/2WT7UP590126MBFhOxbKcmgEHCq97+3rSbF9mHWrD9
         gwwpYdZ711yTLP5cXBBBMF+bczS9F+VvUZUmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1h+XS3Jpg37m9OWU9Zgfs5kJQZ5F9azt5axjaoAFa+o=;
        b=bEHuMziaCu92TB5id/Nnh6YoSQjkuJgavy3KehlSHT/TEdNpAnwoRc8HN5P/+CKSaN
         og//92d5Nr0G3Byo6Q0ByR4WbITn6s/QgzR5viiNT97vFyv+866e4WWo5nBi4mTULHTn
         5KdlCkqnkxty+kQV56hFYiGao2KJCn68Pni/590WemUNfmvVsa0iTPDfll+UOJGQtz0u
         oYGxj99rxpGbkrFbMEPoRVFX8eJUyvgNUFF6jmg+HP7ccByzHBxnFOT6BcFPjhSbmon4
         4k6NtbNcaMNiOAxwxzNtMjWNOV+n365O9fVx+7jUKA9b/tueHzr1H3QfKrxkWZF/bZc7
         U5+w==
X-Gm-Message-State: AOAM531Zcc43zw0g9aDSHs0quivdKUGD6QeyVG0kl3sZrq+IaXoALxKz
        8MI8Puzvvws2vl1vtQh5rmkmxA==
X-Google-Smtp-Source: ABdhPJyQG7N3kXgSBl8zSeDDDpQE2eNi22yYVF7ddAXWlUZNzn4bpdY2d8S070MVCt/SQB5C6Vxhlg==
X-Received: by 2002:a92:b652:: with SMTP id s79mr21318208ili.251.1608643941395;
        Tue, 22 Dec 2020 05:32:21 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o7sm23739687iov.1.2020.12.22.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 05:32:20 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: net: qcom,ipa: Drop unnecessary type ref on
 'memory-region'
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alex Elder <elder@kernel.org>, netdev@vger.kernel.org
References: <20201222040121.1314370-1-robh@kernel.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <8d7ee97e-1730-908f-9576-88950fd59c91@ieee.org>
Date:   Tue, 22 Dec 2020 07:32:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222040121.1314370-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/20 10:01 PM, Rob Herring wrote:
> 'memory-region' is a common property, so it doesn't need a type ref here.

Acked-by: Alex Elder <elder@linaro.org>

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'll take this via the DT tree.
> 
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index d0cbbcf1b0e5..8a2d12644675 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -121,7 +121,6 @@ properties:
>         receive and act on notifications of modem up/down events.
>   
>     memory-region:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>       maxItems: 1
>       description:
>         If present, a phandle for a reserved memory area that holds
> 

