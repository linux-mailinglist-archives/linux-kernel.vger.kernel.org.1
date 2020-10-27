Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCE29C0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818392AbgJ0RTc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Oct 2020 13:19:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46567 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782511AbgJ0O5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:57:08 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kXQP4-0006mx-IB; Tue, 27 Oct 2020 15:56:50 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kXQP2-0004zR-6Y; Tue, 27 Oct 2020 15:56:48 +0100
Message-ID: <646d8a1e39b403803500218b62138cce440950be.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] drm/imx: tve remove extraneous type qualifier
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Tue, 27 Oct 2020 15:56:48 +0100
In-Reply-To: <20201026194110.3817470-2-arnd@kernel.org>
References: <20201026194110.3817470-1-arnd@kernel.org>
         <20201026194110.3817470-2-arnd@kernel.org>
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

On Mon, 2020-10-26 at 20:41 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about functions returning a 'const int' result:
> 
> drivers/gpu/drm/imx/imx-tve.c:487:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
> 
> Remove the extraneous 'const' qualifier here. I would guess that the
> function was intended to be marked __attribute__((const)) instead,
> but that would also be wrong since it call other functions without
> that attribute.
> 
> Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you, applied to imx-drm/next with Nick's R-b.

regards
Philipp
