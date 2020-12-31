Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524752E7EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 09:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLaIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 03:24:28 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43651 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 03:24:27 -0500
Received: by mail-ej1-f47.google.com with SMTP id jx16so24583663ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 00:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kqzRY01tygJ6pUx5jGvzhBZAlXxkHVGqTADIKUw745g=;
        b=C/3dZW3CTYrHrO52HjKLyMFjlGUVw/VZ2A7TsW/Ya9M3W8fu4LGMxAG3OHW0pJzAjn
         3IU4PFM8de9OLBejwK+QBUCWsuZ5hUYWc/Y7ytVa0QoZ9EavKOgnsWMlfP0vfWyx1Stp
         Ma0kt1yFlgw74iObZqS39JL8xhdoCs2ZMTa/kCzoUnmK19QmFBK7IgR+vmte3PJKzOt3
         HKBl8nj9sNY6TpgjDcfPazQhPQrpsD+7d5pesX0ETHNdk8Kiq7EogdyJfQGHevycAJNF
         aobkMdEan4bWjB0nDGEtO5M1Ohx5jFEKj4PRHyCRH9dmej7psUBBmfwaUmHfApuytcZi
         TJhw==
X-Gm-Message-State: AOAM530j/Gpfk4PFkAwNi1XoxTmcQ6EDu6z1Jd45pFAiK0wC/CqfaPAZ
        dsXWFd8K9fzgPsJDa6P3SzU=
X-Google-Smtp-Source: ABdhPJwNEQjBFzFAAmXt5DwceBM6hUczYhbLdoXJiqblmO+Y+ji79uFvdoW0apAi0ZokZwQ5xhdjwg==
X-Received: by 2002:a17:906:fcda:: with SMTP id qx26mr52993070ejb.213.1609403025366;
        Thu, 31 Dec 2020 00:23:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b21sm38890888edr.53.2020.12.31.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 00:23:43 -0800 (PST)
Date:   Thu, 31 Dec 2020 09:23:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201231082342.GA2591@kozik-lap>
References: <20201230205139.1812366-3-timon.baetz@protonmail.com>
 <202012310753.axvdsSG1-lkp@intel.com>
 <20201231081754.09aad125.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201231081754.09aad125.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 07:19:07AM +0000, Timon Baetz wrote:
> On Thu, 31 Dec 2020 07:22:22 +0800, kernel test robot wrote:
> > Hi Timon,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on regulator/for-next]
> > [also build test ERROR on pinctrl-samsung/for-next krzk/for-next v5.11-rc1 next-20201223]
> > [cannot apply to robh/for-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Timon-Baetz/extcon-max8997-Add-CHGINS-and-CHGRM-interrupt-handling/20201231-045812
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > config: arm-randconfig-r004-20201230 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 3c0d36f977d9e012b245c796ddc8596ac3af659b)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/0day-ci/linux/commit/3a597219bbfc1f9a0b65b9662b7b95bbb7cf728f
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Timon-Baetz/extcon-max8997-Add-CHGINS-and-CHGRM-interrupt-handling/20201231-045812
> >         git checkout 3a597219bbfc1f9a0b65b9662b7b95bbb7cf728f
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]  
> >                    ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> >                          ^
> >    drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
> >    include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
> >    static inline int devm_extcon_register_notifier(struct device *dev,
> >                      ^
> >    1 error generated.
> 
> This is failing because CONFIG_EXTCON is not set and *_all() don't have
> stub implementations in extcon.h. Should I add a fix for it in this
> series?

It is not problem of your patchset, so up to you.  After your changes
the driver still can work fine without CONFIG_EXTCON and CONFIG_REGULATOR.

Best regards,
Krzysztof

