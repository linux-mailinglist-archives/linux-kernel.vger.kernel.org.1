Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A222B1E06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKMPEM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Nov 2020 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKMPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:04:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EAC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:04:11 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kdacT-00023V-Kn; Fri, 13 Nov 2020 16:04:09 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kdacT-0004cD-49; Fri, 13 Nov 2020 16:04:09 +0100
Message-ID: <0f679c62aa48603ea43a8fa4819d688baa802d73.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: make shared pulsed reset controls
 re-triggerable
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 13 Nov 2020 16:04:09 +0100
In-Reply-To: <20201112230043.28987-1-aouledameur@baylibre.com>
References: <20201112230043.28987-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 00:00 +0100, Amjad Ouled-Ameur wrote:
> The current reset framework API does not allow to release what is done by
> reset_control_reset(), IOW decrement triggered_count. Add the new
> reset_control_rearm() call to do so.
> 
> When reset_control_reset() has been called once, the counter
> triggered_count, in the reset framework, is incremented i.e the resource
> under the reset is in-use and the reset should not be done again.
> reset_control_rearm() would be the way to state that the resource is
> no longer used and, that from the caller's perspective, the reset can be
> fired again if necessary.
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Change since v1: [0]
> * Renamed the new call from reset_control_(array_)resettable to 
> reset_control_(array_)rearm
> * Open-coded reset_control_array_rearm to check for errors before
> decrementing triggered_count because we cannot roll back in case an
> error occurs while decrementing one of the rstc.
> * Reworded the new call's description.

Thank you, applied to reset/next.

regards
Philipp
