Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA126C946
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgIPTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgIPRpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2991B21D7D;
        Wed, 16 Sep 2020 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600255979;
        bh=NrN65FExOcUCU520Iq+usyuxFbZLtc2nG2HuzYo+/Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKy38OSed/DKr+wyau8wsgBMcKVVfD6ZZYBTUCn0W5pyOjW/hXhxzJThMFuXngdtX
         cpS/OEj8cv6p4b3xGA3JHsc4V/uSTCDugqMgyjgZPBJSOLktovCGJCEZ2BSUPlID1X
         njdNx2JNLYBA5TJqxi89LYGeoAsV9G5y7GnNXLVM=
Date:   Wed, 16 Sep 2020 13:33:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com
Subject: Re: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
Message-ID: <20200916113334.GB1124534@kroah.com>
References: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 05:20:02PM -0700, Amit Sunil Dhamne wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> Validate IOCTL ID for ZynqMP and Versal before calling
> zynqmp_pm_invoke_fn().
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 117 +++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 8d1ff24..8fe0912 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -514,6 +514,89 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
> 
>  /**
> + * versal_is_valid_ioctl() - Check whether IOCTL ID is valid or not for versal
> + * @ioctl_id:  IOCTL ID
> + *
> + * Return: 1 if IOCTL is valid else 0
> + */
> +static inline int versal_is_valid_ioctl(u32 ioctl_id)
> +{
> +       switch (ioctl_id) {
> +       case IOCTL_SD_DLL_RESET:
> +       case IOCTL_SET_SD_TAPDELAY:
> +       case IOCTL_SET_PLL_FRAC_MODE:
> +       case IOCTL_GET_PLL_FRAC_MODE:
> +       case IOCTL_SET_PLL_FRAC_DATA:
> +       case IOCTL_GET_PLL_FRAC_DATA:
> +       case IOCTL_WRITE_GGS:
> +       case IOCTL_READ_GGS:
> +       case IOCTL_WRITE_PGGS:
> +       case IOCTL_READ_PGGS:
> +       case IOCTL_SET_BOOT_HEALTH_STATUS:
> +               return 1;
> +       default:
> +               return 0;

bool is nicer, right?

> +       }
> +}
> +
> +/**
> + * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
> + * @ioctl_id:  IOCTL ID
> + *
> + * Return: 1 if IOCTL is valid else 0
> + */
> +static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
> +{
> +       switch (ioctl_id) {
> +       case IOCTL_SD_DLL_RESET:
> +       case IOCTL_SET_SD_TAPDELAY:
> +       case IOCTL_SET_PLL_FRAC_MODE:
> +       case IOCTL_GET_PLL_FRAC_MODE:
> +       case IOCTL_SET_PLL_FRAC_DATA:
> +       case IOCTL_GET_PLL_FRAC_DATA:
> +       case IOCTL_WRITE_GGS:
> +       case IOCTL_READ_GGS:
> +       case IOCTL_WRITE_PGGS:
> +       case IOCTL_READ_PGGS:
> +       case IOCTL_SET_BOOT_HEALTH_STATUS:
> +               return 1;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +/**
> + * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
> + * @node_id:   Node ID of the device
> + * @ioctl_id:  ID of the requested IOCTL
> + * @arg1:      Argument 1 to requested IOCTL call
> + * @arg2:      Argument 2 to requested IOCTL call
> + * @out:       Returned output value
> + *
> + * This function calls IOCTL to firmware for device control and configuration.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> +                          u32 *out)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> +       if (np) {
> +               if (!versal_is_valid_ioctl(ioctl_id))
> +                       return -EINVAL;

Wrong error value.

> +       } else {
> +               if (!zynqmp_is_valid_ioctl(ioctl_id))
> +                       return -EINVAL;

Wrong error value.

> +       }
> +       of_node_put(np);
> +
> +       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id, arg1, arg2,
> +                                  out);

No other checking of ioctl commands and arguments?  Brave...

> +}
> +
> +/**
>   * zynqmp_pm_set_pll_frac_mode() - PM API for set PLL mode
>   *
>   * @clk_id:    PLL clock ID
> @@ -525,8 +608,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
>   */
>  int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
> -                                  clk_id, mode, NULL);
> +       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
> 
> @@ -542,8 +624,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
>   */
>  int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
> -                                  clk_id, 0, mode);
> +       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0, mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
> 
> @@ -560,8 +641,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
>   */
>  int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
> -                                  clk_id, data, NULL);
> +       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
> 
> @@ -577,8 +657,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
>   */
>  int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
> -                                  clk_id, 0, data);
> +       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0, data);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
> 
> @@ -595,8 +674,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
>   */
>  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
> -                                  type, value, NULL);
> +       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type, value,
> +                              NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
> 
> @@ -612,8 +691,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
>   */
>  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
> -                                  type, 0, NULL);
> +       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type, 0, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
> 
> @@ -628,8 +706,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>   */
>  int zynqmp_pm_write_ggs(u32 index, u32 value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
> -                                  index, value, NULL);
> +       return zynqmp_pm_ioctl(0, IOCTL_WRITE_GGS, index, value, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
> 
> @@ -644,8 +721,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
>   */
>  int zynqmp_pm_read_ggs(u32 index, u32 *value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
> -                                  index, 0, value);
> +       return zynqmp_pm_ioctl(0, IOCTL_READ_GGS, index, 0, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
> 
> @@ -661,8 +737,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
>   */
>  int zynqmp_pm_write_pggs(u32 index, u32 value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
> -                                  NULL);
> +       return zynqmp_pm_ioctl(0, IOCTL_WRITE_PGGS, index, value, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
> 
> @@ -678,8 +753,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
>   */
>  int zynqmp_pm_read_pggs(u32 index, u32 *value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
> -                                  value);
> +       return zynqmp_pm_ioctl(0, IOCTL_READ_PGGS, index, 0, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
> 
> @@ -694,8 +768,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
>   */
>  int zynqmp_pm_set_boot_health_status(u32 value)
>  {
> -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
> -                                  value, 0, NULL);
> +       return zynqmp_pm_ioctl(0, IOCTL_SET_BOOT_HEALTH_STATUS, value, 0, NULL);
>  }
> 
>  /**
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

Oops, this means I have to drop this, it's not compatible with kernel
development, sorry.

greg k-h
