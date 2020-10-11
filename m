Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D128A934
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgJKSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:18:08 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59198 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgJKSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:18:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 848608030867;
        Sun, 11 Oct 2020 18:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gc8x9YjfPu2z; Sun, 11 Oct 2020 21:18:05 +0300 (MSK)
Date:   Sun, 11 Oct 2020 21:18:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/18] dt-bindings: usb: keystone-dwc3: Validate DWC3
 sub-node
Message-ID: <20201011181804.wcygvlyzhom2pg5d@mobilestation>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-18-Sergey.Semin@baikalelectronics.ru>
 <874c8ba6-bd0c-4f4e-f4ee-29c7f6ae563a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874c8ba6-bd0c-4f4e-f4ee-29c7f6ae563a@gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 12:04:06PM +0300, Sergei Shtylyov wrote:
> On 11.10.2020 1:41, Serge Semin wrote:
> 
> > TI Keystone DWC3 compatible DT node is supposed to have a DWC USB3
> > compatible sub-node to describe a fully functioning USB interface.
> > Since DWC USB3 has now got a DT schema describing it' DT node, let's make
>                                                     ^^^ its?

Ok. Thanks.

-Sergey

> 
> > sure the TI Keystone DWC3 sub-node passes validation against it.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> [...]
> 
> MBR, Sergei
