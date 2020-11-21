Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2765A2BC183
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgKUSjC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 21 Nov 2020 13:39:02 -0500
Received: from aposti.net ([89.234.176.197]:49176 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgKUSjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:39:02 -0500
Date:   Sat, 21 Nov 2020 18:38:49 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] remoteproc: Add module parameter 'auto_boot'
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <P4T5KQ.W5BP830SCRPW1@crapouillou.net>
In-Reply-To: <20201120223701.GF4137289@xps15>
References: <20201115115056.83225-1-paul@crapouillou.net>
        <20201120223701.GF4137289@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Le ven. 20 nov. 2020 à 15:37, Mathieu Poirier 
<mathieu.poirier@linaro.org> a écrit :
> Hi Paul,
> 
> On Sun, Nov 15, 2020 at 11:50:56AM +0000, Paul Cercueil wrote:
>>  Until now the remoteproc core would always default to trying to 
>> boot the
>>  remote processor at startup. The various remoteproc drivers could
>>  however override that setting.
>> 
>>  Whether or not we want the remote processor to boot, really depends 
>> on
>>  the nature of the processor itself - a processor built into a WiFi 
>> chip
>>  will need to be booted for the WiFi hardware to be usable, for 
>> instance,
>>  but a general-purpose co-processor does not have any predeterminated
>>  function, and as such we cannot assume that the OS will want the
>>  processor to be booted - yet alone that we have a single do-it-all
>>  firmware to load.
>> 
> 
> If I understand correctly you have various remote processors that use 
> the same firmware
> but are serving different purposes - is this correct?

That's the opposite actually. I have one remote processor which is 
general-purpose, and as such userspace may or may not want it started 
at boot time - depending on what it wants to do with it. The kernel 
shouldn't decide itself whether or not the remote processor should be 
started, because that's policy.

> 
>>  Add a 'auto_boot' module parameter that instructs the remoteproc 
>> whether
>>  or not it should auto-boot the remote processor, which will default 
>> to
>>  "true" to respect the previous behaviour.
>> 
> 
> Given that the core can't be a module I wonder if this isn't 
> something that
> would be better off in the specific platform driver or the device 
> tree...  Other
> people might have an opinion as well.

Hardcoded in the platform driver or flagged in the device tree, doesn't 
change the fundamental problem - it should be up to the userspace to 
decide whether or not the remote processor should boot.

Cheers,
-Paul

> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/remoteproc/remoteproc_core.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>>  diff --git a/drivers/remoteproc/remoteproc_core.c 
>> b/drivers/remoteproc/remoteproc_core.c
>>  index dab2c0f5caf0..687b1bfd49db 100644
>>  --- a/drivers/remoteproc/remoteproc_core.c
>>  +++ b/drivers/remoteproc/remoteproc_core.c
>>  @@ -44,6 +44,11 @@
>> 
>>   #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
>> 
>>  +static bool auto_boot = true;
>>  +module_param(auto_boot, bool, 0400);
>>  +MODULE_PARM_DESC(auto_boot,
>>  +		 "Auto-boot the remote processor [default=true]");
>>  +
>>   static DEFINE_MUTEX(rproc_list_mutex);
>>   static LIST_HEAD(rproc_list);
>>   static struct notifier_block rproc_panic_nb;
>>  @@ -2176,7 +2181,7 @@ struct rproc *rproc_alloc(struct device *dev, 
>> const char *name,
>>   		return NULL;
>> 
>>   	rproc->priv = &rproc[1];
>>  -	rproc->auto_boot = true;
>>  +	rproc->auto_boot = auto_boot;
>>   	rproc->elf_class = ELFCLASSNONE;
>>   	rproc->elf_machine = EM_NONE;
>> 
>>  --
>>  2.29.2
>> 


