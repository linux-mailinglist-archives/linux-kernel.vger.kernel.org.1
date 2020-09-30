Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F328A27F39B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgI3Uww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Uwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:52:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D6C061755;
        Wed, 30 Sep 2020 13:52:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so3195965oif.13;
        Wed, 30 Sep 2020 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nYY0TFDmxyVWyJBUckQyfQlvGWR4n04F0Nkv0zc7eVg=;
        b=ILXpOZKBIzWSP+0zFt5yGa7wpW89MxCBJgHKX4ZvGrg9mlkiGGalDgi8t9yWawzYdc
         9WWlWBYaGhf9/3RQsDEfkD7G5fXXd1W2Axj4iCBovnNbUtzJm/htl/L5qXudnnDtkDdA
         +Y9idv6QrKc99So8SXcZl7po5e3X1g8wY8zCi+jZ8K+1WC4k/euXiamBQTjsG9bxL23f
         XIM3xgg7+wnB7Yz3y6ikSP/2J4lhD0JhVUeo8ucxYuHnj+Yd3Lv5uogMXCnBlkBzei6R
         cGqGdkroxlLeICGK8b8QNKSDOg84J9XLHREGm5zsUDF4FJtdlhrRa9uxdeW6b8by77Qo
         rQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nYY0TFDmxyVWyJBUckQyfQlvGWR4n04F0Nkv0zc7eVg=;
        b=mekKS9M0mkh8k7pxgItau02FHBwT2nZoocJZPeENJWWqDkCbJBn+516+7gC8aav6xD
         GfLQCctkg2tiYS1Mbh9NSLTMvhsj+BY236FhJaVWvrBSf/Qns8WmZiOhaSGZaEVucUUO
         2mLnN/c9OZJifEdyR3vfm50Vwjsj4w0x9OzEs8q9vpE27sX60IIGftP6EK045/fX1CPg
         CZjTOmMWeCMZQbNjsylnGeqDRTizPeVwAL9jpW/8LPFBRFJruML95Y29tQMtYTz/TNsd
         AcrvuFOS760ZJLOXIn00NuUzp6C2qIGyPFNrcEtJBNev5TVnHW7RX4d/rF7C1x5OA9Ad
         7+sA==
X-Gm-Message-State: AOAM533DKp6zfQF1FN8nvLNtAn5ei9KhC0iIqI5yQ1+PvXL99KaPp7EK
        KiI6XI6VSWmkxKMvK2qE58o=
X-Google-Smtp-Source: ABdhPJzR6kME7SQeBZ3yxFfEaWo1jp5AaxRoFulozfb5gLrOrzKlDugVr9YnTvqkiHy7PdJOHrelIQ==
X-Received: by 2002:a05:6808:a05:: with SMTP id n5mr2498022oij.154.1601499171063;
        Wed, 30 Sep 2020 13:52:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c19sm684125ooq.35.2020.09.30.13.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 13:52:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Sep 2020 13:52:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [PATCH v3 0/2] add Intel MAX 10 BMC MFD driver & hwmon sub driver
Message-ID: <20200930205249.GA241905@roeck-us.net>
References: <1600669071-26235-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600669071-26235-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:17:49PM +0800, Xu Yilun wrote:
> I recently realized that maintainers may have trouble to apply patches to
> their trees if the patches depend on other being-reviewed patches. So I'm
> trying to wrapper the 2 patches into one patchset and let all the
> maintainers see the dependencies.
> 
> But the patch version is then not aligned between the 2 patches. I'm not
> sure how to handle it. I just picked the smaller number on Subject, but
> you could still see their own version changes in commit message of each
> patch. Sorry if it makes confusing.
> 

If you started with separate patches, it would be much better to pick
the larger number, and add a note into the individual patch(es) stating
the reason for the gap. Everything else is highly confusing. I would not
be surprised if no one in the mfd world even looks at the mfd patch
since it went back from v6 (?) to v3 according to its subject line.

Thanks,
Guenter

> 
> Patch #1 implements the basic functions of the BMC chip for some Intel
> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> Intel MAX 10 CPLD.
> 
> This BMC chip is connected to the FPGA by a SPI bus. To provide direct
> register access from the FPGA, the "SPI slave to Avalon Master Bridge"
> (spi-avmm) IP is integrated in the chip. It converts encoded streams of
> bytes from the host to the internal register read/write on the Avalon
> bus. So This driver uses the regmap-spi-avmm for register accessing.
> 
> Patch #2 adds support for the hwmon sub device in Intel MAX 10 BMC
> 
> 
> Xu Yilun (2):
>   mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support for Intel FPGA
>     PAC
>   hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC
> 
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
>  Documentation/hwmon/index.rst                      |   1 +
>  Documentation/hwmon/intel-m10-bmc-hwmon.rst        |  78 +++++
>  drivers/hwmon/Kconfig                              |  11 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/intel-m10-bmc-hwmon.c                | 334 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  13 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/intel-m10-bmc.c                        | 164 ++++++++++
>  include/linux/mfd/intel-m10-bmc.h                  |  65 ++++
>  10 files changed, 684 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
>  create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> 
> -- 
> 2.7.4
> 
