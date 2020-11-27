Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C22C6A86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgK0RUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgK0RUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:20:33 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C93C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:20:32 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so6325616wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vpP7vmjw71SRMNx4A8WcIgdK2b+GFu17RFTTwdIWE7k=;
        b=syeUwIBTyCADVQnetXfbnNwHq5Yn5F2xu28JeU+2CIG4AvM1JY1ak6NAPYycHWEcdq
         uz0K3QJh30jmO5T1DWp3poFEjyyOgSurrw8mX6Ux5Hx1xo17bm7ual8C2G0Ug3Bgijcr
         LIIr5ZjJr7Uk6MGnaJup1dG4UDRMn9Md3ZwOVat8sLrplsTdRplaDgBjSx236nd2jpi5
         z7o1PV71oNTY9/LUu6v/vBQBukP3SOtHmYeQmsNGI6u0bvMYQ3DIjN4InKzDBmBPKcAl
         deZgIEcSE+ed3hfWHJMHJ/SQtr2qBMjKv/LDwjORbL3XYzVModWaXyVqNBC/bBApSlR6
         QNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vpP7vmjw71SRMNx4A8WcIgdK2b+GFu17RFTTwdIWE7k=;
        b=NSws1SipuqcS8BWu6twjkjNjecWVm2C4C9ZmA28k2sX2OxHhyLDBRfQH5ZllxFvqi9
         q9YJsrKihsxC85l1qyn1THNwG2tJRszcd6jSaJnIOKXqPg7tXfPD+pJlwR3bOecp+VZf
         Vske9tAaLT46raFkNsgeFokgZYEbIiOa5F8ZV6aylKqrJSWIA8U1NRcIDNyNHMo/cN0N
         bYcVU6UkD5Tz90W8/21C4v+mH7l03d4z5ZxNtnmDgUkeFNU8xfwbCubwLGsDL9BLdCLY
         C3QpzvPMQitPSnsIg3S9vmQ2AJseprVPlr9PWJu8SYfA9CB0L3VaOPVO+uhA4cJfIsWl
         r5+A==
X-Gm-Message-State: AOAM531uvr+bv8rQj9Ydthag9YqA8/SbnHQzefyKrM31AzVH/uvRzNKi
        EOiIKkkD3RGGQfLKmXvV2bmA/Q==
X-Google-Smtp-Source: ABdhPJxlDS+I/+Cm5n/xWhKtboPIvtUf9Y7FytAFDTEOG09Bt/tZFXXR8lLlW6KY3+ytBF0d6AE26Q==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr12060249wru.266.1606497631608;
        Fri, 27 Nov 2020 09:20:31 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id c6sm18219611wrh.74.2020.11.27.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:20:30 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:20:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] soc: bcm: brcmstb: pm: pm-arm: Provide prototype
 for brcmstb_pm_s3_finish()
Message-ID: <20201127172029.GW2455276@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-2-lee.jones@linaro.org>
 <20201104032507.565008-1-f.fainelli@gmail.com>
 <20201126092039.GB2455276@dell>
 <c26a73e6-93b9-cc95-903c-020e4fdeb3ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c26a73e6-93b9-cc95-903c-020e4fdeb3ff@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Florian Fainelli wrote:

> 
> 
> On 11/26/2020 1:20 AM, Lee Jones wrote:
> > On Tue, 03 Nov 2020, Florian Fainelli wrote:
> > 
> >> On Tue,  3 Nov 2020 15:28:14 +0000, Lee Jones <lee.jones@linaro.org> wrote:
> >>> brcmstb_pm_s3_finish() cannot be made static because it is referenced
> >>> from brcmstb_pm_s3(), so let's provide a prototype for it instead.
> >>>
> >>> Fixes the following W=1 kernel build warning(s):
> >>>
> >>>  drivers/soc/bcm/brcmstb/pm/pm-arm.c:395:14: warning: no previous prototype for ‘brcmstb_pm_s3_finish’ [-Wmissing-prototypes]
> >>>
> >>> Cc: Florian Fainelli <f.fainelli@gmail.com>
> >>> Cc: bcm-kernel-feedback-list@broadcom.com
> >>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>
> >> Applied to drivers/next, thanks!
> > 
> > Does your branch not get sucked into -next?
> 
> It does not, but rest assured this will make it into 5.11 and you will
> be copied on the pull request. I will work with Stephen to get the
> stblinux git tree added to -next.

Okay, good to know.  Thanks Florian.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
