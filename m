Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3626BA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgIPDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:00:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B3C06174A;
        Tue, 15 Sep 2020 20:00:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id y6so6420282oie.5;
        Tue, 15 Sep 2020 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3jKuXD/7ZqoYBirZoVU1mMyrFihhhsei3EtDXsEQKs=;
        b=p9sHU3/8KPrt/048jU3xkIpGE8LIB0Pu6BKQmGZnLl7PJvy4l43FGehPy5/m4mUk7A
         rZ4bbTYxve/bVEoNe+VkZKXWdPuHAmu0G/CeYawwpUDMZybFGXMkpNMJ2iMHGcDbP0Ji
         t6HYqasYUZhTOjVW61uvW4Mci5F3xKh7ardb7s4NQqejNpfzOvDi9mDXd3m7+ZZRZljH
         XEikgAuEJo06k09/PtUolVFl+f/xR0HfpIg77yi51LosB1GVfLNV7raQq+OQK4h/GyPF
         3uwazDLhdFsrFS78Yh75X3QwMcwkUWw8KHL9C6O04OKx0KfBX1WiUhdZwVAgVQqqN9rG
         Ebuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3jKuXD/7ZqoYBirZoVU1mMyrFihhhsei3EtDXsEQKs=;
        b=XbvWdv3i0TZXHvkzCFI1kaAPHSSN6xijA6mmPBI70wtIfo4uSNmrmyl89F76dq3fsf
         hrMwGdbzW3lWdzvWqToR9mGVhqBXovpGCv1Zcf6ikHX/ZdBPqZZW8X0GkC3SVG1BI26+
         saIZ4eYHnHG89Aaup+o0wZC+NfEU3fX04ovnT29qJz8LVX4V5eFJ40yHtH9SpLPTjZpO
         SfZ6jtP1bABLyesDYxfdNg/bJgog3zyOTtOpK/UDDspsV/A6qO8kBlSc5zX8sdi7HEYm
         2hT8YY6M+UNV+ouuiRdqlGPWvEwrZujqu0BobxP2fAD8bpr74wBGUhdZ/KptMO0tMMXH
         r/Gg==
X-Gm-Message-State: AOAM532iZmZKJHDgPBBXvN69zbFh6yV2dY2f9FmD3zZF5OZmK7ToZjOc
        69/Z4OeVN29gxGj6NgE4ufU=
X-Google-Smtp-Source: ABdhPJzL94NqlpctCSTmWNE+N9w5baXAuXClFSztNKJuJ4HyMtDD3IXxpqFO3XjmevnBvxItEOh55w==
X-Received: by 2002:aca:3b82:: with SMTP id i124mr1601000oia.155.1600225223678;
        Tue, 15 Sep 2020 20:00:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 91sm2733054ott.55.2020.09.15.20.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 20:00:22 -0700 (PDT)
Date:   Tue, 15 Sep 2020 20:00:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     jdelvare@suse.com, clemens@ladisch.de, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: (k10temp) Add support for Zen3 CPUs
Message-ID: <20200916030021.GA249710@roeck-us.net>
References: <20200914200715.1997757-1-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914200715.1997757-1-wei.huang2@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:07:15PM -0500, Wei Huang wrote:
> Zen3 thermal info is supported via a new PCI device ID. Also the voltage
> telemetry registers and the current factors need to be defined. k10temp
> driver then searches for CPU family 0x19 and configures k10temp_data
> accordingly.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 49e8ebf8da32..a250481b5a97 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -95,6 +95,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
>  #define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
>  
> +/* F19h thermal registers through SMN */
> +#define F19H_M01_SVI_TEL_PLANE0			(ZEN_SVI_BASE + 0x14)
> +#define F19H_M01_SVI_TEL_PLANE1			(ZEN_SVI_BASE + 0x10)
> +
> +#define F19H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> +#define F19H_M01H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
> +
>  struct k10temp_data {
>  	struct pci_dev *pdev;
>  	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> @@ -527,6 +534,22 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
>  		}
> +	} else if (boot_cpu_data.x86 == 0x19) {
> +		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
> +		data->read_tempreg = read_tempreg_nb_zen;
> +		data->show_temp |= BIT(TDIE_BIT);
> +		data->is_zen = true;
> +
> +		switch (boot_cpu_data.x86_model) {
> +		case 0x0 ... 0x1:	/* Zen3 */
> +			data->show_current = true;
> +			data->svi_addr[0] = F19H_M01_SVI_TEL_PLANE0;
> +			data->svi_addr[1] = F19H_M01_SVI_TEL_PLANE1;
> +			data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
> +			data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
> +			k10temp_get_ccd_support(pdev, data, 8);
> +			break;
> +		}
>  	} else {
>  		data->read_htcreg = read_htcreg_pci;
>  		data->read_tempreg = read_tempreg_pci;
> @@ -564,6 +587,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
>  };
