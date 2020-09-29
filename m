Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B078E27BE70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgI2HzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:55:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57664 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgI2HzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:55:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B4E5129A913
Subject: Re: [PATCH] platform_data: ti: fix a typo
To:     Wang Qing <wangqing@vivo.com>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
References: <1601088620-16070-1-git-send-email-wangqing@vivo.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b2b61349-db5c-07dd-0d55-84d7a7d54492@collabora.com>
Date:   Tue, 29 Sep 2020 09:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601088620-16070-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang Qing,

Thank you for your patch.

On 26/9/20 4:49, Wang Qing wrote:
> Modify the typo: "compliment" -> "complement".
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  include/linux/platform_data/cros_ec_commands.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 1fcfe9e..42203ce
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -261,12 +261,12 @@
>  /* Memory space version; set to EC_ACPI_MEM_VERSION_CURRENT */
>  #define EC_ACPI_MEM_VERSION            0x00
>  /*
> - * Test location; writing value here updates test compliment byte to (0xff -
> + * Test location; writing value here updates test complement byte to (0xff -
>   * value).
>   */
>  #define EC_ACPI_MEM_TEST               0x01
> -/* Test compliment; writes here are ignored. */
> -#define EC_ACPI_MEM_TEST_COMPLIMENT    0x02
> +/* Test complement; writes here are ignored. */
> +#define EC_ACPI_MEM_TEST_COMPLEMENT    0x02
>  

Although there is a typo, we did an effort to have cros_ec_command synced with
ec commands in the firmware code, so I'd like to see this change also applied on
the EC code. Do you mind to populate this change in the EC firmware code [1], please

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master

Thanks,
  Enric


>  /* Keyboard backlight brightness percent (0 - 100) */
>  #define EC_ACPI_MEM_KEYBOARD_BACKLIGHT 0x03
> 
