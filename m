Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C8295D00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444190AbgJVKxZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Oct 2020 06:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444169AbgJVKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:53:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:53:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kVYDg-0007Ag-OS; Thu, 22 Oct 2020 12:53:20 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kVYDg-0000bs-B3; Thu, 22 Oct 2020 12:53:20 +0200
Message-ID: <8d6b660054e737b2cba7f0f82763f5e545cf68c0.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: meson: make it possible to build as a module
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Date:   Thu, 22 Oct 2020 12:53:20 +0200
In-Reply-To: <20201019144809.943608-1-narmstrong@baylibre.com>
References: <20201019144809.943608-1-narmstrong@baylibre.com>
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

Hi Neil,

thank you for the patch.

On Mon, 2020-10-19 at 16:48 +0200, Neil Armstrong wrote:
> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the reset controller driver as a module.
> 
> This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")

I've changed this to:

This partially reverts commit 8290924e6878 ("reset: meson: make it
explicitly non-modular").

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Applied to reset/next with Martin's R-b.

regards
Philipp
