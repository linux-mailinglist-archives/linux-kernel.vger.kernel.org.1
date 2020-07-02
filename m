Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932ED211C93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGBHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGBHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:21:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6DAC08C5C1;
        Thu,  2 Jul 2020 00:21:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD6C522EEB;
        Thu,  2 Jul 2020 09:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593674506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYh2/aIFWhUNCc355H6HdrFH3gHWvQp1I0ovSaO/mqQ=;
        b=QW+gWvDDGXW32OkPetPXQmwmoBHdnbvoMHEmol7FzAO6BYr41/MKv+DCCo0zCbpwZoq+kg
        dOpbYm1g2XBrKRtuw2NpMfug4zS27QbuOjREIPQekpaGB+/wotQaQvuYSWiQaaBgC+2GnF
        1hyTBcBy+7mkCs8Z4QWWpGE9TZPyK90=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 09:21:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
In-Reply-To: <20200702071402.GP1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc> <20200702071402.GP1179328@dell>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <a8fc222a555f1b5bceb7405e94f7df0e@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-07-02 09:14, schrieb Lee Jones:
> On Tue, 30 Jun 2020, Michael Walle wrote:
> 
>> Hi Lee,
>> 
>> I'm just trying to use this for my sl28 driver. Some remarks, see 
>> below.
>> 
>> Am 2020-06-22 09:51, schrieb Lee Jones:
>> > The existing SYSCON implementation only supports MMIO (memory mapped)
>> > accesses, facilitated by Regmap.  This extends support for registers
>> > held behind I2C busses.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> > Changelog:
>> >
>> > v3 => v4
>> >   - Add ability to provide a non-default Regmap configuration
>> >
>> > v2 => v3
>> >   - Change 'is CONFIG' present check to include loadable modules
>> >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
>> > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
>> >
>> > v1 => v2
>> >   - Remove legacy references to OF
>> >   - Allow building as a module (fixes h8300 0-day issue)
>> >
>> > drivers/mfd/Kconfig            |   7 +++
>> >  drivers/mfd/Makefile           |   1 +
>> >  drivers/mfd/syscon-i2c.c       | 104 +++++++++++++++++++++++++++++++++
>> >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
>> >  4 files changed, 148 insertions(+)
>> >  create mode 100644 drivers/mfd/syscon-i2c.c
>> >  create mode 100644 include/linux/mfd/syscon-i2c.h
>> >
>> 
>> [..]
>> 
>> > +static struct regmap *syscon_i2c_get_regmap(struct i2c_client *client,
>> > +					    struct regmap_config *regmap_config)
>> > +{
>> > +	struct device *dev = &client->dev;
>> > +	struct syscon *entry, *syscon = NULL;
>> > +
>> > +	spin_lock(&syscon_i2c_list_slock);
>> > +
>> > +	list_for_each_entry(entry, &syscon_i2c_list, list)
>> > +		if (entry->dev == dev) {
>> > +			syscon = entry;
>> > +			break;
>> > +		}
>> > +
>> > +	spin_unlock(&syscon_i2c_list_slock);
>> > +
>> > +	if (!syscon)
>> > +		syscon = syscon_i2c_register(client, regmap_config);
>> > +
>> > +	if (IS_ERR(syscon))
>> > +		return ERR_CAST(syscon);
>> > +
>> > +	return syscon->regmap;
>> > +}
>> > +
>> > +struct regmap *syscon_i2c_to_regmap_config(struct i2c_client *client,
>> > +					   struct regmap_config *regmap_config)
>> > +{
>> > +	return syscon_i2c_get_regmap(client, regmap_config);
>> > +}
>> > +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap_config);
>> > +
>> > +struct regmap *syscon_i2c_to_regmap(struct i2c_client *client)
>> > +{
>> > +	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
>> > +}
>> > +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap);
>> 
>> What do you think about
>> 
>> struct regmap *syscon_i2c_to_regmap(struct device *dev)
>> {
>> 	struct i2c_client *client = i2c_verify_client(dev);
>> 
>> 	if (!client)
>> 		return ERR_PTR(-EINVAL);
>> 
>> 	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
>> }
>> 
>> Or even move it to syscon_i2c_get_regmap().
>> 
>> This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" 
>> just
>> to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do 
>> it
>> all over again in all sub drivers.
> 
> What is your use-case?

Still my sl28 mfd driver. There the sub devices just need a regmap.

>  This is set-up for based I2C drivers to call
> into.  'client' is given to them as their .probe() arg.

Ok, I see. Then this doesn't fit.

-michael

>> So you could just do a
>>   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
>> 
>> I've also noticed that the mmio syscon uses device_node as parameter. 
>> What
>> was the reason to divert from that? Just curious.
> 
> This is a helper for I2C clients.  There aren't any OF helpers in here
> (yet).  If you think they would be helpful we can add them.  How do
> you see them being used?
