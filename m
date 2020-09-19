Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78DC270DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgISLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:43:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:43:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so8117691wrv.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZ1Xg9xu87AJbKRQeqyi2KGzZRXOlNHypsuQaTggL7M=;
        b=O3rcuuptNIi6Grt+CnxIUHZyxSWPP9lZISX+0CiGIGpKCdBmMtzhfhqcDhYRAiXVRk
         /Jm6xtStN8ayYUTdrSTSa/kMI9KBNfJvvS9tvY0apynEO9HNJU0XWlIyCFA2uoYCqIl5
         ZM9rFly1ajeqb2LV99nZPYFeKZxw2aZAlOFOC0jy7XhwynZdz/qqiXn+eo9in8D8CbGp
         Us21RkmTgEkTG9huHTAlf76z3PnaoxfpxwECflfPd101KEIq2Pzo/coTg+kfB+HHDgVW
         jSlThh9T2BF9gHoJTzGm/mCkCV/9jRg1WvmJlnINx1aQLNA/h6EznyYxTxocIazVkU6p
         XdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ1Xg9xu87AJbKRQeqyi2KGzZRXOlNHypsuQaTggL7M=;
        b=I5opsk7boMHi9PflXTb4VRfMJY7qNHpUeSmaOm9Xopu6gML+cXTz26kL7+6r9KRVI/
         xQgAMTVrN7XTv3Ql832cBMuDgcXVywmu12eaakb1iDQOQ6rh/DLtqFftoaEDoWLj2E4/
         Msm7VLDbxvt/4AkR2nj4yobUV9sgIleDBFwWDQxwTvu1nSIweI9+LcuRllS94g4doyxz
         KMc9K0TjTWZWDMcwVnCuBnt48Q16bcNk9mLO5vKr2jI3/+pJJyXLSGBgrQqK12v4YAWJ
         oO1MfQnfVy/tkoVv0MxbreeEI7CiGPGSaR/JZUue31G+MTd4D4mKr1Q4RKevWgsYJrXM
         K3gQ==
X-Gm-Message-State: AOAM5306KjAGtEW4nK8xjIlJRcz3XR8Bs+/49k0OZatmvvnJ8bXPxjJF
        UfUdyyJ6BnL6lO/bv7ZtIoVGXPVK2V06DA==
X-Google-Smtp-Source: ABdhPJxxDCQGtTX077DT0dkDppRm85GvwwtV0yU6McX0Fq5XFSd14UJn1U1pNT9VABMX+oO2mlZ4vQ==
X-Received: by 2002:a05:6000:151:: with SMTP id r17mr41907468wrx.311.1600515790377;
        Sat, 19 Sep 2020 04:43:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9142:20e7:201d:cd11? ([2a01:e34:ed2f:f020:9142:20e7:201d:cd11])
        by smtp.googlemail.com with ESMTPSA id d13sm10772599wrp.44.2020.09.19.04.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 04:43:09 -0700 (PDT)
Subject: Re: [PATCH v3 9/9] dt-bindings: sp804: add support for Hisilicon
 sp804 timer
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200918132237.3552-1-thunder.leizhen@huawei.com>
 <20200918132237.3552-10-thunder.leizhen@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <89edf87e-099a-85c2-6259-de60c0a84608@linaro.org>
Date:   Sat, 19 Sep 2020 13:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918132237.3552-10-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2020 15:22, Zhen Lei wrote:
> Some Hisilicon SoCs, such as Hi1212, use the Hisilicon extended sp804
> timer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

I'm not able to apply this patch, the file does not exists.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
