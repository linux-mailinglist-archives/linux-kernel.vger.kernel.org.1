Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCB295F75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899381AbgJVNLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:11:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899213AbgJVNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:11:39 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1kVaNV-0003Wd-FQ
        for linux-kernel@vger.kernel.org; Thu, 22 Oct 2020 13:11:37 +0000
Received: by mail-pf1-f198.google.com with SMTP id n85so1184334pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KF2fkAeh1YC8zAXY7ywz35r0cD+MtWE9qyICSYLEPRo=;
        b=FGdutWj9Qe0Ro0IOUTIlmwOZdecCIb6KBjAQ4cU3WLyjN5U5dX9MQBERy7jtkRJKLH
         HSV7P7YCI7aQxGmle91bKNlCLb1yIZgQN8SQgwtJtYxDOtgVU2MLHDIvsVTnla+lfpRV
         A7Olavd7yMCxKoLtNH5MJGemkwWt6kdoe8MD+0ZkDE/KcfmPGNJEXhbbsS6GyLzCKlJt
         L9o4nwUxi1Fsq87juQr2MPJzqEaNLBwzNDIyslWx11mZ24OooZKGJznJsrU0PRJ/z7ee
         EuIG4vF8UK8Q+7bNxqyFVBf7J/46MR7zf6KIOCxqXeIvycQdG7h85f0xKLTQozi8Mnhs
         rPSw==
X-Gm-Message-State: AOAM530OoUoOPv4e76J40u/WWWacI0XF/CmestrJ0MsKI9reWQrEr7Bh
        Yv9dOkOChnUsSxjJr6d5Zxl+ie3qnYprUhnHAErjrCzDBz/X4SFJ+0ui048MEvRnG54XCtI7hHj
        PViaRBmJp4VDzYfQMVHlcfHWV2eUBQ85NzTHU4TMwow==
X-Received: by 2002:a17:90b:224b:: with SMTP id hk11mr2237987pjb.103.1603372295899;
        Thu, 22 Oct 2020 06:11:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywztU+A7q247LVxnGNHGBCv/KhV2l0uG3tTVf5vWuoQD0jS4SKsT911IlFGBOkYkTaf0zQGA==
X-Received: by 2002:a17:90b:224b:: with SMTP id hk11mr2237965pjb.103.1603372295579;
        Thu, 22 Oct 2020 06:11:35 -0700 (PDT)
Received: from [192.168.50.224] (61-228-90-83.dynamic-ip.hinet.net. [61.228.90.83])
        by smtp.gmail.com with ESMTPSA id d26sm2303829pfo.82.2020.10.22.06.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 06:11:35 -0700 (PDT)
Subject: Re: [PATCH] firmware/dmi: Include product_sku info to modalias
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <20201022064047.9827-1-kaichuan.hsieh@canonical.com>
 <20201022144255.667ca9ce@endymion>
From:   Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Message-ID: <ba8ca9b3-da06-4543-6804-ac0d47f26b06@canonical.com>
Date:   Thu, 22 Oct 2020 21:11:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022144255.667ca9ce@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jean,

There are multiple product skus share the same product name, like 
clamshell and 2-in-1 for Latitude series.
Both of them have 3-axis accelerator, but rotation is only disable for 
clamshell model.
Originally, it should be descriminated by chassis_type, but found that 
chassis_type is not trustful.
https://github.com/systemd/systemd/pull/17084#issuecomment-706931881
Therefore, I would like to propose a change to include the product_sku 
for applying customized configuration easier.

Thanks,
KaiChuan

On 10/22/20 8:42 PM, Jean Delvare wrote:
> Hi Kai-Chuan,
> 
> On Thu, 22 Oct 2020 14:40:47 +0800, kaichuan.hsieh@canonical.com wrote:
>> From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
>>
>> Some Dell platforms rely on modalias to customize configuration,
>> the product sku can be more specific for the hardware.
>>
>> Add product_sku to modalias for better utilization.
> 
> Do you have an actual use case for this already, or is it a theoretical
> concern?
> 
