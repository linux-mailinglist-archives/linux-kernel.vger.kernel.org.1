Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC2275810
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIWMfQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Sep 2020 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:35:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF708C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:35:15 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kL3zJ-00029b-Th; Wed, 23 Sep 2020 14:35:09 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kL3zI-0008C7-Vc; Wed, 23 Sep 2020 14:35:08 +0200
Message-ID: <4f219a6706413718183028f6afadd6788d385a81.camel@pengutronix.de>
Subject: Re: [PATCH] reset: sti: reset-syscfg: fix struct description
 warnings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Sep 2020 14:35:08 +0200
In-Reply-To: <20200831203804.6568-1-avolmat@me.com>
References: <20200831203804.6568-1-avolmat@me.com>
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

Hi Alain,

On Mon, 2020-08-31 at 22:38 +0200, Alain Volmat wrote:
> Fix formating of struct description to avoid warning highlighted
> by W=1 compilation.
> 
> Fixes: e5d76075d930 ("drivers: reset: STi SoC system configuration reset controller support")
> Signed-off-by: Alain Volmat <avolmat@me.com>

Thank you, applied to reset/next.

regards
Philipp
