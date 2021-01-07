Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F92ECC93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbhAGJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:20:15 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59EC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:19:35 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2FFCF22FFC;
        Thu,  7 Jan 2021 10:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610011169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lkymuyrUAi4MoR91Xr/Qm8hIvl1yFt2zm4h2BQJRI4=;
        b=hpSdZyIcxfnahmDkdlQ6y/os8qYzqZJkEqqMZnfMTz2GrOzX/OA3Pq7LC3xS6mXxqA8R4j
        imp82yOpgH5ETCX+v5PgnEE92XfVqe7v7lQOLLOZUqEKSbugTJt7W6nQZOjAR4D1Dh2cyz
        gVW+kqa/cAGjEVKyBCEl7MJJB1o3zdw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 10:19:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
In-Reply-To: <X/bNxMPWKq2nbqS4@kroah.com>
References: <20210106232641.459081-1-saravanak@google.com>
 <X/bNxMPWKq2nbqS4@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <85acc1d3523a3c6f88687d3491f83380@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-07 10:00, schrieb Greg Kroah-Hartman:
> On Wed, Jan 06, 2021 at 03:26:41PM -0800, Saravana Kannan wrote:
>> The device link device's name was of the form:
>> <supplier-dev-name>--<consumer-dev-name>
>> 
>> This can cause name collision as reported here [1] as device names are
>> not globally unique. Since device names have to be unique within the
>> bus/class, add the bus/class name as a prefix to the device names used 
>> to
>> construct the device link device name.
>> 
>> So the devuce link device's name will be of the form:
>> <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>
> 
> Minor nit, you forgot a ':' in the consumer side of the link here.  The
> code is correct.
> 
>> 
>> [1] - 
>> https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
>> Reported-by: Michael Walle <michael@walle.cc>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> ---
>> 
>> Michael,
>> 
>> Can you please test this? This should fix your issue.
>> 
>> Having said that, do you have some local DT changes when you are 
>> testing
>> this? Because it's not obvious from the DT in upstream what dependency
>> is even being derived from the firmware. I don't see any dependency in
>> upstream DT files between mdio_bus/0000:00:00.1 and
>> pci0000:00/0000:00:00.1
> 
> That looks really odd, why is the mdio bus using the same names as the
> pci bus?

Logically the MDIO bus belongs to the ENETC, although its actually an 
own
PCI device [1]. What do you think its name should be?

> But anyway, your dev_bus_name() change here looks good, I'll take that
> as a separate patch no matter what happens here :)

I'm just testing this patch, looks like it doesn't fix it for now. But
anyways. Shouldn't there be a Fixes tag for this patch? I.e. 5.11 is
broken right now.

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/freescale/enetc/enetc_pf.c#L748

-michael
