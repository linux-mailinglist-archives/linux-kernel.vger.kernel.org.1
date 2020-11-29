Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C412C7A06
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgK2QjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:39:13 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38630 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2QjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:39:13 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjPiS-0004tM-O4; Sun, 29 Nov 2020 17:38:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Yao <markyao0591@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/rockchip: Avoid uninitialized use of endpoint id in LVDS
Date:   Sun, 29 Nov 2020 17:38:22 +0100
Message-Id: <160666788608.935311.17420179487951916810.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110200430.1713467-1-paul.kocialkowski@bootlin.com>
References: <20201110200430.1713467-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 21:04:30 +0100, Paul Kocialkowski wrote:
> In the Rockchip DRM LVDS component driver, the endpoint id provided to
> drm_of_find_panel_or_bridge is grabbed from the endpoint's reg property.
> 
> However, the property may be missing in the case of a single endpoint.
> Initialize the endpoint_id variable to 0 to avoid using an
> uninitialized variable in that case.

Applied, thanks!

[1/1] drm/rockchip: Avoid uninitialized use of endpoint id in LVDS
      commit: aec9fe892812ed10d0bffcf309d2a8fc380d8ce6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
