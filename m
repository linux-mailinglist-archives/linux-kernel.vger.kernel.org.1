Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137A62A81BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgKEPBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgKEPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:01:36 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FAAC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:01:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id h6so2750584lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YP+Nqdju6fuzW2lAa4XJEwbHZrtw8MqpA9/si/syIKo=;
        b=gvhtIHwkfe7sbRRwg1h7msdXsdwAL2E+ntob3AsleBHPIFhIM3CASxGd7CTYJoyY5X
         XaX3F6vjsVXfN2UDTd3yWuszMS1sAL85YhC8Hb08Tq8TuIkhAvUWh8I0CLZzmJI84Mml
         CV7/szyDsYC5vR42OPE9hTl5AyWZ1wgAVm3OVsOQ9RBkYMLeAo8kUvzUreiUrndUMGZU
         6X/rRpyiubqcgDV45w/ufi2Cs05agWE6xZx9CqadzZkTEE8f8CfZ4ALKyuJktjZGR1b2
         wSqOQIlVzxzaasp2f5AA3FigQzXlnNnhD9aom3RNfVhGW3rlwXP7fzAknReaByHLBdV1
         St0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YP+Nqdju6fuzW2lAa4XJEwbHZrtw8MqpA9/si/syIKo=;
        b=ilR6zWGEtkS6QiPwi4Bnuv7ahUkWsy1288vfKOGFrtYYD13N6NTl+QcsR2hLhpBs5E
         ksDuhQ+RfvRdac+aPzCxsgF4ZixPnw64iD6DUYk+Um+zAJipxcb/+UR4CCR3HE+5GWnR
         /a3lhFgTtA0BF/IPwCDQatipBDowh2U1t0e1/IRP9Pd14UeBjH2JcNLXhfthASo/PaT1
         dGSgJrT/SvZfwEd5OFc+H2FshWhypjcZumV7IuSgY4sB9ZHBQ673wcDpvdlF60WSV/31
         SjNdwp9l2dGpbKIaFjSMa8Oe8+sfTrRIGpY+3jP7CGnj1CyAY86Cd7cqEd0Usl1y6bXu
         ygnw==
X-Gm-Message-State: AOAM532k7Npkmw20qJp4SZR9v8fVKjtdDxJ7QCqmOORavdcvnMnY2OuW
        CU1KdgIpJEBIlCQOuagCTR0rrGxhiExINA==
X-Google-Smtp-Source: ABdhPJyQeXV+mWcOx1RggApLTJwIjVqb/wGB+yV+A1sOHKP6bkiHkcA1QyL7qTXqpCkXhuP1A6XVcw==
X-Received: by 2002:a05:6512:3222:: with SMTP id f2mr1117348lfe.268.1604588493165;
        Thu, 05 Nov 2020 07:01:33 -0800 (PST)
Received: from [192.168.1.211] ([94.25.228.67])
        by smtp.gmail.com with ESMTPSA id f9sm204058lfa.187.2020.11.05.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 07:01:32 -0800 (PST)
Subject: Re: [PATCH] pinctrl: qcom: sm8250: Specify PDC map
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201028043642.1141723-1-bjorn.andersson@linaro.org>
 <CACRpkdaBbdC5_6y=w5eL-jJ_Mk+toKWy8kj9t-UWx02wNfjo+g@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <d1c2a25e-3cb1-5d67-d038-be80094c64be@linaro.org>
Date:   Thu, 5 Nov 2020 18:01:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdaBbdC5_6y=w5eL-jJ_Mk+toKWy8kj9t-UWx02wNfjo+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 16:59, Linus Walleij wrote:
> On Wed, Oct 28, 2020 at 5:36 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> 
>> Specify the PDC mapping for SM8250, so that gpio interrupts are
>> propertly mapped to the wakeup IRQs of the PDC.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Patch applied for next (v5.11).
> 
> If this is urgent and needs to go into fixes, just provide me
> a Fixes: tag and I will move it to the fixes branch.

Yes, please:

Fixes: 4e3ec9e407ad ("pinctrl: qcom: Add sm8250 pinctrl driver.")

-- 
With best wishes
Dmitry
