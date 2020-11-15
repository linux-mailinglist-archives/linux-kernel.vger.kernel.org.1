Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B242B3369
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKOKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 05:25:04 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42466 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgKOKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:25:02 -0500
Received: by mail-wr1-f51.google.com with SMTP id l1so15439404wrb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 02:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5nG5hAw48laSwMOPRpta7Q7mPmh9NPKcHupN6vp3NPs=;
        b=oi2FCwEoWCsEe/iJHG0gh8YI/TKk1Yts5jLc5XwVC2oD6xgwvGjeVRANMjdBhZAyW5
         44Cx3+iGc+2jBS6NJk/QlWXNL68qm/NfOzfDOYPUf6cMYOhvzDCjXaHzy6s0blRX0zVo
         ZNLE+loOiLZ3t2BuvmqEsDjTOqRPCPcixIoXAG+xyZp+GvvQaNWxG1//vuT9wYOJr0oV
         mhYGCp8I0KFHKu21ZlzGKnn1jFmiiRcUfcPhrN4D4Mxu45OFqzdZvQQ6FsdVA9tJivHl
         5TsHxHegfkEx0OkG/MlwbAAXRCX/uqwzt3dPG1IniLsXZ4wR36+IleRhAVFjjXqcJprR
         Da/g==
X-Gm-Message-State: AOAM531Vdcda0VyZLxC9ZOpOVQ+xYuZT0PzpRhHht721Sd3hrpJOc4f3
        DBvQC7/hWiBFdE6RnTm+1TXANfYdAjk=
X-Google-Smtp-Source: ABdhPJxz6V4U6xkENIKDuauFQNd89/mnb3A/Drm69ySnbE1lvb6DaeYZKz1Gi5gUruvspoWAutngag==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr14311313wrr.351.1605435900647;
        Sun, 15 Nov 2020 02:25:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p10sm18462809wre.2.2020.11.15.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 02:24:59 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:24:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: pl353-smc.c:undefined reference to `amba_driver_register'
Message-ID: <20201115102458.GA4587@kozik-lap>
References: <202011150650.UyCYrjbN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202011150650.UyCYrjbN-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 06:17:53AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
> commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
> date:   3 months ago
> config: arm-randconfig-p002-20201115 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea0c0ad6b6eb36726088991d97a55b99cae456d0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ea0c0ad6b6eb36726088991d97a55b99cae456d0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: drivers/memory/pl353-smc.o: in function `pl353_smc_driver_init':
> >> pl353-smc.c:(.init.text+0x10): undefined reference to `amba_driver_register'
>    arm-linux-gnueabi-ld: drivers/memory/pl353-smc.o: in function `pl353_smc_driver_exit':
> >> pl353-smc.c:(.exit.text+0x10): undefined reference to `amba_driver_unregister'

Fix is ready:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git/commit/?h=fixes&id=275374b46da2baea437a2e9456e52a04c2049780

Best regards,
Krzysztof

