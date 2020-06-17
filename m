Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF91FD605
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFQU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 16:28:00 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:36975 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:27:58 -0400
Received: from [192.168.42.210] ([93.23.15.97])
        by mwinf5d07 with ME
        id sLTv2200325enVZ03LTvKh; Wed, 17 Jun 2020 22:27:56 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Jun 2020 22:27:56 +0200
X-ME-IP: 93.23.15.97
Subject: Re: [PATCH] pcmcia/electra_cf: Fix some return values in
 'electra_cf_probe()' in case of error
To:     Olof Johansson <olof@lixom.net>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
 <CAOesGMjC_KttO0T89UbWpnsWsGqWeSnpqJr9JTEn2OtQ=xWtoQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <295b82c9-510d-262c-8b88-206372d839ed@wanadoo.fr>
Date:   Wed, 17 Jun 2020 22:27:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMjC_KttO0T89UbWpnsWsGqWeSnpqJr9JTEn2OtQ=xWtoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/06/2020 à 22:10, Olof Johansson a écrit :
> On Wed, Jun 17, 2020 at 12:54 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> 'status' is known to be 0 at this point. It must be set to a meaningful
>> value in order to return an error code if one of the 'of_get_property()'
>> call fails.
>>
>> Return -EINVAL in such a case.
>>
>> Fixes: 2b571a066a2f("pcmcia: CompactFlash driver for PA Semi Electra boards")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/pcmcia/electra_cf.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
>> index 35158cfd9c1a..40a5cffe24a4 100644
>> --- a/drivers/pcmcia/electra_cf.c
>> +++ b/drivers/pcmcia/electra_cf.c
>> @@ -229,6 +229,8 @@ static int electra_cf_probe(struct platform_device *ofdev)
>>
>>          cf->socket.pci_irq = cf->irq;
>>
>> +       status = -EINVAL;
>> +
>>          prop = of_get_property(np, "card-detect-gpio", NULL);
>>          if (!prop)
>>                  goto fail1;
> The pcmcia_register_socket() call site sets status explicitly before
> jumping to fail1, which is a bit clearer.

Agreed, but as as you say below, this is not the most active driver in 
the kernel and PCMCIA, well, does anyone still uses it?

> Still, this is a legacy driver, I'm not sure there are any active
> users of it these days, and surely nobody that's tinkering around and
> editing the device tree (it comes from CFE on these systems, not from
> a .dts in the kernel tree). The fix isn't invalid, but it's also not
> likely to be an issue in the real world. So, let's just say:

In fact this patch has been in my tree for years, because the driver is 
mostly untouched and certainly used by no one, nowadays.
However, 2 weeks ago, commit b274014c6d19 made me think of a revived 
interest.
So I decided to post the patch, just in case.

> Acked-by: Olof Johansson <olof@lixom.net>
>
>
> -Olof
>

