Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6262C4C91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgKZBXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbgKZBXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:23:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3742C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:23:00 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so284762pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrsxVUiMkWS7JUFPKnz/uT9F+wc8O7biNC7a93Ji8g0=;
        b=qsB4jJTxnH6RtKdiSkOBmBe+J9ZbeuLn/0VYyqd+d/uVETzhyLV/RdzfGIZdT4y2uY
         ySAAEk+7Uw94zjAXZ5XAT//VXvuGrb5t4eEp1IqWuPv044UjR1y97NFSB6L91IgPw+b7
         TlYgY4a9m753segGEt9Ku9s+Uxpi9Or4x2v8kwAMRR/xOFaGN9/w4DlGeiTs0CJ+xJLx
         9A+Wg5e6u7bjVtg3vjCIztG8gI7FlD49RSTKKKaAkRmzB2vOAoKq53LLN8ar+yPSTTDP
         OFAIemeN1sQKdrKrGSUUBjjbaqXzQyOnaWkacBzm4ok/jA81Ywrd3DItjAzXjE/sPSWO
         YYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrsxVUiMkWS7JUFPKnz/uT9F+wc8O7biNC7a93Ji8g0=;
        b=RDhy4XvywSIomagf8WR+jHtH+Kh0nW/q2RE+PDCH9fNvpkE6W5/vsKafQOy2n4zZgk
         pB2WAJyKYmnrkwrEr7vsML5f2EPlv7/MIqyXNES23zGBMjrqqzrn60ziZQ/F507R0N+9
         z5+cD/MTNSIlAHNK7/BmiNL3eh1JAQy524XZybKuQfjWe6b6U9B5HKFGkH+KXlnWpUl7
         FSYlTLGxfom8oX0JRxfjG2cA+HHNkpoxx02/mfCKh1mG+xiwSQG2RnflLPF3htH2rZZH
         HXt+F+104jckudxBsbnOYb7mMapIUG5XvTI2FvwSFdBJ0O+9zZn9Jn/jQcTsa2YD0bsj
         1KLw==
X-Gm-Message-State: AOAM531O1OqCxLRpZ4qZ15asbRCScm0hhkOdAIaiajsngDVHQjenPorl
        3u29a+qySe+tBdq5UyA9pSImCw==
X-Google-Smtp-Source: ABdhPJwLk6YKJay0TMbBFmIB8Q9UvWL0YIDPzL0Ng/7a6CtwKnBFxZBfYTFcVMbvdkiuIgyOdr0gHw==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr653463pjl.93.1606353780342;
        Wed, 25 Nov 2020 17:23:00 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id h20sm2723924pgv.23.2020.11.25.17.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2020 17:22:59 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:22:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Adding help for coresight subsystem
Message-ID: <20201126012256.GA31690@leoy-ThinkPad-X240s>
References: <20201125223519.734388-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125223519.734388-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:35:19PM -0700, Mathieu Poirier wrote:
> With the steady stream of new features coming into the subsystem
> it has been clear for some time now that help is needed.
> 
> Suzuki and Leo have worked extensively on various parts of the
> project and have agreed to help.
> 
> While at it add the new location for the coresight git tree.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..8d0b008c7781 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1723,11 +1723,13 @@ F:	arch/arm/mach-ep93xx/micro9.c
>  
>  ARM/CORESIGHT FRAMEWORK AND DRIVERS
>  M:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -R:	Suzuki K Poulose <suzuki.poulose@arm.com>
> +M:	Suzuki K Poulose <suzuki.poulose@arm.com>
>  R:	Mike Leach <mike.leach@linaro.org>
> +R:	Leo Yan <leo.yan@linaro.org>

Acked-by: Leo Yan <leo.yan@linaro.org>

>  L:	coresight@lists.linaro.org (moderated for non-subscribers)
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>  F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>  F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>  F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
> -- 
> 2.25.1
> 
