Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEC22ACA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGWKea convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Jul 2020 06:34:30 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49589 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgGWKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:34:29 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8D6EB20014;
        Thu, 23 Jul 2020 10:34:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b86d9dbf-f7b0-e741-4dfa-2d76972d38f1@amazon.com>
References: <20200324104918.29578-1-hhhawa@amazon.com> <158946977180.3480.12435085393834819053@kwain> <CAK8P3a3ndL0U=Q1HAxd3oTPfO6WwQZM3yQvr-TQEnA3ZzhQNYQ@mail.gmail.com> <b86d9dbf-f7b0-e741-4dfa-2d76972d38f1@amazon.com>
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     "Hawa, Hanna" <hhhawa@amazon.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Cc:     benh@amazon.com, arm-soc <arm@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Talel Shenhar <talel@amazon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        jonnyc@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>
Message-ID: <159550046312.2959327.11902585526151715310@kwain>
Date:   Thu, 23 Jul 2020 12:34:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hanna, Arnd,

Quoting Hawa, Hanna (2020-07-23 12:20:02)
> On 7/23/2020 1:10 PM, Arnd Bergmann wrote:
> > 
> > I just came across this old series and noticed we had never merged it.
> > 
> > I don't know if the patches all still apply. Could you check and perhaps
> > resend tosoc@kernel.org  if they are still good to go into the coming
> > merge window?

> Sure, will rebase the patches and send ASAP.

Thanks Hanna!

It seems Tsahee, the original Alpine maintainer, is not active anymore;
I guess I'll need to do better and set up everything required to send
real pull requests for next releases as activity on Alpine happens from
time to time.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
