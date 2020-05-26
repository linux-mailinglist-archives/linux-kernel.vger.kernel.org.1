Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E101A4F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDKK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 06:27:35 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:37585 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgDKK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:27:35 -0400
Received: from [192.168.42.210] ([93.22.135.18])
        by mwinf5d25 with ME
        id RNTY2200A0Pz5GD03NTZTM; Sat, 11 Apr 2020 12:27:34 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 12:27:34 +0200
X-ME-IP: 93.22.135.18
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.janitors
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
 <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
 <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
 <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
 <159680bb287fc43bb2129d3b731e15931bd9979c.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0b05744d-7379-fa23-5070-c09fd10db45d@wanadoo.fr>
Date:   Sat, 11 Apr 2020 12:27:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159680bb287fc43bb2129d3b731e15931bd9979c.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/04/2020 à 12:17, Joe Perches a écrit :
> On Sat, 2020-04-11 at 09:12 +0200, Christophe JAILLET wrote:
>> 	./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
>>
>> is missing line 189, even if it looks like a construction correctly spotted in some other files:
>> 	if (foo) {
>> 		dev_err(...);
>> 		...
>> 	};
> Hi Christophe, many thanks for doing more testing
>
> Are you sure about this one?  I get:
>
> $ ./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
> WARNING: Possible missing '\n' at the end of a logging message format string
> #189: FILE: drivers/soc/kendryte/k210-sysctl.c:189:
> +		dev_err(&pdev->dev, "failed to register clk");
No, this one is correctly spotted.
(I added the missing \n, then ran checkpatch.pl, then wondered why it 
was not spotting the issue!)

CJ

