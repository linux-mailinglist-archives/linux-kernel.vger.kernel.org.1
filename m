Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33CF2F7F96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbhAOPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:30:45 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:11028 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbhAOPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:30:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610724622; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=oA7RZAvzLPHcI3sWTvYYs4e/HB09ZcFYEQzi+A912XA=; b=af75JqwqPPiMwAicGL3WfI3S9KIIdDLJCYhoVtXyCRRafZ/8VFTWhK7Hs5VQIZsWxwYZsgwc
 yzjgvUwq+UK6QrsA0F2iQS0wuWS/SpPLMcsuULoutNNRXH02fAvC8Vs0M9OM4jBc6Oq+R4NO
 AoFdloLrh3EdKc4TweToApsBGYc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 6001b4ef8a0374a501421fcd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 15:29:51
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 599CCC43462; Fri, 15 Jan 2021 15:29:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6AB7C43462;
        Fri, 15 Jan 2021 15:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6AB7C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Randy Dunlap'" <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Kees Cook'" <keescook@chromium.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-hexagon@vger.kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
References: <20210115010011.29483-1-rdunlap@infradead.org>
In-Reply-To: <20210115010011.29483-1-rdunlap@infradead.org>
Subject: RE: [PATCH] hexagon: remove CONFIG_EXPERIMENTAL from defconfigs
Date:   Fri, 15 Jan 2021 09:29:47 -0600
Message-ID: <003801d6eb53$430a26c0$c91e7440$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIyeV2d5xht9mJ0Keo/ISy99GtKZKlxszdQ
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> Since CONFIG_EXPERIMENTAL was removed in 2013, go ahead and drop it
> from any defconfig files.

Acked-by: Brian Cain <bcain@codeaurora.org>

> Fixes: 3d374d09f16f ("final removal of CONFIG_EXPERIMENTAL")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/hexagon/configs/comet_defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20210114.orig/arch/hexagon/configs/comet_defconfig
> +++ linux-next-20210114/arch/hexagon/configs/comet_defconfig
> @@ -1,7 +1,6 @@
>  CONFIG_SMP=y
>  CONFIG_DEFAULT_MMAP_MIN_ADDR=0
>  CONFIG_HZ_100=y
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_CROSS_COMPILE="hexagon-"
>  CONFIG_LOCALVERSION="-smp"
>  # CONFIG_LOCALVERSION_AUTO is not set

