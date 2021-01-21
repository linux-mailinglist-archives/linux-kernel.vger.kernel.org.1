Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAE2FE47F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAUH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbhAUHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:51:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DDC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:50:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q131so1008346pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ArpukKqgHaMQZrpxDemmGF/e2k0kfVvSSfm28/4Eajg=;
        b=DxdlftMrvjU0fFdVCZUiVxOENUjQAxQ5q3grNRXS2DaVvl5XJ8zzLYQBo95qvUEk36
         Uz+SkBigXiXTjaaQp6MNHvohSlPS2ZxLRX8M1qW88yORg2sNbUMpwe5n7ie6d5C4Yw+J
         lu2FE6i9VcYG4M0esNqxuhVcTKzjpO46JIFEsa2yNTi6ReS7ms7kgSH7ygTBsM6KuFCA
         EdjACO5nPmVvNkQKUwZzHb0hd/yMr8LujBfJ/QenS5hiFWRfWtVwdP/EQJwAzSnwrpcx
         jfbYDXnnRff/7G0Uv2EdJMSRFC9tc1xZ9mw5meLiJiXyVWWsvTlYouO3zoIQKkN6PHGX
         M1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArpukKqgHaMQZrpxDemmGF/e2k0kfVvSSfm28/4Eajg=;
        b=kAb+Gzj/jnn0SuO8/jHT5Wtx/Lu3LQoWo5oQZ+SxHtgWZiGDlvAv4jKOvp6UHDK1IX
         1q9naJRyNVfpyHCS/sYg0pK+Oe1LcZcMr6w4WMfv6nsoNRVWCyA264jLiHkO1YCrwuAa
         NhZbGYGCglkQdEgw2CndMHYnpACjkd16l6aBKH6FLz3qXJ8nkCpQmp2764GzzSi61ehH
         melhEf43Eu2VONR8Dd1khgepRjPgEE9+7gYXje+jfcNt7BNrTYqjsdeALzcK+aWarQE8
         TsT/U25ctU5vPsA4DzCcTR6slF8wS0nAcB+az2idJXyWUFCXk86oYcw7bjukAN304JpC
         UZ9A==
X-Gm-Message-State: AOAM532Cxzc6E1O2kRYOcRE+xGUoheeoso7c1914Et9EZDIe9Y524ld8
        1pXoqDrGs1hlDFpOCS8nIQyc
X-Google-Smtp-Source: ABdhPJzLO4YjHwLIXAeASc3SG0WAxtF3gM2EPAuV/kqvQN0pQASMkju6ZWl5Pdiq14ij4kWWNA+zNg==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr12954725pfb.20.1611215430389;
        Wed, 20 Jan 2021 23:50:30 -0800 (PST)
Received: from thinkpad ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id w20sm5139557pga.90.2021.01.20.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 23:50:29 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:20:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 1/3] bus: mhi: core: Clear devices when moving
 execution environments
Message-ID: <20210121075022.GA30041@thinkpad>
References: <1610651795-31287-1-git-send-email-bbhatt@codeaurora.org>
 <1610651795-31287-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610651795-31287-2-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:16:33AM -0800, Bhaumik Bhatt wrote:
> When moving from SBL to mission mode execution environment, there
> is no remove callback notification to MHI client drivers which
> operate on SBL mode only. Client driver devices are being created
> in SBL or AMSS(mission mode) and only destroyed after power down
> or SYS_ERROR. If there exist any SBL-specific channels, those are
> left open and client drivers are thus unaware of the new execution
> environment where those channels cannot operate. Close the gap and
> issue remove callbacks to SBL-specific client drivers once device
> enters mission mode.
> 

What are the SBL specific channels and the client drivers operating on them?
If this is something going to come in future, then this patch can come later.

Thanks,
Mani
