Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3101C6CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgEFJ0t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 May 2020 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728385AbgEFJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:26:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79459C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:26:48 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWGK5-0000MG-HH; Wed, 06 May 2020 11:26:37 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWGK2-0004UH-Q5; Wed, 06 May 2020 11:26:34 +0200
Message-ID: <b1af9917885ee3da60de1385edd2d8094ecb3b7d.camel@pengutronix.de>
Subject: Re: [PATCH v2 22/91] reset: Move reset-simple header out of
 drivers/reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Wed, 06 May 2020 11:26:34 +0200
In-Reply-To: <6f7651682a6dab539bd89c80704c8303bbae68bd.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
         <6f7651682a6dab539bd89c80704c8303bbae68bd.1587742492.git-series.maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-24 at 17:34 +0200, Maxime Ripard wrote:
> The reset-simple code can be useful for drivers outside of drivers/reset
> that have a few reset controls as part of their features. Let's move it to
> include/linux/reset.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Do you need the reset patches applied together with this series, or can
I pick them up individually?

regards
Philipp
