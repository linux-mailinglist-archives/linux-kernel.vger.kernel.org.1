Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9842CA35C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgLANAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44966 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbgLANAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1AAAAFB06;
        Tue,  1 Dec 2020 14:00:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jBBmTbO464kn; Tue,  1 Dec 2020 14:00:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 220794068E; Tue,  1 Dec 2020 14:00:12 +0100 (CET)
Date:   Tue, 1 Dec 2020 14:00:12 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: typec: tps6598x: Export some power supply
 properties
Message-ID: <20201201130012.GA303449@bogon.m.sigxcpu.org>
References: <cover.1606481420.git.agx@sigxcpu.org>
 <91c27b323786445f6b33c6a7e89e93755d05e3a2.1606481420.git.agx@sigxcpu.org>
 <CAHp75VeLZtm85Y=3QMkPGb332wn05-zr-_mrrwXvnqLhazR1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeLZtm85Y=3QMkPGb332wn05-zr-_mrrwXvnqLhazR1Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Nov 30, 2020 at 08:35:26PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 27, 2020 at 2:57 PM Guido Günther <agx@sigxcpu.org> wrote:
> >
> > This allows downstream supplies and userspace to detect
> > whether external power is supplied.
> 
> > +       if (!(pwr_status & TPS_POWER_STATUS_CONNECTION) ||
> > +           !(pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
> > +               val->intval = 0;
> > +       } else {
> > +               val->intval = 1;
> > +       }
> 
> Can we please use positive conditionals (which usually are easier to
> read)?

Make sense. Fixed in v4.
 -- Guido

> 
>        if ((pwr_status & TPS_POWER_STATUS_CONNECTION) &&
>            (pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
>                val->intval = 1;
>        } else {
>                val->intval = 0;
>        }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
