Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E32A0C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3RkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:40:17 -0400
Received: from mout02.posteo.de ([185.67.36.66]:59121 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgJ3RkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:40:16 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 168D32400FD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 18:40:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1604079614; bh=yaNOzCfAbNWRb2S7dy1QrF/tHbU4tC0F05OmkpAEogM=;
        h=Date:From:To:Cc:Subject:From;
        b=jj5s0fpArZGYjSXT+P9KvvOxzW2zrJAxx1ofDoCMcJjFvhmDZA1NxxxFSYLoWIRmq
         TkWj777jYrTz2OmwUqC8P7giwDcWLzLxVCpHls1NEnP7kI8ukgg+SdomV5T8C4p10y
         BIB+/SYd4Fr8PIuDkXbOX/dsfFI+GSwjH3xc3bYXQOFV8qfAIjFlkqIYPm705U82KN
         +VMmdIiSE8crHqMYTUyQdNALac5s10xCvT2LJXYZBF3JMzqw2ysIdDFRqsrb+6iaNi
         DyN/Z7tCZkak8N2Ge0p7S6jp/6FBZanx0w6OWQSZcJ2m8wA4RLhGVN9WshR1e07OuW
         5Jj16hF4wZrVw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CN8hs37Tvz9rxP;
        Fri, 30 Oct 2020 18:40:13 +0100 (CET)
Date:   Fri, 30 Oct 2020 18:40:08 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [RESEND PATCH v3] hwmon: add Corsair PSU HID controller driver
Message-ID: <20201030184008.4d15b36a@monster.powergraphx.local>
In-Reply-To: <20201030173323.GA38219@roeck-us.net>
References: <20201030053831.GA4943@monster.powergraphx.local>
        <20201030173323.GA38219@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 10:33:23 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Oct 30, 2020 at 06:38:31AM +0100, Wilken Gottwalt wrote:
> > The Corsair digital power supplies of the series RMi, HXi and AXi include
> > a small micro-controller with a lot of sensors attached. The sensors can
> > be accessed by an USB connector from the outside.
> > 
> > This micro-controller provides the data by a simple proprietary USB HID
> > protocol. The data consist of temperatures, current and voltage levels,
> > power usage, uptimes, fan speed and some more. It is also possible to
> > configure the PSU (fan mode, mono/multi-rail, over current protection).
> > 
> > This driver provides access to the sensors/statistics of the RMi and HXi
> > series power supplies. It does not support configuring these devices,
> > because there would be many ways to misconfigure or even damage the PSU.
> > 
> > This patch adds:
> > - hwmon driver corsair-psu
> > - hwmon documentation
> > - updates MAINTAINERS
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> No need to resend. It is in my queue.
> 

Oh, I thought you didn't get it before. I noticed you had some mail trouble,
too. Just wanted to be sure mailing worked this time.

greetings,
Wilken
