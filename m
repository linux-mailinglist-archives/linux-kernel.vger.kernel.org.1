Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD282CFAF3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgLEKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:09:11 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47410 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgLEKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:01:35 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 00F60201107;
        Sat,  5 Dec 2020 09:05:29 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A059220EC6; Sat,  5 Dec 2020 09:55:46 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:55:46 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pcmcia: at91_cf: move definitions locally
Message-ID: <X8tLEqILXdQDGEme@light.dominikbrodowski.net>
References: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
 <160621597363.1087931.2225027989675268841.b4-ty@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160621597363.1087931.2225027989675268841.b4-ty@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Nov 24, 2020 at 12:07:30PM +0100 schrieb Alexandre Belloni:
> On Wed, 30 Sep 2020 20:48:02 +0200, Alexandre Belloni wrote:
> > struct at91_cf_data is only used in the driver since all the platforms moved
> > to device tree, move its definition locally.
> 
> I've now applied those patches on the at91-drivers branch, please shout if you
> want them to go through your branch.
> 
> [1/2] pcmcia: at91_cf: move definitions locally
>       commit: 496e9b64d7297d3e6c209c51218cee2939694b25
> [2/2] pcmcia: at91_cf: remove platform data support
>       commit: 91be3e89f450aa738204f6629f06d8b0e3d8d77b

Thanks, I'm fine with that.

	Dominik
