Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E082FDAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbhATUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:20:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50910 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388550AbhATURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:17:41 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1l2JuK-001haq-L0; Wed, 20 Jan 2021 21:16:48 +0100
Date:   Wed, 20 Jan 2021 21:16:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Alexander Graf <graf@amazon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
Message-ID: <YAiPsJ3B4ry0H3tk@lunn.ch>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
 <171d8c3f-aa0c-4416-b0d7-d35a47c7acc3@amazon.com>
 <78D5E843-42FC-4186-9D94-30F067FA9EAD@caramail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78D5E843-42FC-4186-9D94-30F067FA9EAD@caramail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> @@ -1218,6 +1218,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
> >>  F:	Documentation/admin-guide/LSM/apparmor.rst
> >>  F:	security/apparmor/
> >> +APPLE ADVANCED INTERRUPT CONTROLLER DRIVER
> >> +M:	Stan Skowronek <stan@corellium.com>
> > 
> > Signing someone else up for maintainership is ... unusual :). Do you have buy in from Stan that he'll be responsive and handle patch reviews?
> 
> Yeah, I asked Corellium about it explicitly. :)

Having an Ack-by: from Stan Skowronek would remove all doubt.

       Andrew
