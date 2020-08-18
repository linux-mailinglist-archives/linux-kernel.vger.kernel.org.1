Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7E248B88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgHRQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:25:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D70C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:25:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n129so18788005qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvxwZaj3STU+XBzbFZF4Eo4TNJffoa7xZkZ37kAZh9I=;
        b=xslbahmqP51ElTDl7YH8n7I/5v/fdUIQKZAxFp5WFFkqdcuE0gaERIY67/WRha0FNV
         ptlf1L5zLewfnNfx2DiOsBQFOjSExO8ZJ8yR9+VtUlJOIReXgjvWsqItLG5B+HcacB69
         y17gU2T+PVT+8L3UtgnN1F3EBQPOClg90xL/iPXsCGp/YEuePAoTxsYZhYWSwLxrh50x
         U3ESkz+/fMyiaBLvZe6OpFcOIeK6a7CjalNrWPovTv+K59V+fz+nSsgl6WrKwvYqnxyg
         sTIJIRi6+M3bfZtIsYxbuTmOzErTsapDxDZqIjbdKRYdxbIQznvT1HFU92bCPXCITQV8
         /W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dvxwZaj3STU+XBzbFZF4Eo4TNJffoa7xZkZ37kAZh9I=;
        b=Og0HBBXHQ691W8VPssSiea44auM37w4dE3xJl4obcsH2B/coM0vok7vVH7+jypFGlH
         4sgofg44IBpBEZkfo7NANRJb3ZLNamd5ogW0euDHFprK5D76kyqqwbLwP1PD8Va5LWVD
         GRqwKf6k5N3XaZsGUh+Rfur7yLeOlGjWKokRck3X9a8JR2DTF9uXXj1bYfiig78LXEXU
         5rQGJwuswYwwn06dJYk0PzR9e5eB58Gz/NcJ/PsHfdBW7Jfm8DUnSC5qsOSreDNLdP7a
         2OIFTSjvVKquVN0c74hZ7X4fCQ08QrZE09Oq88zTo4oZQnPfaHHB+82twGWQQhB8OGqx
         xnkg==
X-Gm-Message-State: AOAM532eBLuZNQONiCgQx/krEcP83LtnlHbzYI5dbEZdw6Nn57CoHA/j
        AyhyXEdDH9xw7kTtEWFfla+qwFeaLNq89JBt
X-Google-Smtp-Source: ABdhPJzlUlvP2CjCftbRUYw1ctpF8qKO1bKnDTaWq5BCBWte2qKx4QUPmdS2Sdg92ObSIJbWoEZzhg==
X-Received: by 2002:a05:620a:24c9:: with SMTP id m9mr17643293qkn.487.1597767924233;
        Tue, 18 Aug 2020 09:25:24 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id x3sm21157489qkx.3.2020.08.18.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 09:25:23 -0700 (PDT)
Subject: Re: [PATCH] regulator: set of_node for qcom vbus regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
References: <20200818160649.19585-1-jonathan@marek.ca>
 <20200818162124.GD5337@sirena.org.uk>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <bf77f8f9-9fbb-bb4a-c905-cfc2ccdd1e81@marek.ca>
Date:   Tue, 18 Aug 2020 12:25:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200818162124.GD5337@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 12:21 PM, Mark Brown wrote:
> On Tue, Aug 18, 2020 at 12:06:49PM -0400, Jonathan Marek wrote:
>> This allows the regulator to be found by devm_regulator_get().
>>
>> Fixes: 4fe66d5a62fb ("regulator: Add support for QCOM PMIC VBUS booster")
>> ---
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it.  For details on what Signed-off-by means and why it's important
> please see Documentation/process/submitting-patches.rst.
> 

Sorry, my mistake. Resent the patch with SOB added.
