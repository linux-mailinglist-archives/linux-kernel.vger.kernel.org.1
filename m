Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F852B353D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKOOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 09:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgKOOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 09:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605450009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJ2kvYZyE5IOMCZSoWE+72vYl/hoRsDWa0U4B8OFKPI=;
        b=P1jZze1+nAe8l57Yy4S4v09P45BH00biduEHucytrUifrQ9IXfoSZW8+xDI57bjx9hCrbv
        FkXiKp5CQ0lfgvGifdI0W4yscrA60vmXNWJ70379rmYrm8qIUjKt1CZ47hEJgAbUrzI9Pd
        Kop5ftggB/hNclk/7uPUdvqKWSkygwA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-8ZcFddwCM56EPXk622F2cQ-1; Sun, 15 Nov 2020 09:20:08 -0500
X-MC-Unique: 8ZcFddwCM56EPXk622F2cQ-1
Received: by mail-qk1-f199.google.com with SMTP id 141so9833033qkh.18
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 06:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SJ2kvYZyE5IOMCZSoWE+72vYl/hoRsDWa0U4B8OFKPI=;
        b=MSQGH1Vg0QDBEfOZA06okGrbH+m1utT5NMWMHWzS1HI2K7Tuelc5t0N0GEpW3Y46qT
         scI6TMD1uxPGvNCpJ3uCxwOkUW1NX4XMqMLzL5djn+xQdFepGgQ9iT9zfDugA1bEh8+4
         pdLWFktyDpb0COCfBAP6kQsvSPOTzeiFrmcV3e5fZSl6Oh4yz1qVE4OmO4m5CT2tzPGn
         aPWDbG4BDjaxIbsPD7WkDrrHfLmYssaV5U+npki35EWL7xF77RquhE387TTI+ezCSryw
         2IhJ9HL7Z0hYMXPnxf+hL31hNDwi3ebzJiiASgnOnvh6RimTozpRdYb69V7kswcB6mgh
         4VHw==
X-Gm-Message-State: AOAM532BcnGtSr+7xFYMYiENu2Rm/TcDoXN02R4GUv9qRhqfbaUktmrR
        se2D55dV/RbMm6s+6DgjQ7FhxTWzOkWRnwGKJMvwKzmFTiPRJolw4HM31/PvP+HgkXp1O4/iihl
        V9waHI95Lzp9QlSY/Nx59fOB2
X-Received: by 2002:ac8:3499:: with SMTP id w25mr10288184qtb.44.1605450007806;
        Sun, 15 Nov 2020 06:20:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqT9ItJQzz795HHInEy+xtQBXktFz48KBXVYW+nxoyelZNHXdkv/LDG57jqnkN2t5OPG2EIw==
X-Received: by 2002:ac8:3499:: with SMTP id w25mr10288166qtb.44.1605450007617;
        Sun, 15 Nov 2020 06:20:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k15sm10447136qke.75.2020.11.15.06.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 06:20:06 -0800 (PST)
Subject: Re: [PATCH v5 6/6] fpga: m10bmc-sec: add max10 get_hw_errinfo
 callback func
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-7-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d0e4819b-87b8-ef6f-9ede-adc28e10b2f8@redhat.com>
Date:   Sun, 15 Nov 2020 06:20:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114005559.90860-7-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/20 4:55 PM, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to include
> a function that returns 64 bits of additional HW specific
> data for errors that require additional information.
> This callback function enables the hw_errinfo sysfs
> node in the Intel Security Manager class driver.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v5:
>   - No change
> v4:
>   - No change
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
> v2:
>   - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
>     ensure that corresponding bits are set to 1 if we are unable
>     to read the doorbell or auth_result registers.
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 4fa8a2256088..a024efb173d3 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -472,11 +472,36 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
>  	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
>  }
>  
> +#define HW_ERRINFO_POISON	GENMASK(31, 0)
> +static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	u32 doorbell, auth_result;

If doorbell and auth_result were poisoned at initialization, the if-checks could be skipped.

Tom

> +
> +	switch (smgr->err_code) {
> +	case FPGA_SEC_ERR_HW_ERROR:
> +	case FPGA_SEC_ERR_TIMEOUT:
> +	case FPGA_SEC_ERR_BUSY:
> +	case FPGA_SEC_ERR_WEAROUT:
> +		if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
> +			doorbell = HW_ERRINFO_POISON;
> +
> +		if (m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
> +				    &auth_result))
> +			auth_result = HW_ERRINFO_POISON;
> +
> +		return (u64)doorbell << 32 | (u64)auth_result;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static const struct fpga_sec_mgr_ops m10bmc_sops = {
>  	.prepare = m10bmc_sec_prepare,
>  	.write_blk = m10bmc_sec_write_blk,
>  	.poll_complete = m10bmc_sec_poll_complete,
>  	.cancel = m10bmc_sec_cancel,
> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
>  };
>  
>  static int m10bmc_secure_probe(struct platform_device *pdev)

