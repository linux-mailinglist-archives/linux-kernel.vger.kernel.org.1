Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3C2C8753
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgK3O75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:59:57 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:53283 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgK3O74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:59:56 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id B37B0175A37
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:59:13 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jke1kjcR7Dlydjke1kXQmS; Mon, 30 Nov 2020 07:59:13 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=CakmGojl c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=gXLdhW2jAAAA:8 a=YfHuQ6WfqXg4DGKjl5kA:9
 a=QEXdDO2ut3YA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=Dn9eIPSr_RzuO0KTJioD:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PhxDst6bxvMrZJlbqwjEwlHuP3jCoB2Pdz3+Y0YB6RM=; b=liZ32ShVXOHVTGVczaXGId4W7/
        T3VVC9AoHCm3eYIlMk91os4YjU2uHpPSK6wLAJj7R+NU4e+JeS0iWHbttOKFNOpMlzILudIBTXJ3N
        xEteaLC9ZhYiU+h+Z7djCn66dWjE85BGYr6K9kO5Pc0dZwS95SsoJQ7ZALn00HgjH5/rPrt9lHq1H
        JsT+GUdXFUW147kth5F6mL26hKhZWzUAD3BdO/UOD1gJruwkXaHYXEAEzOMhxGJlBmLnz8IwirVl6
        ApGAUHaBGNkA4LEMuWfzrgIcUVDxMzti+QAHW6Vx0wKvT2vhVNwRhUqAtSKmWsXD+ApOZfzljrEAP
        KFwqFZSw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55722 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjke0-0034uB-PF; Mon, 30 Nov 2020 14:59:12 +0000
Date:   Mon, 30 Nov 2020 06:59:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Charles <hsu.yungteng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
Subject: Re: [PATCH v5] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
Message-ID: <20201130145912.GA17093@roeck-us.net>
References: <f8766ea1-b4ee-f298-a5a4-dc83f9a54617@gmail.com>
 <20201127161051.GA9881@roeck-us.net>
 <5c78a15e-4c4a-992c-ff5b-7bb709057871@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c78a15e-4c4a-992c-ff5b-7bb709057871@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjke0-0034uB-PF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:55722
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 13
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:46:19PM +0800, Charles wrote:
> On 28/11/2020 上午12:10, Guenter Roeck wrote:
> > On Fri, Nov 27, 2020 at 09:59:01AM +0800, Charles wrote:
> > > Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
> > > 
> > > the output voltage use the MFR_READ_VOUT 0xD4
> > > vout value returned is linear11
> > > 
> > > Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
> > This patch (again) didn't make it to any of the mailing lists.
> > Please try to find out why this is the case. I usually pick up
> > patches from https://patchwork.kernel.org/project/linux-hwmon/list/,
> > and may easily miss a patch if I can't find it there.
> > 
> > > ---
> > > 
> > > v5:
> > >   - Add MAINTAINERS
> > >   - Add a reference into trivial-devices.yaml
> > > v4:
> > >   - Add pm6764tr to Documentation/hwmon/index.rst.
> > > v3:
> > >   - Add Documentation(Documentation/hwmon/pm6764tr.rst).
> > >   - Fix include order.
> > > v2:
> > >   - Fix formatting.
> > >   - Remove pmbus_do_remove.
> > >   - Change from .probe to .probe_new.
> > > v1:
> > >   - Initial patchset.
> > > 
> > > ---
> > > 
> > >   .../devicetree/bindings/trivial-devices.yaml  |  2 +
> > >   Documentation/hwmon/index.rst                 |  1 +
> > >   Documentation/hwmon/pm6764tr.rst              | 33 ++++++++
> > >   MAINTAINERS                                   |  7 ++
> > >   drivers/hwmon/pmbus/Kconfig                   |  9 +++
> > >   drivers/hwmon/pmbus/Makefile                  |  1 +
> > >   drivers/hwmon/pmbus/pm6764tr.c                | 76 +++++++++++++++++++
> > >   7 files changed, 129 insertions(+)
> > >   create mode 100644 Documentation/hwmon/pm6764tr.rst
> > >   create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > > index ab623ba930d5..cdd7bdb6abbb 100644
> > > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > > @@ -348,6 +348,8 @@ properties:
> > >             - socionext,synquacer-tpm-mmio
> > >               # i2c serial eeprom  (24cxx)
> > >             - st,24c256
> > > +            # SMBus/I2C Voltage Regulator
> > > +          - st,pm6764tr
> > >               # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> > >             - taos,tsl2550
> > >               # 8-Channels, 12-bit ADC
> > This, like all devicetre changes, needs to be a separate patch.
> > Also, please make sure to copy dt maintainers and the dt mailing list
> > when you send that patch.
> 
> 
> Thank you for your suggestions.
> 
> I will send that patch as soon as possible.
> 
> 
> > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > index b797db738225..1bbd05e41de4 100644
> > > --- a/Documentation/hwmon/index.rst
> > > +++ b/Documentation/hwmon/index.rst
> > > @@ -144,6 +144,7 @@ Hardware Monitoring Kernel Drivers
> > >      pc87360
> > >      pc87427
> > >      pcf8591
> > > +   pm6764tr
> > >      pmbus
> > >      powr1220
> > >      pxe1610
> > > diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
> > > new file mode 100644
> > > index 000000000000..5e8092e39297
> > > --- /dev/null
> > > +++ b/Documentation/hwmon/pm6764tr.rst
> > > @@ -0,0 +1,33 @@
> > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +Kernel driver pm6764tr
> > > +======================
> > > +
> > > +Supported chips:
> > > +
> > > +  * ST PM6764TR
> > > +
> > > +    Prefix: 'pm6764tr'
> > > +
> > > +    Addresses scanned: -
> > > +
> > > +    Datasheet: http://www.st.com/resource/en/data_brief/pm6764.pdf
> > > +
> > > +Authors:
> > > +	<hsu.yungteng@gmail.com>
> > > +
> > > +Description:
> > > +------------
> > > +
> > > +This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
> > > +performance digital controller designed to power Intel’s VR12.5 processors and memories.
> > > +
> > Unrelated side note: I understand this means that you are forced to keep the
> > datasheet under wraps, which in turn means I can not suggest functionality
> > improvements since I don't have access to it. If the chip happens to support
> > per-rail telemetry, you might want to consider adding support for that in a
> > follow-up patch.
> > 
> > > +The device utilizes digital technology to implement all control and power management
> > > +functions to provide maximum flexibility and performance. The NVM is embedded to store
> > > +custom configurations. The PM6764TR device features up to 4-phase programmable operation.
> > > +
> > > +The PM6764TR supports power state transitions featuring VFDE, and programmable DPM
> > > +maintaining the best efficiency over all loading conditions without compromising transient
> > > +response. The device assures fast and independent protectionagainstload overcurrent,
> > "protectionagainstload" -> "protection against load"
> > 
> > > +under/overvoltage and feedback disconnections.
> > > +
> > Drop empty line at end.
> > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 94ac10a153c7..a3fea132c4ed 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13904,6 +13904,13 @@ M:	Logan Gunthorpe <logang@deltatee.com>
> > >   S:	Maintained
> > >   F:	drivers/dma/plx_dma.c
> > Add empty line.
> 
> 
> There is an empty line here,
> 
> Should I add one more empty line?
> 
One empty line is needed. Maybe I missed it. I am looking forward to the
next version of your patch; then we'll see.

Thanks,
Guenter
