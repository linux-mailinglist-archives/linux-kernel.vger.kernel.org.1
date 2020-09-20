Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551482715F5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgITQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:35:45 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35335 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:35:44 -0400
Received: by mail-ej1-f66.google.com with SMTP id u21so14538887eja.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ItAZHqF4YnSpoMjkTZj64q8zJ6nmLYzMiqK+0Ip9lPU=;
        b=UOFOaXByfZy/wm44aeBUPQ1oJSc/f/lJdIMPpAzaDu2SjMjAXRQ/dNm0hH6jQt9loh
         e4ssNmzhPLi0MPFqv8qSlQ3jjJSxhx8z5B2gZIlbQ+aJLPLPmRoeNdg3ZkXOrVM4/b4l
         uNhTB5g/3IfDDDN0orku80/2XGaBUOProQBA/V/Gq8IWO0oX9HdbwX8T5XfUx28TM+kx
         CgzTr+Yzqif5UApU2GzYvqzTSVrF5ZSsK3q/hhIkeeiNekGg4tiVYFCrZn6O6wtx6/PQ
         zEnTTAjcgXw2lF2YBws2aLlgWLTWdrqkNojw7xe8M973bWEk7ETTrlcBMRFMdOYkWKGW
         4FWA==
X-Gm-Message-State: AOAM532vC6f2ggL9nr8VDSKq++umkj6r3RIab58RI1/EWapiIzN9Y1jr
        Gh0iNvZNdOi0d/tVI80bKvw=
X-Google-Smtp-Source: ABdhPJzklTFuJ2dgmSPYDfxLIE4m24Zajbfry0kkQFG4RDyP9bH2yPpVQTtn3aUzJYvWWuEVkF2wTw==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr48262426eja.438.1600619742641;
        Sun, 20 Sep 2020 09:35:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id bv8sm4084491ejb.3.2020.09.20.09.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Sep 2020 09:35:41 -0700 (PDT)
Date:   Sun, 20 Sep 2020 18:35:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH v2] memory: dfl-emif: add the DFL EMIF private feature
 driver
Message-ID: <20200920163538.GB10210@kozik-lap>
References: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
 <1600234622-8815-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600234622-8815-2-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:37:02PM +0800, Xu Yilun wrote:
> This driver is for the EMIF private feature implemented under FPGA
> Device Feature List (DFL) framework. It is used to expose memory
> interface status information as well as memory clearing control.
> 
> The purpose of memory clearing block is to zero out all private memory
> when FPGA is to be reprogrammed. This gives users a reliable method to
> prevent potential data leakage.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2: Adjust the position of this driver in Kconfig.
>     Improves the name of the Kconfig option.
>     Change the include dfl-bus.h to dfl.h, cause the previous patchset
>      renames the file.
>     Some minor fixes and comment improvement.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> new file mode 100644
> index 0000000..56f97dc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> @@ -0,0 +1,25 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the calibration failed on this
> +		memory interface. "1" for calibration failure, "0" for OK.
> +		Format: %u
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the initialization completed on
> +		this memory interface. "1" for initialization complete, "0"
> +		for not yet.
> +		Format: %u
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Write-only. Writing "1" to this file will zero out all memory
> +		data in this memory interface. Writing of other values is
> +		invalid.
> +		Format: %u
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 8072204..8dc819f 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -136,6 +136,15 @@ config TI_EMIF_SRAM
>  	  sequence so this driver provides several relocatable PM functions
>  	  for the SoC PM code to use.
>  
> +config FPGA_DFL_EMIF
> +	tristate "FPGA DFL EMIF Driver"
> +	depends on FPGA_DFL && HAS_IOMEM
> +	help
> +	  This driver is for the EMIF private feature implemented under
> +	  FPGA Device Feature List (DFL) framework. It is used to expose
> +	  memory interface status information as well as memory clearing
> +	  control.
> +
>  config MVEBU_DEVBUS
>  	bool "Marvell EBU Device Bus Controller"
>  	default y if PLAT_ORION
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index e71cf7b..0afbf39 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -39,3 +39,5 @@ $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
>  
>  targets += emif-asm-offsets.s
>  clean-files += ti-emif-asm-offsets.h
> +
> +obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o

It there is going to be a resend: this as well has to go next to CONFIG_TI_EMIF_SRAM.

Otherwise I will fix it up while applying.

Best regards,
Krzysztof

