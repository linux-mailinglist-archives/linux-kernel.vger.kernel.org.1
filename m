Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA3278775
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIYMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:42:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:42:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so2917897wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KUryYbnZpm0yeVZIRKefUC6M0O/GrMOgSGYbXosQ6Xk=;
        b=BpNlCV+pbWeE0eUZG4DQRTZFzOy6yddhWieG5knRNcAdKww14G5SPSVWpzF+ijt5sw
         QeDGRsLjzICobzXVYx1eOu4J/DPyIw8zqo4ie5/Q8HyVfIUi5R0ra3jZEREieYcmdeDm
         9xAI+6zk7ZsaRcxY4FwMnLXMDCqCaSvKQDRhrU8FbHNII18f/YbYG2Ysx1YzOgHR8Urg
         1hbflDIWt5FBOh+1xhFIyU0d3gxiSjUIaDHMYndlcYG/dX7shBUzZX2St6SAZnC73VZy
         fNTzCWmW5LD7d73HRaTUH4Au37R5Owsywi97e9zOJ7hl/nmTLBZ9t/gfbFoh6yDkNpFm
         KJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUryYbnZpm0yeVZIRKefUC6M0O/GrMOgSGYbXosQ6Xk=;
        b=nKeQpqN/iHdaBq6TjzyA6cG6FCR4W/4pve6JRTGtjRBPIo7tOWXzDh+3X5oPuJkqSI
         JRbn/0Wsrnk9x96AQ9DeGLxusEbvluTC+nVxuvEdekvOGwGo3wBpV/Q5fDbSrgPvUelD
         Ip+SiAA6I0/IgmePUVzH1ijhi4eXIypux1yV2Gb821CsLpakW0i1VOvsQievSi7XSSs4
         /qOYlKTnwQSiHcrwmSiGuv18j10Oqg3f0svdMhn1w6zUCDXj+akNsyS11uqa2FzS32dM
         GdfOGMaIzMRkyXWLESEZv372r4eMNqGfanciYdFiWyxqucCNt/+yRIlP9/jN/g9D2c3K
         2wdw==
X-Gm-Message-State: AOAM532MoAk0Kb7OJnQch03oonAottOLprWsr8QXGPpbqL9iiR8E8+3m
        sxnkJq9lN6pGlpOOZPtjLccrVImFioOJUw==
X-Google-Smtp-Source: ABdhPJxDIKyVoE9m+nFSPLA2j9URUyG4GzqljekZWKWdquULmaGAMeQ9xeSEbhLHCMiTwrFd2vtNTg==
X-Received: by 2002:a7b:c44b:: with SMTP id l11mr2923556wmi.52.1601037747465;
        Fri, 25 Sep 2020 05:42:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p11sm2634316wma.11.2020.09.25.05.42.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 05:42:26 -0700 (PDT)
Subject: Re: [PATCH 1/3] slimbus: core: check get_addr before removing laddr
 ida
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
 <20200925095520.27316-2-srinivas.kandagatla@linaro.org>
 <20200925124101.GB2732292@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <91b5383a-4d10-24eb-8db4-9cdc75982102@linaro.org>
Date:   Fri, 25 Sep 2020 13:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200925124101.GB2732292@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 13:41, Greg KH wrote:
> On Fri, Sep 25, 2020 at 10:55:18AM +0100, Srinivas Kandagatla wrote:
>> logical address can be either assigned by the SLIMBus controller or the core.
>> Core uses IDA in cases where get_addr callback is not provided by the
>> controller.
>> Core already has this check while allocating IDR, however during absence
>> reporting this is not checked. This patch fixes this issue.
>>
>> Fixes: 46a2bb5a7f7ea("slimbus: core: Add slim controllers support")
> 
> Nit, you need a ' ' before the '(' character...
> 
Not sure how I missed that :-)

> Also, you don't need all of those characters, you have 1 more than
> necessary :)
> 
> I'll go fix it up.
Thankyou very much for fixing this up!

--srini
> 
> greg k-h
> 
