Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9A215B47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgGFP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 11:56:07 -0400
Received: from ns.iliad.fr ([212.27.33.1]:47032 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgGFP4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:56:06 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 50DFE219E4;
        Mon,  6 Jul 2020 17:56:04 +0200 (CEST)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 242F620097;
        Mon,  6 Jul 2020 17:56:04 +0200 (CEST)
Subject: Re: [PATCH v5 0/2] Small devm helper for devm implementations
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
 <69f6f7fc-4fb6-248a-684a-b853ee0836bc@free.fr>
Message-ID: <3fea884b-05d3-ff67-b9fe-41c9b46cf478@free.fr>
Date:   Mon, 6 Jul 2020 17:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <69f6f7fc-4fb6-248a-684a-b853ee0836bc@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jul  6 17:56:04 2020 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Would you agree to take this series?

Regards.

On 18/06/2020 13:38, Marc Gonzalez wrote:

> Hello everyone,
> 
> In my opinion, the small and simple devm_add() helper
> (and its cousin, devm_vadd) can help make devm code
> slightly easier to write and maintain.
> 
> Would anyone care to agree or disagree? :-)
> 
> Regards.
> 
> On 10/03/2020 11:11, Marc Gonzalez wrote:
> 
>> Differences from v4 to v5
>> x Fix the grammar in devm_add comments [Geert]
>> x Undo an unrelated change in devm_clk_put [Geert]
>>
>> Differences from v3 to v4
>> x Add a bunch of kerneldoc above devm_add() [Greg KH]
>> x Split patch in two [Greg KH]
>>
>> Differences from v2 to v3
>> x Make devm_add() return an error-code rather than the raw data pointer
>>   (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
>> x Provide a variadic version devm_vadd() to work with structs as suggested
>>   by Geert
>> x Don't use nested ifs in clk_devm* implementations (hopefully simpler
>>   code logic to follow) as suggested by Geert
>>
>> Marc Gonzalez (2):
>>   devres: Provide new helper for devm functions
>>   clk: Use devm_add in managed functions
>>
>>  drivers/base/devres.c    | 28 ++++++++++++
>>  drivers/clk/clk-devres.c | 97 +++++++++++++++-------------------------
>>  include/linux/device.h   |  3 ++
>>  3 files changed, 67 insertions(+), 61 deletions(-)
