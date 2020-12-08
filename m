Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4112D2E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgLHPjM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Dec 2020 10:39:12 -0500
Received: from aposti.net ([89.234.176.197]:45206 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbgLHPjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:39:12 -0500
Date:   Tue, 08 Dec 2020 15:38:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-Id: <Q321LQ.JCBWCTTZDHME3@crapouillou.net>
In-Reply-To: <CAK8P3a21gkBsb3rcNvzH3XA_0GRRKPgnsrynTTO=EZVwy6DC+g@mail.gmail.com>
References: <20201203222922.1067522-1-arnd@kernel.org>
        <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
        <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
        <IVYYKQ.T5GFS8Z1QTP2@crapouillou.net>
        <CAK8P3a21gkBsb3rcNvzH3XA_0GRRKPgnsrynTTO=EZVwy6DC+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 8 déc. 2020 à 15:04, Arnd Bergmann <arnd@kernel.org> a écrit 
:
> On Mon, Dec 7, 2020 at 1:33 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>>  Le ven. 4 déc. 2020 à 15:14, Arnd Bergmann <arnd@kernel.org> a 
>> écrit
> 
>>  By the way, as I'm ending up doing the same in a different context, 
>> I
>>  think it would be useful to have a IF_ENABLED() macro defined like 
>> this:
>> 
>>  #define IF_ENABLED(_cfg, _ptr) (IS_ENABLED(_cfg) ? (_ptr) : NULL)
>> 
>>  Then the pm_ptr(_ptr) macro could be defined like this:
>> 
>>  #define pm_ptr(_ptr) IF_ENABLED(CONFIG_PM, _ptr)
> 
> I like that. Do you just want to go ahead and start with adding
> IF_ENABLED() to your own branch then?

Sure. I'll send a patch later today and Cc you (and linux-arm?).

Cheers,
-Paul


