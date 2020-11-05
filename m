Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0532A7FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgKEN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:26:18 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:42139 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:26:17 -0500
IronPort-SDR: Zr+1S/SxTxqWn0bJUXKAEEQEIyiIRm2olp7FYLKct6fjaoyI3XVKXbdMhu9qCkB4KOsojcD9bk
 0X2qb7dXQMyb6V5LOsMYdcLLiWftvged5OmETXV0iOmy6j+11CtsbFD7yJQkLU62SHpg/0eV/K
 FoGAQm4ktOajvSvK25xVtcOEZHFNPKlbvY9F6kHkkZUTnaW8jUO8fqX5ZcVrPvjfBgQvfUXIDc
 lWYotpdNXVDgS/MqA5ALtgfXyIgZd0L+RdKxxRBqkmACMVSwTTn+uAqVWZYNKMVHIT6pgbRyf4
 gvU=
X-IronPort-AV: E=Sophos;i="5.77,453,1596528000"; 
   d="scan'208";a="54839176"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 05 Nov 2020 05:26:16 -0800
IronPort-SDR: djgmWDpRVb5bzlGO2/LUhJF8Bscj7K02FLIwGPqb8WZCbzRWA4ApZgyQQzI/GhBkGSEeBEOLks
 /QNCNabBsqDtjXh6RriH74blBmEsBCsiFUPUErjpj+QDVY4l+kKfmdqKIaY8l3bA6HcK0tmniL
 n1nq6r4kr7oxe061cbr0w+akFc7/eVbRizADen3h+KCd69V6XbG8XoQ2hYp0e7mUei9g9O6i1v
 UAp1YEMQdmki9rf75u36G+ppt/6MQjKe8wnOUQz3+r/sqe7DFqTPpNd3n6Q7TDawdfCo5OdF40
 LGo=
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     Andre <andre.muller@web.de>, Nick Dyer <nick.dyer@itdev.co.uk>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-kernel@vger.kernel.org>
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
From:   "Wang, Jiada" <jiada_wang@mentor.com>
Message-ID: <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
Date:   Thu, 5 Nov 2020 22:25:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre

Thanks for your report,
could you also please post the log when with this commit reverted?

Thanks,
Jiada

On 2020/11/04 17:13, Andre wrote:
> Hi,
> 
> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
> mxt_acquire_irq() when necessary
> 
> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "Samus".
> 
> Reverting the commit from the current git tree gets them to work again.
> 
> I am not at all shure what info to include, but I will happily provide
> it on request.
> 
> The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
> workaround", but otherwise looks the same as a boot without.
> 
> Here is the relevant bit (with 74d905d2):
> 
> atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.AA
> Objects: 32
> atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
> atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
> failed with error -2
> atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
> input: Atmel maXTouch Touchpad as
> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
> atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0.AA
> Objects: 41
> atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
> atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
> failed with error -2
> 
> Thank you,
> Andre Müller
