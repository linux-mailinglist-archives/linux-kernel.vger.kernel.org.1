Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2469B2EAC66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbhAENyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbhAENyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:54:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90CC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:54:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 91so36241185wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WeMaF7TAVDOEIygomZnq05mZMvBNk5xAGXnGkwP4VxM=;
        b=ye5X2VuG3ou5wXNFk5tCMRRCWTPYTJ0gR4UGwUrMrOUE9rOMVq1fn7BEQ7Qv9ZUe0f
         T52GJNGyEMCs4wOPnymnhwaZita24pCfV2GaE7K76S5eLmBdmPeZI9XHx5xmXsxKp3Kd
         p9uVsXsss0OXMxuo0BC/GGdWySBMsv5SEQGte5AK5UFq7oREC1oS4GO6Q1yG1KFQwRnq
         LEDpFxRk5r5JCTI20JAIPALpeI2upYM+47VQVhMKoBNj/nUY8Sgdo353APdpf3WtF9sU
         A56HDIiyET1lXVEKGyaEQRD+R8KKgfEwuFA3tZZD88P19IWECm1EovZhOlHJ8IXlg/mo
         K6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WeMaF7TAVDOEIygomZnq05mZMvBNk5xAGXnGkwP4VxM=;
        b=EvhBnruFhTJ/YXIEdgEzPHPw4So+SX4lpgyLbkMGLrAZd271Pycc2Q9hrdZQCt+P58
         i5kpisq8SB2GLrYlwgQUg2TWj/MYkB+arDPGQlisqYE1hWBBOe3+MRm5dBy0VDQn3Hxp
         sJUcCDQ9NnmAWCu04VvTW+Ftr8I/PUCBQ5px1YVkbtZYwdTnbN0ZsYAJir7rrgG9uEDT
         THao7g7eoIUpfCScXGZw6Ozk1ZCKB1hKikQHqlZNPYV58hG/nFmJa0MzIw56o7NGoQ7D
         LRcho/wj281legYmYopM9NDrd9MBP0Zxn6pMUyv/S9CQ8OxxROAJ05gqszw2nroqk6ZU
         eQYg==
X-Gm-Message-State: AOAM530dxN22pajasTHsPfbsvQneTwfqS6kCq08j2YErywdxuujI3zsO
        pG8Ltv6Qps935vbZYM5zgOK6yA==
X-Google-Smtp-Source: ABdhPJyD5a1x18fxXMG+4Mcx13Pev1iFYLAfK9YgIqd+kZ7o7mQ6A/yXNqdPNWouLSe9UlACDrP1xQ==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr84076235wrm.90.1609854843150;
        Tue, 05 Jan 2021 05:54:03 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i11sm4154410wmd.47.2021.01.05.05.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:54:02 -0800 (PST)
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Jun Nie <jun.nie@linaro.org>, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     shawn.guo@linaro.org
References: <20201204075345.5161-1-jun.nie@linaro.org>
 <20201204075345.5161-6-jun.nie@linaro.org>
 <d869ea94b3b1c73800a5c3b855cb6f280be6c185.camel@mailoo.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2 5/5] interconnect: qcom: Add MSM8939 interconnect
 provider driver
Message-ID: <a88b39dd-1c50-8aff-f85e-27086db9b040@linaro.org>
Date:   Tue, 5 Jan 2021 15:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <d869ea94b3b1c73800a5c3b855cb6f280be6c185.camel@mailoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/21 13:08, Vincent Knecht wrote:
> Le vendredi 04 décembre 2020 à 15:53 +0800, Jun Nie a écrit :
>> Add driver for the Qualcomm interconnect buses found in MSM8939 based
>> platforms. The topology consists of four NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> 
> Shouldn't some rpm ids be changed like they were for msm8916 in the following patch ?
> c497f9322af9 ("interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nodes")
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20201112105140.10092-1-georgi.djakov@linaro.org/

Maybe they should. I don't have the hardware to try it, but the test will be
to just add the NoC DT nodes, enable the driver and inspect the boot log for
messages like:
[    2.926647] qcom_icc_rpm_smd_send mas X error -6

Thanks,
Georgi
