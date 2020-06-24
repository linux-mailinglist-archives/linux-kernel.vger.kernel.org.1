Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD76206FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgFXJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 05:19:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44125 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgFXJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:19:13 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 50F7923078;
        Wed, 24 Jun 2020 11:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1592990350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1MkeMav3rgM2pXSNTqGSaH9vXR2wuTt3ai+eM3hpl4=;
        b=bdYacdR9LQq1EGxqkQC0BzTmp/OSRD04I4OESLB7aT1kS+qYV0hJr4k0oAlDqU9yAoJkaB
        OEJgXjCIZEph3swCIfZos3+DbSVqZf++ri09jUuwpXxErBjnXhRjnd/vSRf6RfzqH3gLLr
        /YPE/XBjRi3t4ZB6UR+kWjmmBVDQBz8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jun 2020 11:19:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
In-Reply-To: <20200624082352.GF954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
 <20200624064145.GC954398@dell> <7a31b34940984b3f0921ed2d4fb29a58@walle.cc>
 <20200624082352.GF954398@dell>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <c0a8ebd32ae07ae98fa56728c77f8e79@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-06-24 10:23, schrieb Lee Jones:
> On Wed, 24 Jun 2020, Michael Walle wrote:

[..]

>> Although Rob mentioned to maybe relax that, but I sill fail to see
>> the advantage to have an arbitrary reg property instead of a unique
>> node name.
> 
> I don't have a strong opinion either way.
> 
> We can *also* add node name matching if Rob deems it fit.

Where do you see a use of the reg property? You already expressed
that you see exposing the internal offset as a hack:

  "Placing "internal offsets" into the 'reg' property is a hack." [1]

So what are you putting into reg instead? Rob suggested "anything"
documented in the hardware manual. But isn't this just also something
we make up and especially for the MFD driver. Thus IMHO it doesn't
qualify as a unit-address, which - as far as I understand it - is
unique on the parent bus. To repeat my argument, its not a defined
thing like an I2C address.

[1] https://lore.kernel.org/linux-devicetree/20200609185231.GO4106@dell/

-michael
