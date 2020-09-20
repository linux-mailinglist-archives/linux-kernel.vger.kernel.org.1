Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFB271613
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgITQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:56:22 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46538 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:56:22 -0400
Received: by mail-ej1-f65.google.com with SMTP id z23so14462247ejr.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLnZSoQCnv1sWJoNFW+CrgDT9gtSC1UEAVXzcDB6xLI=;
        b=RNxLZwED8QyaC5MavXM9PfImZoI9HDJBywSqIoIRKyJ5KxUR0snNS+M4wrPflEzQKP
         9EygaMOSQ4A7dsdWDOA6YGgLTTAAyCxr2yps3buuLPl1gX7yzSMVnNUT6yTWAeoTyUE6
         m8A1MD+EpckQ4SkWnZBJGMVpagLGez09oaFxA52iF0Ox+QHu44ruM3zWMGhw/L8mTp3l
         Li3WJ5a8rRFxGAQVr+cdWLz2DcQZZ3+HKEjFZv2v6s8H/1Z/sZCAXLir/fp8/85Gwdiz
         kXodSjTuKS/PKNeCKirt9cwjWx4CiTz1FfpNIsO+Ghh/rSAmbZcaMM4T9qxlSTXSUzkB
         I6Nw==
X-Gm-Message-State: AOAM532QDstVQTwYONvwtEcX3WA5XjY1bzIl3c0oeUU7gSqllpjhG6iT
        t4/LGCy4aWKArMYMSR4M9L0=
X-Google-Smtp-Source: ABdhPJz4y7rryGGZdnMwF0KoJED3lL2lbbUql2rxJDbxivqpFO9QI++yi0z6+ESAuiDW8XONWqEk7A==
X-Received: by 2002:a17:906:7013:: with SMTP id n19mr45736460ejj.388.1600620980413;
        Sun, 20 Sep 2020 09:56:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id re19sm6877734ejb.86.2020.09.20.09.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Sep 2020 09:56:19 -0700 (PDT)
Date:   Sun, 20 Sep 2020 18:56:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH v2] memory: dfl-emif: add the DFL EMIF private feature
 driver
Message-ID: <20200920165617.GA16184@kozik-lap>
References: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
 <1600234622-8815-2-git-send-email-yilun.xu@intel.com>
 <20200920163538.GB10210@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920163538.GB10210@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 06:35:38PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 16, 2020 at 01:37:02PM +0800, Xu Yilun wrote:
> > This driver is for the EMIF private feature implemented under FPGA
> > Device Feature List (DFL) framework. It is used to expose memory
> > interface status information as well as memory clearing control.
> > 
> > The purpose of memory clearing block is to zero out all private memory
> > when FPGA is to be reprogrammed. This gives users a reliable method to
> > prevent potential data leakage.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> > v2: Adjust the position of this driver in Kconfig.
> >     Improves the name of the Kconfig option.
> >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> >      renames the file.
> >     Some minor fixes and comment improvement.
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> >  drivers/memory/Kconfig                             |   9 +
> >  drivers/memory/Makefile                            |   2 +
> >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> >  create mode 100644 drivers/memory/dfl-emif.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > new file mode 100644
> > index 0000000..56f97dc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > @@ -0,0 +1,25 @@
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It indicates if the calibration failed on this
> > +		memory interface. "1" for calibration failure, "0" for OK.
> > +		Format: %u
> > +
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It indicates if the initialization completed on
> > +		this memory interface. "1" for initialization complete, "0"
> > +		for not yet.
> > +		Format: %u
> > +
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Write-only. Writing "1" to this file will zero out all memory
> > +		data in this memory interface. Writing of other values is
> > +		invalid.
> > +		Format: %u
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index 8072204..8dc819f 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -136,6 +136,15 @@ config TI_EMIF_SRAM
> >  	  sequence so this driver provides several relocatable PM functions
> >  	  for the SoC PM code to use.
> >  
> > +config FPGA_DFL_EMIF
> > +	tristate "FPGA DFL EMIF Driver"
> > +	depends on FPGA_DFL && HAS_IOMEM
> > +	help
> > +	  This driver is for the EMIF private feature implemented under
> > +	  FPGA Device Feature List (DFL) framework. It is used to expose
> > +	  memory interface status information as well as memory clearing
> > +	  control.
> > +
> >  config MVEBU_DEVBUS
> >  	bool "Marvell EBU Device Bus Controller"
> >  	default y if PLAT_ORION
> > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> > index e71cf7b..0afbf39 100644
> > --- a/drivers/memory/Makefile
> > +++ b/drivers/memory/Makefile
> > @@ -39,3 +39,5 @@ $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
> >  
> >  targets += emif-asm-offsets.s
> >  clean-files += ti-emif-asm-offsets.h
> > +
> > +obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
> 
> It there is going to be a resend: this as well has to go next to CONFIG_TI_EMIF_SRAM.
> 
> Otherwise I will fix it up while applying.

This patch depends on latest fpga/dfl changes which I see are mixed with
other changes on FPGA drivers tree so they cannot be provided
independently from others as a stable tag.  Unless Moritz can rebase his
tree and put them on separate branch.

Your "Modularization of DFL private feature drivers" should be sent
along with this here, so all the maintainers see the dependencies and
they can apply things for cross-merging at the beginning of the process.

Therefore please send a v3 of this patch with the fix above and let's
apply it via Moritz's tree.

Best regards,
Krzysztof

