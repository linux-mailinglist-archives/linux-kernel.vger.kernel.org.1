Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850B52C7A18
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgK2Quj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:50:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38740 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgK2Quj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:50:39 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjPta-0004yQ-3z; Sun, 29 Nov 2020 17:49:54 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Liu <net147@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Liu <net147@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: fix incorrect clock in vpll clock error message
Date:   Sun, 29 Nov 2020 17:49:53 +0100
Message-ID: <2205756.JbxMgk7veO@diego>
In-Reply-To: <20201024035321.4898-1-net147@gmail.com>
References: <20201024035321.4898-1-net147@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 24. Oktober 2020, 05:53:21 CET schrieb Jonathan Liu:
> Error message incorrectly refers to grf clock instead of vpll clock.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

applied to drm-misc-next

Thanks
Heiko


