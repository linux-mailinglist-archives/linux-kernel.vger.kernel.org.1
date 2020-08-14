Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3110244D81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHNRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:23:24 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47860 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgHNRXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:23:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0B015FB03;
        Fri, 14 Aug 2020 19:23:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cirbr_6XKokd; Fri, 14 Aug 2020 19:23:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3D040457CC; Fri, 14 Aug 2020 19:23:20 +0200 (CEST)
Date:   Fri, 14 Aug 2020 19:23:20 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Camera LED on Librem 5 was Re: [PATCH] backlight: add
 led-backlight driver
Message-ID: <20200814172320.GA740513@bogon.m.sigxcpu.org>
References: <20200219191412.GA15905@amd>
 <20200220082956.GA3383@bogon.m.sigxcpu.org>
 <20200220234151.GB1544@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220234151.GB1544@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Fri, Feb 21, 2020 at 12:41:51AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This patch adds a led-backlight driver (led_bl), which is similar to
> > > pwm_bl except the driver uses a LED class driver to adjust the
> > > brightness in the HW. Multiple LEDs can be used for a single backlight.
> > 
> > Tested-by: Guido Günther <agx@sigxcpu.org>
> 
> Thanks for testing!
> 
> I noticed blog post about using Librem 5 torch. Unfortunately, it used
> very strange/non-standard interface, first using LED as a GPIO to
> enable LED controller, then direct i2c access. That is not acceptable
> interface for mainline, and it would be better not to advertise such
> code, as it will likely become broken in future.

I agree, there's a driver for the lm3560 in media/ but how would one
expose the torch part as a LED? It seems you hit something similar in

    https://lkml.org/lkml/2018/5/6/30

I also couldn't find an in tree driver that registers a flashlight
as a v4l subdev. Did i miss that?

Cheers,
 -- Guido
