Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694FF1E5DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgE1LDq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 May 2020 07:03:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:24237 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbgE1LDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:03:46 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 59C07240003;
        Thu, 28 May 2020 11:03:43 +0000 (UTC)
Date:   Thu, 28 May 2020 13:03:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/platform: Avoid compilation warning
Message-ID: <20200528130342.219f8a44@xps13>
In-Reply-To: <20200527183555.GA2512243@bogus>
References: <20200514170707.24466-1-miquel.raynal@bootlin.com>
        <20200527183555.GA2512243@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Wed, 27 May 2020 12:35:55 -0600:

> On Thu, May 14, 2020 at 07:07:07PM +0200, Miquel Raynal wrote:
> > The of_find_device_by_node() helper has its dummy counterpart for when
> > CONFIG_OF is not enabled. However, it is clearly stated in the kernel
> > documentation that it "takes a reference to the embedded struct device
> > which needs to be dropped after use". Which means the of_dev_put()
> > helper might have to be called afterwards. Unfortunately, there is no
> > of_dev_put() dummy function if OF_CONFIG is not enabled which seems
> > odd in this case. The of_dev_put() helper is pretty simple, it just
> > checks the validity of the single argument and calls put_device() on
> > it. One can just call put_device() directly to avoid any build issue
> > but I find much more accurate in this case to create the dummy
> > helper.
> > 
> > With this helper, a file using of_find_device_by_node() can also call
> > of_dev_put() without triggering the following:  
> 
> IMO, you should use platform_device_put() instead. It has the NULL check 
> too.
> 
> I imagine of_dev_put() is left over from when OF devices were not 
> platform devices. 

Ok, makes sense. Perhaps we should entirely get rid of it, I don't see
a lot of users left. Or at least update the comment I was mentioning.

Cheers,
Miquèl
