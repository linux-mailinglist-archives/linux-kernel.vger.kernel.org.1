Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5093045B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393408AbhAZRtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389906AbhAZIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:24:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECFC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:23:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b5so15458893wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+1Lc4O6nG4WhNY0kjZTVH5GmXcujH+6YTZBb0u4ztaw=;
        b=NCLjOPCeW0kVxk3yrO3M6dYXo8ICaFIYVCPHHQHMbAIcSB2UiiivZ/bCnB+HvgeLqg
         PRDdIo9OnDOMnNppoAtmhPaFkxBlmAGOVCiVJVzahSK5U3j0dmNbm6q2bPrVoMRzNL7C
         MBXylqhLEdzBqWCVQbqclV5j4/GUwRsB0S5RcegmujdDg1G/TthoTLENaueZWFz/Tl6p
         SGfkm28PzhXCxLQqyZ6lvSM/qF/yVzA+AQmOVr1/bPYJb6J/d7ow4StilDfrA88xFTkm
         hebdStlzclls7lwSekV3tWVl2dABxUO3o9b8M9yMWUsDzXeJV8Hdxko7KsiuKMI0gtiS
         4kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+1Lc4O6nG4WhNY0kjZTVH5GmXcujH+6YTZBb0u4ztaw=;
        b=sdc/3ZkE1GS8UvIerMfzhjEfqOnV2FuHmtgAs5pu+B2u+7H0GSyUfgC3Nb5EYGqu1b
         Ev2r8p3+sP3YkHPVkwURzad68a1BJJAnEebpWvUMgrEwg/c2e2w7pn+w//U4ixQBPn6V
         RGv2mFC8XEALAkivv/HNqd47dxOsbSCvYVepG2T0fkhHe6Fb0WvSmW/uy9QPw8U/trNO
         xx/QnwPtP7r1hhWZHTJrz3uGJWNckI4HhAg2faQ/jEfRVPE2KkzlhFdiydzB8MjLo8A5
         iXH8TWHSMnJLVsQrWz7nYZjQIB7e97nChj5m4/tVyim4g/eQB5iFURt2o5v/hTxAWShu
         byoQ==
X-Gm-Message-State: AOAM5300IuvTBVJr/KS0GhfGfuMk/0VM8HHjOv27qfkoIPm/4MB9kJGK
        LDOdG3VqwdXGgV2r16A7xiDUdw==
X-Google-Smtp-Source: ABdhPJxFtksMoT7z7tmcaIzciXM5Yo4ztSCBt2/7Yj5l1ZVRcewTk7AyaBxzF/54i5daAIhUQmoq8Q==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr4596712wrk.89.1611649397976;
        Tue, 26 Jan 2021 00:23:17 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id v1sm2227852wmj.31.2021.01.26.00.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:23:17 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:23:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Jonas <toertel@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam.Thomson.Opensource@diasemi.com, stwiss.opensource@diasemi.com,
        marek.vasut@gmail.com,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Message-ID: <20210126082315.GE4903@dell>
References: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
 <20210125125458.1302525-2-mark.jonas@de.bosch.com>
 <CAEE5dN34ywfT9DUqwzrog_ujEANYioYxJbJ8M=8Om_-=7uJHcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEE5dN34ywfT9DUqwzrog_ujEANYioYxJbJ8M=8Om_-=7uJHcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Mark Jonas wrote:

> Hi,
> 
> I also intended to send a cover-letter but it was somehow lost on the
> way. Here it is:
> 
> On an NXP i.MX6 Solo processor we are running an application which
> makes use of real-time threads (SCHED_RR). In combination with a
> DA9063 we experienced (rare) random shut-downs and reboots. We found
> that the issue was caused by a combination of the (default) DA9063
> SMBus mode and non-atomic I2C transactions of the i.MX6 I2C driver.
> Because a transaction could be idle for longer than the SMBus clock
> time-out due to a real-time thread the DA9063 would time-out and
> receive the second half of the transaction as an unintended message.
> 
> The solution we are giving to review in this patch is to allow using
> the I2C mode of the DA9063. We kindly ask for feedback and eventually
> hope for an integration to the mainline.
> 
> Because we are on a vendor kernel we were not able to test this patch
> on the current mainline kernel. Though, we tested a (very similar)
> patch on our (close to mainline) Linux 4.14 and 5.4 vendor kernels.

This is the 3rd cover-letter I've received now! :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
