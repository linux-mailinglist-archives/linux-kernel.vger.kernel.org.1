Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED9269C83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIODZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIODZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:25:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B5C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:25:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n18so2204327qtw.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oc5/guYnw7k9iY4UtsoouCqOHJfrixuuN4XgqAnpDAw=;
        b=EBK6TmwmXeTja7ZoVkKCptct+IK6Wfn/J0B1VMxe2Urd1ScZZjp2L7fivmgulppdt7
         DHzlbCWw3A5nE9tdWwcD1aQWWMgdSliO3LL/I8qDCTNf+CDI5Ze2jAHtBKn87bKESZ0T
         HDiPNlrVhGa+QMb8Or9Xk772U30u1CzORvqlMDhF/lHflSwfa/azh8I7HdKtIPossFm5
         h04y4gwylfboBB9vQ+z3X1715WT9HOvkdPb4QKS0nopNrQKTNb757wrBAAdlBMtikNeK
         SofqdDfZZFhG5Yh1arMfGSVCrN+ZKbsG6jrel0T9A6Dx8wPtAncldodoX99A6oZnJ1wl
         TVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oc5/guYnw7k9iY4UtsoouCqOHJfrixuuN4XgqAnpDAw=;
        b=R13qtPjcBuTcEzTai/KUmR+bHIkhLMPNvn7BHl1yDLdRmxTV66YpG5DordrFHQkIrS
         jWrGy1IuN2b+xIYvVMEd3Msci5gK5tTMj5M17HwgqBfb9PQvFOnC7QH/58alYRZUBFje
         9QmijWunfJePkVeeFV49MDWaffhuajn+FfDobPI+bTenzdE3coqaTyi6SvDL9rUSTDpd
         3YVfG4N0QOr6oZK5ZPNDTWEa3kRJWg/lxL2mRdQ/9MbNo4dhs/izaU8GxE5CL3L30zpP
         iGJfpvZS7FQSW8eplqAEndT9o7jbXSkI8C5hj09QRGoqwBswBHqAF7QtqqKh+ImnPcHY
         CGVw==
X-Gm-Message-State: AOAM532aR2GISZa5ZACGShAUAbHHSTUE6u9f3c6hVYbTjuWFThNZjLIk
        J4+FlyiHmVPAaPSip8ksrp7YVQ==
X-Google-Smtp-Source: ABdhPJxqdExRv3lW9om23plDyIy3LvdqnxWk4wvxCz7HhjRTZ8yCvn2hMJoPW+1hyolMcOhtmpve9Q==
X-Received: by 2002:ac8:3597:: with SMTP id k23mr16352397qtb.238.1600140331189;
        Mon, 14 Sep 2020 20:25:31 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id u18sm16326493qtk.61.2020.09.14.20.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:25:30 -0700 (PDT)
Date:   Tue, 15 Sep 2020 03:25:29 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH RESEND RESEND] remoteproc: scp: add COMPILE_TEST
 dependency
Message-ID: <20200915032529.GA7762@uller>
References: <20200915012911.489820-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915012911.489820-1-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Sep 01:29 UTC 2020, Alexandre Courbot wrote:

> This will improve this driver's build coverage.
> 
> Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
> Hi remoteproc maintainers,
> 
> Second resend as I got no reaction for almost 1 month on this one-liner.

Sorry about that. I fell behind on my inbox and have missed your
previous attempts.

This has now been applied.

Regards,
Bjorn

> Pretty please?
> 
> As explained in
> https://www.spinics.net/lists/linux-media/msg175991.html, we need this
> patch in order to merge a driver series in the media tree. If that
> looks ok to you, can we pull it in the media tree along with the series
> that depends on it?
> 
>  drivers/remoteproc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c6659dfea7c7..d1fcada71017 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -43,7 +43,7 @@ config INGENIC_VPU_RPROC
>  
>  config MTK_SCP
>  	tristate "Mediatek SCP support"
> -	depends on ARCH_MEDIATEK
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	select RPMSG_MTK_SCP
>  	help
>  	  Say y here to support Mediatek's System Companion Processor (SCP) via
> -- 
> 2.28.0.526.ge36021eeef-goog
> 
