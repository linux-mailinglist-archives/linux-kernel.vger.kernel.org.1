Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF43009C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbhAVR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:28:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34835 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbhAVRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611335216; x=1642871216;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dkrcTOyV7SF2AdMFgUc0km5YwirX7kjYen8IfpsQ3QM=;
  b=a4qcsYsSI0XvOsSHVoOv70ed6QXm236ReqUIgX2GoY/Fv5EnjxyCNC6Y
   YW2TI51OYUctBkKVp2BXtVWv2LKe8iJtYhYFBoRNvZLLhBJdAEyNehH5K
   LTKKMWwBtA+uvRYuQCgmpTA0F68zZhE5j/tpBLom+8YKejKkOdcyNVFok
   4y5O51UN68roWWSaKXarCNcbbQ/8KDaFTTMGZ76BPlHdueFhWruIosPtY
   yW/E1l7sTIxhE6USqbOWShKK9OU/nZnVsK0r4pDqfz3ov9owCi+CIoRm/
   TZGLrhfhR/iV/p9KfMoaIhZCqsvjARC3cay2uvhJ5r8w2Dj89v6GOzp6o
   A==;
IronPort-SDR: CAhFatTCMYq27T6yHM3vczHsVxExCMl3AFVAJq9CaLzL8VIEeo1KCNP9vZc/R9UgR/AcyNfPVw
 sl4RFj1iDaNjvKss9jtoc/VQE0jd8VQbmD0WMRDko5B9MdV77OUUOiBWk95QrjdYOn2F4Vl8Qg
 N95gJZxlmBCpaH60n0EI9eQgguWB/l74TG9F3vHX3//9c0tyazTHeQxeDKNPqOXk6AFQVvWqgR
 seOTWcZzrkaThV9JgiouVDTnsOE9nsgJVJ2boRPikxJ7GpovNBlq0RcbzHeZEUn8EDSpFBM/ca
 0iA=
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="112109408"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 10:05:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 10:05:26 -0700
Received: from [10.171.246.92] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 10:05:24 -0700
Subject: Re: [GIT PULL] ARM: at91: soc for 5.12
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20210122143536.168833-1-nicolas.ferre@microchip.com>
 <CAK8P3a0s5UPvCzQrcYmPPDYgT+YyZ3vc=fF0GEwpqROR+Zio-g@mail.gmail.com>
 <20210122163520.GG1196852@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <7131cfc0-2519-8bbe-a380-609eced61753@microchip.com>
Date:   Fri, 22 Jan 2021 18:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122163520.GG1196852@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 at 17:35, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 22/01/2021 16:25:47+0100, Arnd Bergmann wrote:
>> On Fri, Jan 22, 2021 at 3:35 PM <nicolas.ferre@microchip.com> wrote:
>>>
>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>
>>> Arnd, Olof,
>>>
>>> I'm taking back the lead on sending the pull-requests for AT91 and hope that I
>>> didn't loose the knowledge in the meantime. Tell me if there's something I'm
>>> missing. Thanks a lot to Alexandre who kept our flow steady and very
>>> predictable during all those years!
>>>
>>> Here are the first SoC changes for 5.12 which contain a single patch for multi
>>> platform kernels.
>>>
>>> I plan to send another pull-request for the SoC changes related to new sama7g5
>>> that Claudiu sent to the mainling-list recently. I'll let it mature in
>>> linux-next by the beginning of next week and will send another pull-request by
>>> mid-next-week.
>>> Tell me if you see a problem with this approach.
>>
>> This all looks good to me, but I think I'd rather take the 'soc' pull request
>> into the v5.11 bugfixes, as this may already affect users on other machines.
>>
>> I would also suggest adding a 'Cc: stable@vger.kernel.org' tag. If you like,
>> I can just cherry-pick that patch into the fixes branch and add it there.
>>
> 
> I wouldn't backport it as a fix, this is just a warning, in a
> configuration that is very unlikely to be used (and honestly, I
> wouldn't enable this driver on any platform).
> 
> If you take it as a fix, you'll have to also get
> https://lore.kernel.org/linux-arm-kernel/1611318097-8970-5-git-send-email-claudiu.beznea@microchip.com/

Arnd, Alexandre,

Whatever you prefer is fine with me. As I'm not the first impacted I 
wouldn't push in one direction or another.

Best regards,
-- 
Nicolas Ferre
