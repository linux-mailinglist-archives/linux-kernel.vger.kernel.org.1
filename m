Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2661E2FE7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbhAUKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbhAUKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:42:10 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0278C0613D3;
        Thu, 21 Jan 2021 02:41:28 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0B01622FAD;
        Thu, 21 Jan 2021 11:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611225687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDILWN2Qt0CRRMnHqdXZCjQvogas/S8Dy2MJuaJxQKk=;
        b=jC+SKLV/orq38gIrVKvQRdKd4J76RPnn0LqF4Vr8EwOfVD+f7XzPpnSFWHjDxMBql+/Ieb
        SUfOJajVatGzvLP2keWDGOdIYF9LNZAo00vXfO4Hil4mGO+XRb/PAOiOw1/hH5jsZbW4jp
        fyYxBLtSI35wjK6PQLFjp3ngBkrfckQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jan 2021 11:41:26 +0100
From:   Michael Walle <michael@walle.cc>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
In-Reply-To: <8917c9a1-09e9-0a39-5732-da7f555ae9ad@xilinx.com>
References: <20210120194033.26970-1-michael@walle.cc>
 <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
 <aa96fcaa362181d4b6fef9f1de0aa914@walle.cc>
 <0a1c6ebf-1d5b-4f06-56db-f04e87d2ae9a@xilinx.com>
 <bd86194a13882ce472764d0c91029e33@walle.cc>
 <8917c9a1-09e9-0a39-5732-da7f555ae9ad@xilinx.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <df072e37bb6f3500d713be565cfa1328@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-01-21 11:23, schrieb Michal Simek:
>>> Back to your case. Board is cheap which is not all the time case for 
>>> any
>>> xilinx board but you have only uart, sd and partially described 
>>> ethernet
>>> which doesn't work without PL. Is it worth to have this described?
>> 
>> I got your point. But it is at least a jump start for the users if 
>> that
>> board boots out of the box. And yes, its unfortunate, that ethernet
>> just works if the PL is configured. This is already done by the
>> bootloader, because there I do have the same problem.
> 
> Zynq/ZynqMP boards can use U-Boot SPL. "Advantage" of this solution
> especially for Zynq is that in u-boot there is open a way for adding
> ps7_init file which is determined by device tree name.
> I think it would make sense to add these DTs and also ps7_init to 
> U-Boot
> project and wire it up with zynq_virt platform and then you can boot
> Linux with using U-Boot's DT pointed by $fdtcontroladdr.
> Then you will get support from scratch to be able to boot.

I already have patches for u-boot (using SPL). But my impression was
that linux is the master for the device trees. Esp. if there are some
problems with the board its often useful to have an in-tree device
tree.

What is the difference between this board and the other zynq boards
in the kernel?

In any case, please make this decision now: will you accept this
device tree or not?

-michael
