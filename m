Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86252C5B24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbgKZRzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:55:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51432 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404262AbgKZRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:55:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id a186so2875612wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+B2qpXSSe1VK6szPqxKjMyjHrtTFIco3Uktbz6wSbPc=;
        b=OU81+ld55gutQbLtgB4QF7iRmy6YPeZjNHjOd8Nic5umKTCD/xu/8Qeq7eNaxwJ0S0
         mqjudtG7yMpoAOmbwV9CQEdtdyiSICuy+K8Zp4m/zGhICNj5niU/HltYXXLFjK7RVeHH
         HrlAe2xyvqMm0wocVwXq9Wmywkt1ZabcLnRzYBOw1C6hrOyuxwLSaCG1MF7M3si8b1Mo
         vH8h1o+AXLunnAQ6hhGa4WwF0D8mod+c9Lrz9CWJHRvjiI47D6qwGuJlKjtr6aHyOahy
         9PaJ9CBRfu6bHJeszDMHMUpIMRpRfFsi3BO6XOGVcQxCh+9ngVj3QGgF5XexWWqhNZp1
         Ny6Q==
X-Gm-Message-State: AOAM531BzCvDohhjkuOr/6ml2yJB0lfi0t7jeEySS4Ru0fnD+ayzyAR+
        0735DuPrBA45tOwNJibz8Ts=
X-Google-Smtp-Source: ABdhPJxdqeeFF3GQ07Ymhm8mPAEDRus4YWpvcNVdxkP+yMCt83rXm7N2Vc2ZYGWOluYgj6uwL+WO2g==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr4446907wms.111.1606413310395;
        Thu, 26 Nov 2020 09:55:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k16sm10387010wrl.65.2020.11.26.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:55:09 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:55:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [GIT PULL 2/2] memory: tegra for v5.11
Message-ID: <20201126175507.GA17085@kozik-lap>
References: <20201125184529.5392-1-krzk@kernel.org>
 <20201125184529.5392-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125184529.5392-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:45:29PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> The Tegra memory controllers work was big enough to get its own branch and tag.
> It also includes few SoC and clock patches, which I shared externally via a
> stable tag to devfreq tree.
> 
> The work is not yet finished, so more patches from Dmitry will be coming.
> However I want to flush my queue now.

Hi Arnd and Olof,

Please ignore this pull. Only this one. The 1/2 is good.

Thierry pointed out that include/dt-bindings patches are not used by
drivers but are a requisite for DTS patches. I'll send a fixed pull
request for 2/2.

Best regards,
Krzysztof


> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.11
> 
> for you to fetch changes up to e45b57df4b9e9f8b5df7553a9a001acd9cae1b5d:
> 
>   memory: tegra30-emc: Remove unnecessary of_node_put in tegra_emc_probe (2020-11-23 17:28:48 +0100)
> 
> ----------------------------------------------------------------
> Memory controller drivers for v5.11 - Tegra SoC
> 
> There is a bigger work from Dmitry Osipenko around Tegra SoC memory
> controller drivers, mostly towards adding interconnect support and
> integration with devfreq.  This work touches all Tegra memory controller
> drivers and also few other SoC-related parts.  It's not yet finished but
> the intermediate stage seems ready to merge.
> 
> Beside that Tegra 210 memory controller got few fixes and received new
> swgroups (work of Nicolin Chen).
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (35):
>       dt-bindings: memory: tegra20: emc: Correct registers range in example
>       clk: tegra: Export Tegra20 EMC kernel symbols
>       soc/tegra: fuse: Export tegra_read_ram_code()
>       soc/tegra: fuse: Add stub for tegra_sku_info
>       dt-bindings: memory: tegra20: emc: Document nvidia, memory-controller property
>       dt-bindings: memory: tegra20: mc: Document new interconnect property
>       dt-bindings: memory: tegra20: emc: Document new interconnect property
>       dt-bindings: memory: tegra20: emc: Document OPP table and voltage regulator
>       dt-bindings: memory: tegra30: mc: Document new interconnect property
>       dt-bindings: memory: tegra30: emc: Document new interconnect property
>       dt-bindings: memory: tegra30: emc: Document OPP table and voltage regulator
>       dt-bindings: memory: tegra124: mc: Document new interconnect property
>       dt-bindings: memory: tegra124: emc: Document new interconnect property
>       dt-bindings: memory: tegra124: emc: Document OPP table and voltage regulator
>       dt-bindings: tegra30-actmon: Document OPP and interconnect properties
>       dt-bindings: host1x: Document new interconnect properties
>       dt-bindings: memory: tegra20: Add memory client IDs
>       dt-bindings: memory: tegra30: Add memory client IDs
>       dt-bindings: memory: tegra124: Add memory client IDs
>       memory: tegra: Add and use devm_tegra_memory_controller_get()
>       memory: tegra: Use devm_platform_ioremap_resource()
>       memory: tegra: Remove superfluous error messages around platform_get_irq()
>       memory: tegra: Add missing latency allowness entry for Page Table Cache
>       memory: tegra-mc: Add interconnect framework
>       memory: tegra20-emc: Make driver modular
>       memory: tegra20-emc: Continue probing if timings are missing in device-tree
>       memory: tegra20: Support interconnect framework
>       memory: tegra: Correct stub of devm_tegra_memory_controller_get()
>       memory: tegra20-emc: Use dev_pm_opp_set_clkname()
>       memory: tegra20-emc: Factor out clk initialization
>       memory: tegra20-emc: Remove IRQ number from error message
>       memory: tegra20-emc: Add devfreq support
>       memory: tegra30: Add FIFO sizes to memory clients
>       memory: tegra30-emc: Make driver modular
>       memory: tegra30-emc: Continue probing if timings are missing in device-tree
> 
> Krzysztof Kozlowski (1):
>       Merge branch 'for-v5.11/tegra-soc-clk' into HEAD
> 
> Nathan Chancellor (1):
>       memory: tegra30-emc: Remove unnecessary of_node_put in tegra_emc_probe
> 
> Nicolin Chen (5):
>       memory: tegra: Correct la.reg address of seswr
>       memory: tegra: Correct tegra210_mc_clients def values
>       memory: tegra: Sort tegra210_swgroups by reg address
>       dt-bindings: memory: tegra: Add missing swgroups
>       memory: tegra: Complete tegra210_swgroups
> 
>  .../bindings/arm/tegra/nvidia,tegra30-actmon.txt   |  25 +
>  .../display/tegra/nvidia,tegra20-host1x.txt        |  68 +++
>  .../memory-controllers/nvidia,tegra124-emc.yaml    |  19 +
>  .../memory-controllers/nvidia,tegra124-mc.yaml     |   5 +
>  .../memory-controllers/nvidia,tegra20-emc.txt      |  22 +-
>  .../memory-controllers/nvidia,tegra20-mc.txt       |   3 +
>  .../memory-controllers/nvidia,tegra30-emc.yaml     |  18 +
>  .../memory-controllers/nvidia,tegra30-mc.yaml      |   5 +
>  drivers/clk/tegra/clk-tegra20-emc.c                |   3 +
>  drivers/memory/tegra/Kconfig                       |   9 +-
>  drivers/memory/tegra/mc.c                          | 155 +++++-
>  drivers/memory/tegra/mc.h                          |  22 +
>  drivers/memory/tegra/tegra114.c                    |   6 +
>  drivers/memory/tegra/tegra124-emc.c                |  22 +-
>  drivers/memory/tegra/tegra124.c                    |   6 +
>  drivers/memory/tegra/tegra20-emc.c                 | 528 +++++++++++++++++++--
>  drivers/memory/tegra/tegra20.c                     |  77 +++
>  drivers/memory/tegra/tegra210-emc-core.c           |  39 +-
>  drivers/memory/tegra/tegra210.c                    |  60 ++-
>  drivers/memory/tegra/tegra30-emc.c                 |  73 ++-
>  drivers/memory/tegra/tegra30.c                     |  72 +++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c             |   2 +
>  include/dt-bindings/memory/tegra124-mc.h           |  68 +++
>  include/dt-bindings/memory/tegra20-mc.h            |  53 +++
>  include/dt-bindings/memory/tegra210-mc.h           |  10 +
>  include/dt-bindings/memory/tegra30-mc.h            |  67 +++
>  include/soc/tegra/fuse.h                           |   4 +
>  include/soc/tegra/mc.h                             |  27 ++
>  28 files changed, 1299 insertions(+), 169 deletions(-)
