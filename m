Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9A29B851
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1800019AbgJ0Pei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:34:38 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55462 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1798627AbgJ0P3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:29:20 -0400
Received: by mail-pj1-f67.google.com with SMTP id c17so955645pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hd4Zwt5PXEpm6eViTnwTXykQMYZvM5v1ZFeuSjbWmlo=;
        b=r3Ksl1qIwMG+hbonTokXizEkSvoUg0aAsvKshEMkVICu/XgCyttqAioj27YhGWH9Lx
         7SJ1VFw0ymqQk2R+KxJe9t0a6/XJJxDjdZN5ZlQaKSwGg4oS8T2ZZ8D9/Vn9K/uLlYgV
         mZzkKXhA8jWQ+d6g05vQ489N1yHLc/QzwX8gTeYY1Ewk/mcKoLbTccPADbFLmS8Ul5nu
         k1wmtF0mUwYq2WsCmB3DPMpvVMycXICs2hPXCnItZ9OcY277GEsbxPXCXiFdXENDqIA7
         VMx1xAXRNb427y94rlojosfbVHwiOuWF/qPef8pjsJfknUW0e3+fpCxfa6evQQzrSez1
         9SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hd4Zwt5PXEpm6eViTnwTXykQMYZvM5v1ZFeuSjbWmlo=;
        b=Rt7wNt6xi/m1HckEFmgzarN8mPNMyySioMF3Cz8L30KyYv5bwN4lJchfm0t/beBQU4
         R+f3F7UwQvJXBq/FbF9B232FE7Z/e5ARk83ECdL3l+g5OcmGcwfWkHMTFnKsIDXFOB9Z
         Gt37JhVY17rykTN1BTT8evo6yyttFjOo5yIHQ3yMBIofFYI3j248LazFqJBHZQxMPihL
         WKzVCLKYo6l0WzMIDtjDNcaZ9eA3RdkEdNgZc3AYg/7XnUmMmVcl3+LSlWZedU7PcDIm
         7qqH+wdqaO+6/y0m3GmjVU6AVAqEld5uQzuUJjH8FPewYNUYelwle02kX3cxKFzb+WZn
         m5Jw==
X-Gm-Message-State: AOAM530o3bH5V9DmeKXFzRBnm2uU2DYKFuGcnPNFQu2KB9TKg/FOtxun
        FPMTyQyWXsRJZAV5wfs2tT7cFQ==
X-Google-Smtp-Source: ABdhPJzwuUI1cCRF/gQN5sAx2r+SnZ9ayE8CJn/C6zLLTe8t3eJuCNynosZc6XYwADNYjMcZG4zWUg==
X-Received: by 2002:a17:902:860b:b029:d3:c430:7eb9 with SMTP id f11-20020a170902860bb02900d3c4307eb9mr3034654plo.9.1603812559103;
        Tue, 27 Oct 2020 08:29:19 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id mp13sm2400614pjb.36.2020.10.27.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 08:29:17 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:29:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     balbi@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwtracing: coresight: add missing MODULE_LICENSE()
Message-ID: <20201027152915.GA955990@xps15>
References: <20201027085157.1964906-1-balbi@kernel.org>
 <20201027085157.1964906-2-balbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027085157.1964906-2-balbi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Tue, Oct 27, 2020 at 10:51:56AM +0200, balbi@kernel.org wrote:
> From: Felipe Balbi <balbi@kernel.org>
> 
> Fix the following build warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/hwtracing/coresight/coresight.o
> 

Arnd already sent a patch about this[1] yesterday.

Thanks,
Mathieu

[1]. https://lists.linaro.org/pipermail/coresight/2020-October/005041.html

> Signed-off-by: Felipe Balbi <balbi@kernel.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6994c1309b2b..7936fca8436c 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1692,3 +1692,4 @@ module_exit(coresight_exit);
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
>  MODULE_DESCRIPTION("Arm CoreSight tracer driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.29.1
> 
