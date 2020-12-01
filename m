Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8D2CA4A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbgLAN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:57:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:46176 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAN5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:57:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C914BFB03;
        Tue,  1 Dec 2020 14:56:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6vslrzR7idRW; Tue,  1 Dec 2020 14:56:20 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 85BED4068E; Tue,  1 Dec 2020 14:56:20 +0100 (CET)
Date:   Tue, 1 Dec 2020 14:56:20 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] usb: typec: tps6598x: Export some power supply
 properties
Message-ID: <20201201135620.GA306177@bogon.m.sigxcpu.org>
References: <cover.1606827507.git.agx@sigxcpu.org>
 <ee2df27df04e6ff01d15255665458be1000dcfa8.1606827507.git.agx@sigxcpu.org>
 <CAHp75VdwnGD+39AHusGvSKcnOZs7q_AfXniTBaA+J=yMqL4_nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdwnGD+39AHusGvSKcnOZs7q_AfXniTBaA+J=yMqL4_nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
On Tue, Dec 01, 2020 at 03:52:40PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 1, 2020 at 2:59 PM Guido Günther <agx@sigxcpu.org> wrote:
> > This allows downstream supplies and userspace to detect
> > whether external power is supplied.
> 
> ...
> 
> > +static int devm_tps6598_psy_register(struct tps6598x *tps)
> > +{
> > +       struct power_supply_config psy_cfg = {};
> > +       const char *port_dev_name = dev_name(tps->dev);
> 
> > +       size_t psy_name_len = strlen(tps6598x_psy_name_prefix) +
> > +                                    strlen(port_dev_name) + 1;
> 
> I'm so sorry by not noticing this one...
> 
> > +       char *psy_name;
> > +
> > +       psy_cfg.drv_data = tps;
> > +       psy_cfg.fwnode = dev_fwnode(tps->dev);
> > +       psy_name = devm_kzalloc(tps->dev, psy_name_len, GFP_KERNEL);
> > +       if (!psy_name)
> > +               return -ENOMEM;
> > +
> > +       snprintf(psy_name, psy_name_len, "%s%s", tps6598x_psy_name_prefix,
> > +                port_dev_name);
> 
> ...followed by this.
> 
> Please, use devm_kasprintf() instead.

Will do. I'll let the series sit for a couple of days before sending a
v5.
Cheers,
 -- Guido

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
