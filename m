Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4E28A930
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgJKSOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:14:35 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59158 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgJKSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:14:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6F36F8030867;
        Sun, 11 Oct 2020 18:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ghhd_t_Bpdk5; Sun, 11 Oct 2020 21:14:31 +0300 (MSK)
Date:   Sun, 11 Oct 2020 21:14:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/18] dt-bindings: usb: dwc3: Add Tx De-emphasis
 restrictions
Message-ID: <20201011181430.w5dkhc67qml7l4bk@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-14-Sergey.Semin@baikalelectronics.ru>
 <4b256e47-d058-a74f-0ad1-677886a03e74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b256e47-d058-a74f-0ad1-677886a03e74@gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 11:56:21AM +0300, Sergei Shtylyov wrote:
> On 11.10.2020 1:41, Serge Semin wrote:
> 
> > In accordance with the driver comments the PIPE3 de-emphasis can be tunned
> 

>    Tuned.

Oh. My spell checker accepted this as past participle of the verb "tun" .)

> 
> > to be either -6dB, or -2.5dB or disabled. Let's add the de-emphasis
> 

>    Either -6dB, -2.5dB, or disabled?

Hm, I always thought that "or" is supposed to be placed before each alternative
in the either-or construction, like "either ... or ... or ... or ...". Am I wrong?

-Sergey

> 
> > property restriction so the DT schema would make sure the controller DT
> > node is equipped with correct values.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> [...]
> 
> MBR, Sergei
