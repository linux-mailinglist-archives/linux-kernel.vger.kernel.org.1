Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E642D4402
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgLIOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLIOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:12:39 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA8C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 06:11:59 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c7so1706272edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DAy8aBIECsrefqDVb9h8bFV4Kd0j9Y+IEkwArNwxyX0=;
        b=1GgAcmakArZmkfYHYsy5zyCDEUvp3y2hT7ct70DdTJjI8/rUK94S0jTiFUHicmZux4
         2p0jpb1kCDwplRsEJF4uHuEt6a57paaGSDPDGO/DO2nmc60we+7bps5esBVFI26X9koU
         jV+GLF+GaztBZx5whWL8oks3YPqoWdPq3YnOg0U73p3WVf5lS/DuKa1S+X0phmpl+fkr
         HHxlc1MQVeow8CGBHmRFmMdNuxIwaNt3cKp/pmHi7YE1NbcwFW4xtBiwU/6vmefbwRZY
         nD4j+Otye1NeXl9fVLNJ9KfCXgQRfuvE0yJM0T1EmU3+QqwQjTCJRCxNCsyRnE0Zm0Ox
         Eq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAy8aBIECsrefqDVb9h8bFV4Kd0j9Y+IEkwArNwxyX0=;
        b=PjZn6D7ZLE1eSzviEMkWKNIyYEJ7NMgQY34J26ns6h31sq08+d7nRSqAw6bfBDo+Nw
         9ezuMLt3jfS9tqTmftYZE3iLGVVFx1ME/TvR3qO23iSRiyl+jAofiRkN0oZ9jLVEawPs
         cv+r0MpiZhhMWYFesH2fZ21VRMdHP1stlQXDogwsgX/ANHR33mJTrRlhtAobgW2WdFoQ
         s+BnAfUnk0qtrlrUuyrivApWGcYoEo8IXhMdrkhP4UTooVPYv4thzsgs0nXHAjrb5J1H
         UYlEHyL9ud2zL3OeDNmj2OFudeUDS//RoX9TLs3IdQ1cpoeNS3p7C9pY1LsnNlhdNwMr
         fcEA==
X-Gm-Message-State: AOAM533pf9QpcPMLvysaCOSpUVtM+/Z6l4flqelra+YZvOIabuOD+3eB
        M/EPtpZ58SjtMHBk1nePUmvHaGvl+lvA0KQj
X-Google-Smtp-Source: ABdhPJxrieFaviOpAbWDN3SS727xPQoXjZ2vyJwg45Js0BmtiqVqkD/JicPTr1DTpQTKeS8u+RPAOQ==
X-Received: by 2002:a05:6402:13d1:: with SMTP id a17mr2157235edx.202.1607523117860;
        Wed, 09 Dec 2020 06:11:57 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c12sm1740863edw.55.2020.12.09.06.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:11:57 -0800 (PST)
Subject: Re: [PATCH] firmware: xilinx: Fix kernel-doc warnings
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
References: <e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <6a875bc1-fa11-7638-51b6-25c65f5791ea@monstr.eu>
Date:   Wed, 9 Dec 2020 15:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01. 12. 20 15:29, Michal Simek wrote:
> kernel-doc is reporting some style issues. The patch is fixing them.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/firmware/xilinx/zynqmp.c | 46 ++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d6f12c89c6f3..ddf8e4e72584 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -585,13 +585,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
>  /**
>   * zynqmp_pm_set_sd_tapdelay() -  Set tap delay for the SD device
>   *
> - * @node_id	Node ID of the device
> - * @type	Type of tap delay to set (input/output)
> - * @value	Value to set fot the tap delay
> + * @node_id:	Node ID of the device
> + * @type:	Type of tap delay to set (input/output)
> + * @value:	Value to set fot the tap delay
>   *
>   * This function sets input/output tap delay for the SD device.
>   *
> - * @return	Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
>  {
> @@ -603,12 +603,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
>  /**
>   * zynqmp_pm_sd_dll_reset() - Reset DLL logic
>   *
> - * @node_id	Node ID of the device
> - * @type	Reset type
> + * @node_id:	Node ID of the device
> + * @type:	Reset type
>   *
>   * This function resets DLL logic for the SD device.
>   *
> - * @return	Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  {
> @@ -619,12 +619,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>  
>  /**
>   * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
> - * @index	GGS register index
> - * @value	Register value to be written
> + * @index:	GGS register index
> + * @value:	Register value to be written
>   *
>   * This function writes value to GGS register.
>   *
> - * @return      Returns status, either success or error+reason
> + * Return:      Returns status, either success or error+reason
>   */
>  int zynqmp_pm_write_ggs(u32 index, u32 value)
>  {
> @@ -635,12 +635,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
>  
>  /**
>   * zynqmp_pm_write_ggs() - PM API for reading global general storage (ggs)
> - * @index	GGS register index
> - * @value	Register value to be written
> + * @index:	GGS register index
> + * @value:	Register value to be written
>   *
>   * This function returns GGS register value.
>   *
> - * @return      Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_read_ggs(u32 index, u32 *value)
>  {
> @@ -652,12 +652,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
>  /**
>   * zynqmp_pm_write_pggs() - PM API for writing persistent global general
>   *			     storage (pggs)
> - * @index	PGGS register index
> - * @value	Register value to be written
> + * @index:	PGGS register index
> + * @value:	Register value to be written
>   *
>   * This function writes value to PGGS register.
>   *
> - * @return      Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_write_pggs(u32 index, u32 value)
>  {
> @@ -669,12 +669,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
>  /**
>   * zynqmp_pm_write_pggs() - PM API for reading persistent global general
>   *			     storage (pggs)
> - * @index	PGGS register index
> - * @value	Register value to be written
> + * @index:	PGGS register index
> + * @value:	Register value to be written
>   *
>   * This function returns PGGS register value.
>   *
> - * @return      Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_read_pggs(u32 index, u32 *value)
>  {
> @@ -685,12 +685,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
>  
>  /**
>   * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
> - * @value	Status value to be written
> + * @value:	Status value to be written
>   *
>   * This function sets healthy bit value to indicate boot health status
>   * to firmware.
>   *
> - * @return      Returns status, either success or error+reason
> + * Return:	Returns status, either success or error+reason
>   */
>  int zynqmp_pm_set_boot_health_status(u32 value)
>  {
> @@ -899,10 +899,10 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
>   *			       master has initialized its own power management
>   *
> + * Return: Returns status, either success or error+reason
> + *
>   * This API function is to be used for notify the power management controller
>   * about the completed power management initialization.
> - *
> - * Return: Returns status, either success or error+reason
>   */
>  int zynqmp_pm_init_finalize(void)
>  {
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



