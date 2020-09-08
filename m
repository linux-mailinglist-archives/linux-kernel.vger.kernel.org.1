Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA30261BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgIHTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgIHQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:07:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57200C0619EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:58:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 16so5985058qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+0VeQsmoLvQuU6aBo8zkUNaslkMwNc2y2ovMYLqi8XU=;
        b=mCT551VGMZB94T4mxoyukc4bwxgzEzUfWwL2NvOY75ZaeJdpVQG9CBGM1bGuJrJs2d
         vIOmu8PzXYmtEsQLa/m2JAQSu0eJCPrcPkfvV9Ijc4QajjV3687zmTDPrqeSq1uJuG91
         dsViQvLDQdy6yiU6PEXgnu4e/No+wesobtdBRKR8F3GKNMVVobwe4Q1QlOXue+A4zk2K
         aYi1G2PgHsePs/N6bKyI3DvK2mxmNGCtZMk5tgCkOnw4yYsxg/YOAyvDPeqBTNZj0uyF
         +N6GfQAzFQn/Ey3fK4fQ10k+G/OswU60JOly4rzK2N70fyiOx+Ce+/BJY+P/ccnOv329
         b9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0VeQsmoLvQuU6aBo8zkUNaslkMwNc2y2ovMYLqi8XU=;
        b=hTRc/w8zDLifilSN81DUUq/70NWbUQgwDVCQ3pH+mOjUjqflOaCYPyY4w9ZAgGAUyW
         Jriyu2tHYpbQr56466RC50eqwemIrChRDKl3cjWdW4q90qUHta5QZniSSzuNL72sXhr8
         TeOVgmLij73kX1XRvPwAVcI1LK3JQIYWi1ZYrIx/6ALJfLuDXIh7zv6KZy9W0s4/MrZW
         BhTLfUCJpiETAqfzyI8e1ACfmN/acc62+NWmSQTtMUTR8/bQnm8AJBb/9TNLDjTvlEmz
         a2s2SpWhKdWRe3iwWN/VJOAZ1C+wq4BhTnV2Pcaru+xBYwLexZNz0qcYCDMFyvI97/FM
         PywQ==
X-Gm-Message-State: AOAM5313MaSLxbNknQOWwFpbeV2mFCRU/1ZeruMP0xAA1b2hzyS4dWYu
        a7TUPk5tz2acJTBB402DX4eUMA==
X-Google-Smtp-Source: ABdhPJzENRkC0WQz6clGvHTyG+K0LCw8iXyZ0zOHXituNkpO4M4F4y2QK9X/EX38k0eqbQaYJJPsSw==
X-Received: by 2002:a37:b201:: with SMTP id b1mr224085qkf.10.1599573517558;
        Tue, 08 Sep 2020 06:58:37 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m1sm10014629qkn.89.2020.09.08.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:58:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] soundwire: qcom: add support for mmio soundwire
 master devices
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-msm@vger.kernel.org
Cc:     "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200905173905.16541-1-jonathan@marek.ca>
 <20200905173905.16541-4-jonathan@marek.ca>
 <ad39f109-bfc9-332e-adc2-355499db1ab7@linux.intel.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <4bf165c2-1458-442b-5c85-5cebabda7232@marek.ca>
Date:   Tue, 8 Sep 2020 09:57:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ad39f109-bfc9-332e-adc2-355499db1ab7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/20 9:56 AM, Pierre-Louis Bossart wrote:
> 
> 
> 
>> @@ -764,8 +786,11 @@ static int qcom_swrm_probe(struct platform_device 
>> *pdev)
>>           if (!ctrl->regmap)
>>               return -EINVAL;
>>       } else {
>> -        /* Only WCD based SoundWire controller is supported */
>> -        return -ENOTSUPP;
>> +        ctrl->reg_read = qcom_swrm_cpu_reg_read;
>> +        ctrl->reg_write = qcom_swrm_cpu_reg_write;
>> +        ctrl->mmio = devm_platform_ioremap_resource(pdev, 0);
>> +        if (IS_ERR(ctrl->mmio))
>> +            return PTR_ERR(ctrl->mmio);
> 
> Shouldn't this be conditional on SLIMBUS being enabled, as done in your 
> patch2?
> 

No, the case above is the SLIMBUS case. This patch is adding support for 
the non-SLIMBUS case.

>>       }
>>       ctrl->irq = of_irq_get(dev->of_node, 0);
>>
