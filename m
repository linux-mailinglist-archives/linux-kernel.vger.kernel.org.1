Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3A26B9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIPCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:14:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39801 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726298AbgIPCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:14:23 -0400
Received: (qmail 1024888 invoked by uid 1000); 15 Sep 2020 22:14:21 -0400
Date:   Tue, 15 Sep 2020 22:14:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200916021421.GA1024554@rowland.harvard.edu>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop>
 <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915230345.GF2771744@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:03:45PM -0700, Matthias Kaehlcke wrote:
> Hi Peter,
> 
> On Tue, Sep 15, 2020 at 07:05:38AM +0000, Peter Chen wrote:

> > Whether or not it is a wakeup_source, it could get through its or its children's
> > /sys/../power/wakeup value, you have already used usb_wakeup_enabled_descendants
> > to know it.
> 
> I conceptually agree, but in practice there are some conflicting details:
> 
> wakeup for the hubs on my system is by default disabled, yet USB wakeup works
> regardless, so the flag doesn't really provide useful information. I guess we
> could still use it if there is no better way, but it doesn't seem ideal.

The wakeup setting for USB hubs affects only the following events: port 
connect, port disconnect, and port overcurrent.  It does not refer to 
forwarding wakeup requests from downstream USB devices; that is always 
enabled.  So maybe your wakeup flag really is accurate and you didn't 
realize it.

> Similar for udev->bus->controller, according to sysfs it doesn't even have wakeup
> support. Please let me know if there is a reliable way to check if wakeup is
> enabled on the controller of a device.

The host controller's sysfs wakeup setting should always be correct.  If 
it isn't, that indicates there is a bug in the host controller driver or 
the corresponding platform-specific code.  What driver does your system 
use?

Alan Stern
