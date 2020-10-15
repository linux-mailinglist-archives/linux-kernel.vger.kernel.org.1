Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5628EC46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgJOEbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOEbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:31:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28568C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 21:31:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hk7so1148284pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 21:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1z00HM1oJWpdTbX+YMPLZimSogxpQwLPHkUejQUce64=;
        b=RhxJv6V2WOuh02i/6FfdUpPNGHak72ni/501XgVQTKAfCMPuG4Gc6DcST1NvZcx++M
         QRA1y4xTETTq6iEuOFgJX2d/SNf+89MPLavxyACaGI85QNfoPuhzJU3Sg/HIPJwu2IKZ
         DNh28elij0nsMs3gNecVl/rQHT4GQsbYVTw5Y9klFgZx76LjOk1jftCyxnvgjpA8dsWE
         ilD7xp0EKR+p3gWwm2hA1tCFnhhYACBBJ/qJPaQ24qfakQYjcd+9WOwqfsNQPqRAEoQA
         xgSAKbDdRjDbads6MMNuxpfyHkgqA2P4jTq6uFsaWwdK7g8AI+7gvLL9kRxMadA5fLAi
         9UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1z00HM1oJWpdTbX+YMPLZimSogxpQwLPHkUejQUce64=;
        b=qO19lCjCGrBWAdFNic59fF7ISzomrTeXxIO9YYvK7Ilg4cgVFeOA+AUNZSxQFJ9TAl
         lAelaguhGnuxXt0toUL7N9Xch8x2s0cTuqcDiGgMu0dRYNRT8QMsNkiyBDwKE/LwxQwC
         x0Ze7UDFNTQSXU11Uqtyqx/RoW7pVRTAoIrExKrdJHdUECBt9gxeDEXRli3vcZ2eKyGA
         9v+V2Jgyp4DiZzk0c2IJA5R5V7/qN98dPDbmrGsiQB1kWExt01y2/v1d/QAHVMxxO0Jm
         Q2kQCuXCZnUUUjJZQsL14cHPvkrxHd8xTTm5P7T3K9oLvRVid1yeWr/yQO7jMhLH//TG
         59IQ==
X-Gm-Message-State: AOAM5309CXEvZAPMBD/+iDOKwmy+jfL5810k6pueUkC24HJUeRI8bIo9
        y8TZ7hML5eopD8KgeYVi+IthbQ==
X-Google-Smtp-Source: ABdhPJw+iharOgIGCo8f+kM8aplb7DCE9ZqAKiUJiB8uvj0NHfZh9j8Pu1sfz1nYj5vTwDyJ9OTvYQ==
X-Received: by 2002:a17:90b:4617:: with SMTP id ia23mr2584683pjb.120.1602736266692;
        Wed, 14 Oct 2020 21:31:06 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e4sm1244336pgg.37.2020.10.14.21.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 21:31:05 -0700 (PDT)
Date:   Thu, 15 Oct 2020 10:01:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()
Message-ID: <20201015043103.m6ghom52sqssh24z@vireshk-i7>
References: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
 <AM6PR04MB496659599D41F6B88036420680020@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB496659599D41F6B88036420680020@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-20, 02:35, Aisheng Dong wrote:
> Hi Viresh
> 
> Thanks for the quick fix.
> 
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > Sent: Wednesday, October 14, 2020 12:26 PM
> > 
> > The patch missed returning 0 early in case of success and hence the static OPPs
> > got removed by mistake. Fix it.
> > 
> > Fixes: 90d46d71cce2 ("opp: Handle multiple calls for same OPP table in
> > _of_add_opp_table_v1()")
> > Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Tested-by: Dong Aisheng <aisheng.dong@nxp.com>

Thanks.

Rafael: Please apply this one directly for 5.10-rc. Thanks.

-- 
viresh
