Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A321E2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 00:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGMWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgGMWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:18:08 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBDAC08C5DB;
        Mon, 13 Jul 2020 15:18:07 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 58F1EBC0E4;
        Mon, 13 Jul 2020 22:18:03 +0000 (UTC)
Subject: Re: [PATCH] platform/x86: Replace HTTP links with HTTPS ones
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200713184606.37033-1-grandmaster@al2klimov.de>
 <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <490226b0-754e-f5a4-8daf-96e6e33c0ae8@al2klimov.de>
Date:   Tue, 14 Jul 2020 00:18:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
X-Spam-Level: *
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.07.20 um 21:17 schrieb Andy Shevchenko:
> On Mon, Jul 13, 2020 at 9:46 PM Alexander A. Klimov
> <grandmaster@al2klimov.de> wrote:
>>
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>            If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
> 
> Please split per driver basis.
Am I completely blind or is there only one driver affected by my patch?

> 
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   Continuing my work started at 93431e0607e5.
>>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>>   (Actually letting a shell for loop submit all this stuff for me.)
>>
>>   If there are any URLs to be removed completely or at least not just HTTPSified:
>>   Just clearly say so and I'll *undo my change*.
>>   See also: https://lkml.org/lkml/2020/6/27/64
>>
>>   If there are any valid, but yet not changed URLs:
>>   See: https://lkml.org/lkml/2020/6/26/837
>>
>>   If you apply the patch, please let me know.
>>
>>   Sorry again to all maintainers who complained about subject lines.
>>   Now I realized that you want an actually perfect prefixes,
>>   not just subsystem ones.
>>   I tried my best...
>>   And yes, *I could* (at least half-)automate it.
>>   Impossible is nothing! :)
>>
>>
>>   drivers/platform/x86/Kconfig      |  2 +-
>>   drivers/platform/x86/apple-gmux.c | 16 ++++++++--------
>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0581a54cf562..1d96e07b2a02 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -140,7 +140,7 @@ config ACERHDF
>>            in the same node directory will tell you if it is "acerhdf".
>>
>>            For more information about this driver see
>> -         <http://piie.net/files/acerhdf_README.txt>
>> +         <https://piie.net/files/acerhdf_README.txt>
>>
>>            If you have an Acer Aspire One netbook, say Y or M
>>            here.
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index 7e3083deb1c5..9aae45a45200 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -277,8 +277,8 @@ static bool gmux_is_indexed(struct apple_gmux_data *gmux_data)
>>    * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer models
>>    * use a `TI LP8545`_.
>>    *
>> - * .. _TI LP8543: http://www.ti.com/lit/ds/symlink/lp8543.pdf
>> - * .. _TI LP8545: http://www.ti.com/lit/ds/symlink/lp8545.pdf
>> + * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
>> + * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
>>    */
>>
>>   static int gmux_get_brightness(struct backlight_device *bd)
>> @@ -373,14 +373,14 @@ static const struct backlight_ops gmux_bl_ops = {
>>    * switch the panel and the external DP connector and allocates a framebuffer
>>    * for the selected GPU.
>>    *
>> - * .. _US 8,687,007 B2: http://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
>> - * .. _NXP CBTL06141:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
>> - * .. _NXP CBTL06142:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
>> - * .. _TI HD3SS212:     http://www.ti.com/lit/ds/symlink/hd3ss212.pdf
>> + * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
>> + * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
>> + * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
>> + * .. _TI HD3SS212:     https://www.ti.com/lit/ds/symlink/hd3ss212.pdf
>>    * .. _Pericom PI3VDP12412: https://www.pericom.com/assets/Datasheets/PI3VDP12412.pdf
>> - * .. _TI SN74LV4066A:  http://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
>> + * .. _TI SN74LV4066A:  https://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
>>    * .. _NXP CBTL03062:   http://pdf.datasheetarchive.com/indexerfiles/Datasheets-SW16/DSASW00308511.pdf
>> - * .. _TI TS3DS10224:   http://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
>> + * .. _TI TS3DS10224:   https://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
>>    */
>>
>>   static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
>> --
>> 2.27.0
>>
> 
> 
