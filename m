Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EEA2B4B83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgKPQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:43:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgKPQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:43:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id w24so24198829wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CU/ArYgUmsV0IxBE5kQnWgLCbAVJFNGDcMQi4/XhurY=;
        b=sxoWw4yBR2oepvthbsA2yPqEfv0UroDJf96Z0ti2KLdN39oJHirtMGOoTlbGLsfQIO
         Up1uYA/+Roxwwgs9/e+BqPuCQ53pBe2r9pRZmZd1X2BpgYYLYmfN5PfR3h3eEO/Fbins
         kD23bsZvmyCmyerbO55qV7mLQEVvN1adideB3EGawHcq/wzvZY5LpJ59eZ9KJ1ArbxZS
         DdaKnbLMqt9J/WVESZB4B6Jhwrx1ERnNGm3x5TdodQ/hI5pmUuBeHPpC+me6wxF1luYS
         d0I1tpQfvKbIKntJ+ME3J+z/YGRMVJPdpg+U3NjHXz/eXLM3QY9j/b6NTzlKNyXys7wM
         9SMQ==
X-Gm-Message-State: AOAM530vQI1gz2Ul1HehDfpanHLSTdnm+GJH+iGT6KyFHRmT49VgUOiN
        wJ0+u4NIhjrsK0IhYJy129Y=
X-Google-Smtp-Source: ABdhPJwrytIY7dl2WyWJYJvj3sS0LfOC+VxR1BPCIAPEeDaBU+31icV0iu6ZfGFAJWOtzdtMFDXIMg==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr15502690wmm.146.1605545033868;
        Mon, 16 Nov 2020 08:43:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y187sm20730377wmg.33.2020.11.16.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:43:52 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:43:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument
 3 to %08lx specifier is cast from pointer
Message-ID: <20201116164351.GA44776@kozik-lap>
References: <20201116092236.GT29398@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116092236.GT29398@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:22:36PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
> commit: 54d8454436a205682bd89d66d8d9eedbc8452d15 mmc: host: Enable compile testing of multiple drivers
> config: arm64-randconfig-m031-20201113 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument 3 to %08lx specifier is cast from pointer
> 
> vim +177 drivers/mmc/host/tmio_mmc.c
> 
> 94b110aff8679b1 Kuninori Morimoto     2015-01-13  170  
> de501af98dfab9c Ian Molton            2015-04-27  171  	ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq,
> de501af98dfab9c Ian Molton            2015-04-27  172  			       IRQF_TRIGGER_FALLING,
> d9618e9f1a057ef Yong Zhang            2011-09-22  173  			       dev_name(&pdev->dev), host);
> 8e7bfdb37ac001c Magnus Damm           2011-05-06  174  	if (ret)
> 8e7bfdb37ac001c Magnus Damm           2011-05-06  175  		goto host_remove;
> 8e7bfdb37ac001c Magnus Damm           2011-05-06  176  
> 311f3ac76826bfd Guennadi Liakhovetski 2010-05-19 @177  	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
>                                                                        ^^^^^^^
> These are supposed to be %p so that the kernel can hide them and avoid
> showing kernel pointers to user space.

Thanks, I sent a patch.

Best regards,
Krzysztof

