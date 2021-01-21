Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A12FE677
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbhAUJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbhAUJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:36:18 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F36C061575;
        Thu, 21 Jan 2021 01:35:29 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CEAD822F99;
        Thu, 21 Jan 2021 10:35:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611221728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gbRSGE0nWUH9bFF7dDE4htsRr0J7rGI/rc6n7Svmns=;
        b=EtcfjVUJ/wecaAdfo5GWmzWJ/1iDt9eeRVDeuJIB9jb/dFWT0aaye6XcrKNyeAhs/5OgQF
        eY/5crAqpcbBLXDVQzBN31uB/o89bl8O5WQA6Nrm45mZGdKGUjhgxxreCMucxkqiT9rb+K
        B3zVORwDZnBhII5cLn0YRZKKqEyiWdg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jan 2021 10:35:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
In-Reply-To: <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
References: <20210120194033.26970-1-michael@walle.cc>
 <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <aa96fcaa362181d4b6fef9f1de0aa914@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Am 2021-01-21 10:25, schrieb Michal Simek:
> On 1/20/21 8:40 PM, Michael Walle wrote:
>> Add support for the Ebang EBAZ4205 board. This board was once used as 
>> a
>> control board for a bitcoin mining device. Nowawdays it is sold as a 
>> cheap
>> Zynq-7000 eval board.
>> 
>> Michael Walle (3):
>>   dt-bindings: add ebang vendor prefix
>>   dt-bindings: arm: add Ebang EBAZ4205 board
>>   ARM: dts: add Ebang EBAZ4205 device tree
>> 
>>  .../devicetree/bindings/arm/xilinx.yaml       |   1 +
>>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>  arch/arm/boot/dts/Makefile                    |   1 +
>>  arch/arm/boot/dts/zynq-ebaz4205.dts           | 109 
>> ++++++++++++++++++
>>  4 files changed, 113 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts
>> 
> 
> any link with schematics?

https://github.com/xjtuecho/EBAZ4205, looks like these are
reverse engineered (from a layout file?) though.

> I will let dt guys to comment 1/3 but series look good to me.
> The board doesn't look interesting from description point of view 
> that's
> why all the time thinking if makes sense to add it to kernel.

What do you want to tell me? That for the time being, it didn't
appear to you to add the board yourself - or do you thing it
doesn't make sense at all. If its the latter, what would be
actual reason to have a board in mainline?

-michael
