Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71071BADB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD0TSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:18:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46146 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0TSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:18:44 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9H6-0008PW-LV; Mon, 27 Apr 2020 21:18:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static
Date:   Mon, 27 Apr 2020 21:18:37 +0200
Message-Id: <158801509401.47920.2598441742545466292.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200426161653.7710-1-enric.balletbo@collabora.com>
References: <20200426161653.7710-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 18:16:53 +0200, Enric Balletbo i Serra wrote:
> This fixes the following warning detected when running make with W=1
> 
>     drivers/gpu/drm/rockchip//cdn-dp-core.c:1112:5: warning: no previous
>     prototype for ‘cdn_dp_suspend’ [-Wmissing-prototypes]
> 
>     drivers/gpu/drm/rockchip//cdn-dp-core.c:1126:5: warning: no previous
>     prototype for ‘cdn_dp_resume’ [-Wmissing-prototypes]
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static
      commit: 7c49abb4c2f8853520abc05b7f7e8b751fbb3086

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
