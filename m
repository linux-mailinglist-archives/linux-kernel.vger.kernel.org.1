Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216202A6933
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKDQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgKDQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:15:41 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406BC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:15:39 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so15869961qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BzOsbGSY9z7EN9U3fc5QD5cQcFpWtZlGETB+sg6bEuI=;
        b=AR2T9KLf8XPu9X1bK+ltPittyxfCATfM8rGWSbZAU2nes60hOHtwD0Rqavvljsvs4x
         JSWi3bhxloWgjnwA//ypcTwUgmdYfhJId3lm5W0YCgoSNN1/rMRVwhShPAI72lZW36B0
         J7jbq3k/wFD2xFim+Xo53dtOdG961IyhK05RCcVccOsvcTomec5BvZYJdwmcA48QjOhc
         P2DAcDCg/VOomtSfiXOzAAQOHw/5F9lbA0WfrKKqwF+3J70AyWR0YbwV/qSnfYNa/SgU
         BC8QJRLjOV8wfAh2eYw4PfgTvVKetTgaSIvsJ320KHFd1l7+zc2sROBrktDiYpXwKggY
         TKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzOsbGSY9z7EN9U3fc5QD5cQcFpWtZlGETB+sg6bEuI=;
        b=et2OqPhho+LMQzuz9or/UCTrGUymysWsgqJAO5sUqGMqcUDe9v6+c05by/v20f+X++
         YXqiBSDnOAfsxYfNDX7s0AqmRMKV6yOOaeJx/+ZD98Y36rk0gffBXFYch4WKpE02/9Jx
         rwfXmNO/ynoc3BqBQ8+8ZMJz1Ssfo2ibo7CMkBc8CSxDmhM0vTn+TOk/YTJx8ug/iBNg
         AMR5cdZLZefST0Ub9TvfuiLDyBhzGn5/LqGTptTOPS9ZtCda4P7U5N20NkkgkP5DoCdt
         2eqhVyTw3KlXR9dQ50glk93wKzGtfd7JKep+x3pOEJjumBgdb0IYE/1bon4vxPC84iZD
         N9tw==
X-Gm-Message-State: AOAM532cbawynYdH2z0iqZXK2hRc79IlC0ilpZiyuN/c1+OM/c+7FgGZ
        OSWMacSS1MHWGZ00Evug84K5xQ==
X-Google-Smtp-Source: ABdhPJwKPDnFin1U/ARrm/f8XaSD4r0XkJti/p8ZQlMADQoRdq/jSjAucv7ruUG8gZxKY4jx+2PBUw==
X-Received: by 2002:a37:ad18:: with SMTP id f24mr16340177qkm.25.1604506539067;
        Wed, 04 Nov 2020 08:15:39 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p8sm467740qtc.37.2020.11.04.08.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:15:38 -0800 (PST)
Subject: Re: [PATCH v2 0/8] SCMI vendor protocols and modularization
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <49662d46-ca4a-4173-1d98-6ce7975afcae@linaro.org>
Date:   Wed, 4 Nov 2020 11:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202914.43662-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/20 4:29 PM, Cristian Marussi wrote:
> The current revision of this series still does not address the possibility
> of creating dynamically the SCMI devices: any new protocols must be added
> to the SCMI embedded module device table as of now, while it could be
> desirable to have such devices created dynamically whenever a new protocol
> is added and loaded into the system.

Hi Cristian,

Thanks for v2. I have raised my concerns previously as well on having a 
static table in the main scmi framework for managing the client devices.
This will be a bottleneck not just for vendor protocol addition but also 
to extend the currently supported list of scmi protocols.
I will wait for your v3 (as you mentioned previously) for fixes  around 
this.

-- 
Warm Regards
Thara
