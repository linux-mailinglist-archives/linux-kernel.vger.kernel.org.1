Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679452435F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHMI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 04:29:47 -0400
Received: from mleia.com ([178.79.152.223]:34928 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMI3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:29:45 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 4FD3D3FE512;
        Thu, 13 Aug 2020 08:29:44 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] regulator: plug of_node leak in
 regulator_register()'s error path
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
 <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
 <cddd3d73-8666-d64b-34f5-d82a3b31cf36@mleia.com>
 <20200812140953.GA11200@qmqm.qmqm.pl>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <a57a8a4b-3715-8748-a638-f1550ab587fc@mleia.com>
Date:   Thu, 13 Aug 2020 11:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200812140953.GA11200@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200813_082944_347084_7D4739B3 
X-CRM114-Status: GOOD (  10.65  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/20 5:09 PM, Michał Mirosław wrote:
> On Wed, Aug 12, 2020 at 09:29:12AM +0300, Vladimir Zapolskiy wrote:
>> On 8/12/20 4:31 AM, Michał Mirosław wrote:
> [...]
>>>  	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
>>>  	if (config == NULL) {
>>> -		kfree(rdev);
>>>  		ret = -ENOMEM;
>>> -		goto rinse;
>>> +		goto clean;
> [...]
>>>  clean:
>>>  	if (dangling_of_gpiod)
>>>  		gpiod_put(config->ena_gpiod);
>>
>> And above 'config' NULL pointer could be dereferenced now, right?
> 
> If config is NULL, dangling_of_gpiod cannot be true.
> 

It's true, thanks. Probably to avoid the known if(false) it might be better
to add a new goto label.

Also it seems to me that it's safe to enter regulator_dev_release() before
doing an assignment to rdev->dev.of_node and incrementing an of_node counter.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
