Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249302F7F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbhAOPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:31:55 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:16662 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhAOPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:31:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610724696; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=q0/ru+LfZr7L2kRVGdNGG4rvKSg/SVssCMScCzWIjSY=; b=XhaqXFFxODqPbfOPI2SSM1JenG9zQUi+BuZAm0G2IphZ5laI01i21yrnxX9Ig8ol0XxEX+fs
 mE6FDLvtl63rzYAx+o7iZEoMvNqm7r49dHEu88Bmhih3kHQUXHRWhwKmNojpolQdr0hxejQI
 BVy39BQmyUpU9b8Zm4gxMlXxGaQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 6001b524e23dedcc3a07a747 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 15:30:44
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34457C43463; Fri, 15 Jan 2021 15:30:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B562C433C6;
        Fri, 15 Jan 2021 15:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B562C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Robert Richter'" <rric@kernel.org>
Cc:     "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Arnd Bergmann'" <arnd@kernel.org>, <oprofile-list@lists.sf.net>,
        "'William Cohen'" <wcohen@redhat.com>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>,
        <anmar.oueja@linaro.org>,
        "'Christoph Hellwig'" <hch@infradead.org>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org> <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
In-Reply-To: <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
Subject: RE: [PATCH 04/18] arch: hexagon: Don't select HAVE_OPROFILE
Date:   Fri, 15 Jan 2021 09:30:41 -0600
Message-ID: <003a01d6eb53$63313330$29939990$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQED93X9Awx87JGfByaHSF5A6x5muQJxd0TPq7sr7rA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Thursday, January 14, 2021 5:35 AM
...
> The "oprofile" user-space tools don't use the kernel OPROFILE support any
> more, and haven't in a long time. User-space has been converted to the
perf
> interfaces.
> 
> Don't select HAVE_OPROFILE for hexagon anymore.

Acked-by: Brian Cain <bcain@codeaurora.org>

> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/hexagon/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig index
> 6e00c16a36b5..44a409967af1 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -7,7 +7,6 @@ config HEXAGON
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_NO_PREEMPT
> -	select HAVE_OPROFILE
>  	# Other pending projects/to-do items.
>  	# select HAVE_REGS_AND_STACK_ACCESS_API
>  	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
> --
> 2.25.0.rc1.19.g042ed3e048af


