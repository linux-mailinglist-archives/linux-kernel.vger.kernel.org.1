Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0658726D44A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:10:30 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:36830 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQHKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:10:00 -0400
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:09:57 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 08H6kOPR010161; Thu, 17 Sep 2020 15:46:24 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 08H6jpBw002274; Thu, 17 Sep 2020 15:45:52 +0900
X-Iguazu-Qid: 2wGr7dZaSfvq1Oml3l
X-Iguazu-QSIG: v=2; s=0; t=1600325151; q=2wGr7dZaSfvq1Oml3l; m=KFj81QGJjZTnYSBV2oL0DYYpoU+vNFx8h5XwdG02jJU=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1112) id 08H6jmF3006518;
        Thu, 17 Sep 2020 15:45:49 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 08H6jmRe001067;
        Thu, 17 Sep 2020 15:45:48 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 08H6jlah003590;
        Thu, 17 Sep 2020 15:45:47 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
References: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
        <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
Date:   Thu, 17 Sep 2020 15:45:44 +0900
In-Reply-To: <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
        (Amit Sunil Dhamne's message of "Wed, 9 Sep 2020 17:20:02 -0700")
X-TSB-HOP: ON
Message-ID: <877dssnbon.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com> writes:

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

Other than the additional IOCTL being added in the next patch, this list
is common between the two SoCs this driver runs on.

To avoid duplication , it would be better to refactor into common and
versal specific checks with the latter using the common function for
shared IOCTLs. e.g., 

common_is_valid_ioctl() containing the common parts

versal_is_valid_ioctl() using the above function

One more comment below.

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

The driver is going to be probed either on a zyncmp or a versal based
platform.

You may want to consider stashing the result of the current platform at
driver probe time and avoid searching through the device tree for every
call.

Thanks,
Punit

> +       if (np) {
> +               if (!versal_is_valid_ioctl(ioctl_id))
> +                       return -EINVAL;
> +       } else {
> +               if (!zynqmp_is_valid_ioctl(ioctl_id))
> +                       return -EINVAL;
> +       }
> +       of_node_put(np);
> +
> +       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id, arg1, arg2,
> +                                  out);
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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
