Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4A2A3F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKCI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:58:33 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43036 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:58:31 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id E51CC3A587F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:58:29 +0000 (UTC)
Received: from localhost (unknown [82.66.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C4A0820000C;
        Tue,  3 Nov 2020 08:58:04 +0000 (UTC)
Date:   Tue, 3 Nov 2020 10:04:12 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de, lorenzo.pieralisi@arm.com, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
Message-ID: <20201103090412.GC15700@pilgrim>
References: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Nov 03, 2020 at 12:37:54PM +0800, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Reviewed-by: Remi Pommarel <repk@triplefau.lt> for phy-meson-axg-pcie

Thanks.
