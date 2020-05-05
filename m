Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE81C55E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgEEMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 08:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgEEMsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:48:50 -0400
Received: from [192.168.0.106] (unknown [202.53.39.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24B9206A4;
        Tue,  5 May 2020 12:48:48 +0000 (UTC)
Subject: Re: [PATCH] m68k: Drop CONFIG_MTD_M25P80 in stmark2_defconfig
To:     Bin Meng <bmeng.cn@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
References: <1588393821-31886-1-git-send-email-bmeng.cn@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <e353f9e0-aead-8338-28da-2883eb710a54@linux-m68k.org>
Date:   Tue, 5 May 2020 22:48:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588393821-31886-1-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On 2/5/20 2:30 pm, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Drop CONFIG_MTD_M25P80 that was removed in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Thanks, I will push into the m68knommu git tree, for-next branch.

Regards
Greg


> ---
> 
>   arch/m68k/configs/stmark2_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
> index 27fa946..2b746f5 100644
> --- a/arch/m68k/configs/stmark2_defconfig
> +++ b/arch/m68k/configs/stmark2_defconfig
> @@ -48,7 +48,6 @@ CONFIG_MTD_CFI_STAA=y
>   CONFIG_MTD_ROM=y
>   CONFIG_MTD_COMPLEX_MAPPINGS=y
>   CONFIG_MTD_PLATRAM=y
> -CONFIG_MTD_M25P80=y
>   CONFIG_MTD_SPI_NOR=y
>   # CONFIG_INPUT_KEYBOARD is not set
>   # CONFIG_INPUT_MOUSE is not set
> 
