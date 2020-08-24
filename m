Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89D24FB75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHXKcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:32:18 -0400
Received: from mailout04.rmx.de ([94.199.90.94]:38741 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHXKcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:32:18 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4BZpMx1LRJz3qxPc;
        Mon, 24 Aug 2020 12:32:13 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BZpMX3Q7Vz2TS6b;
        Mon, 24 Aug 2020 12:31:52 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.40) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 24 Aug
 2020 12:31:41 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Richard Leitner <richard.leitner@skidata.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add two new configuration drivers for Microchip USB hubs
Date:   Mon, 24 Aug 2020 12:31:40 +0200
Message-ID: <3231735.vQvGARyy4L@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200817075426.GA560469@pcleri>
References: <20200726084116.GD448215@kroah.com> <20200727083333.19623-1-ceggers@arri.de> <20200817075426.GA560469@pcleri>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.40]
X-RMX-ID: 20200824-123154-4BZpMX3Q7Vz2TS6b-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Monday, 17 August 2020, 09:54:26 CEST, Richard Leitner wrote:
> Hi Christian,
> sorry for the late reply. My MUA somehow didn't show me that series
> earlier...
likewise... I was on holiday last week.

> I haven't looked into the patches in detail, but at a first glance it
> looks like a lot copy-n-paste.
> Have you thought about merging the (after your series) 3 hub drivers
> into one? Something like a "microchip i2c usb hub driver"?
> Would that be feasible for your point of view?
I'm not sure about the criteria for having separate drivers vs. a combined 
one.
As changing the driver usually requires testing with real hardware, keeping 
them separate may be easier. On the other hand, I already synced some changes 
from usb251xb into "my" drivers, so it is likely that such work will also have 
to done in future.

Rob Herring already suggested to create a common yaml document for the
device tree bindings. It would probably make sense to share the device tree 
code between our drivers. But I would like to keep the "hardware" side of the 
drivers independent, as there are subtle differences between the different hub 
series.

Compared to usb251x, the new drivers don't write the full configuration memory 
of the hub (the configuration memory space is much bigger than 8 bit and has 
many holes). They rely on the defaults after hardware reset on perform read-
modify-write for the properties set in the device tree.

If the usb251xb hubs could be programmed in a similar way, merging all drivers 
should be possible using a mic_usb_hub_ops struct with function pointers for 
applying the (common) device tree properties (e.g. set_product_id(), 
set_device_id(), ..., set_oc_delay(), set_manufacturer_string(), ...).

Best regards
Christian




