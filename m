Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2908230087E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbhAVQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:20:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11136 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbhAVQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611332162; x=1642868162;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=akfaX8ej4mNSDSiYlmg4n0T8nIbvD+geiuHI63vtcuQ=;
  b=SdWvlCEmZoVR43NfU1CXxOk6kNwL4av6ykjOnDwGod/3DRzz+N+wAiwt
   HS4JVzohxVdwHgCCJAgcb8mvhS7Zl22Zl+LrKLNMKb4iLJGIuT8Je8Psk
   /piP0vvAsZhSvjShdvZgCfaogyaPZO4lXcT0TnBxibG+GG6y8d0XBl3Pc
   NCnBpoyub89B8etGFFJgDWB6fV6ZIHV1jD4OjlyRGcm8BR3jEzfwkpQQd
   TXImEGnxrEaddUFruv0pbk/YFn+hCmvBE6I8HGbgcEIr81QkG0WAX22Pz
   OqxfWhpiyfIDSaknCwp+FdqdL0b2RmZAylxsTvIry9NWCOrumgS3//O/g
   w==;
IronPort-SDR: PGarIi6QTG+I9LIhdvquCOGfspA7sPtUx5742TLHSw1axWQdKUAD9BtXK8cFbV0FxBkNLlmAyR
 ptd2SH4h1l/FrlGrSlrxAYP0HqkQ1JZn0+BHBnl0smH6oOUM6ebMyiLyQBnHXXhlx8ifA2oOUj
 GGN5IrRM3GCtD0jLYS5CQicGmwP0iCRG0ySdulAo5VFOC7LUEGIPw0hsNlNHwxy60QjQwUVWpB
 3qV93A7Y6FpalYIjFY7VUzHVfKU6W6lZhe+qVdLdLl7z+nrXGrBEMnj+M3EtFs7/vX76QjEGd7
 ogI=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="101063226"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 09:14:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 09:14:34 -0700
Received: from [10.171.246.92] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 09:14:32 -0700
Subject: Re: [GIT PULL] ARM: at91: soc for 5.12
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20210122143536.168833-1-nicolas.ferre@microchip.com>
 <CAK8P3a0s5UPvCzQrcYmPPDYgT+YyZ3vc=fF0GEwpqROR+Zio-g@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <715938cd-d898-5d12-cc11-d79cf27c5430@microchip.com>
Date:   Fri, 22 Jan 2021 17:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0s5UPvCzQrcYmPPDYgT+YyZ3vc=fF0GEwpqROR+Zio-g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 at 16:25, Arnd Bergmann wrote:
> On Fri, Jan 22, 2021 at 3:35 PM <nicolas.ferre@microchip.com> wrote:
>>
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Arnd, Olof,
>>
>> I'm taking back the lead on sending the pull-requests for AT91 and hope that I
>> didn't loose the knowledge in the meantime. Tell me if there's something I'm
>> missing. Thanks a lot to Alexandre who kept our flow steady and very
>> predictable during all those years!
>>
>> Here are the first SoC changes for 5.12 which contain a single patch for multi
>> platform kernels.
>>
>> I plan to send another pull-request for the SoC changes related to new sama7g5
>> that Claudiu sent to the mainling-list recently. I'll let it mature in
>> linux-next by the beginning of next week and will send another pull-request by
>> mid-next-week.
>> Tell me if you see a problem with this approach.
> 
> This all looks good to me, but I think I'd rather take the 'soc' pull request
> into the v5.11 bugfixes, as this may already affect users on other machines.
> 
> I would also suggest adding a 'Cc: stable@vger.kernel.org' tag. If you like,
> I can just cherry-pick that patch into the fixes branch and add it there.

Oh yes, that'd be good, indeed.

You can add the following tag:
Cc: stable@vger.kernel.org #4.12+

Best regards,
-- 
Nicolas Ferre
