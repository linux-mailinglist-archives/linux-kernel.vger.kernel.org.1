Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114852B6C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgKQRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:41:16 -0500
Received: from mailoutvs38.siol.net ([185.57.226.229]:41926 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgKQRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:41:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4709252209F;
        Tue, 17 Nov 2020 18:41:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ey-XaGR21hHq; Tue, 17 Nov 2020 18:41:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ED433522170;
        Tue, 17 Nov 2020 18:41:11 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id E534F52209F;
        Tue, 17 Nov 2020 18:41:08 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com,
        chenzhou10@huawei.com
Subject: Re: [PATCH v2] drm/sun4i: dw-hdmi: fix error return code in sun8i_dw_hdmi_bind()
Date:   Tue, 17 Nov 2020 18:47:05 +0100
Message-ID: <2294800.5ACB0rnJnf@kista>
In-Reply-To: <1605488969-5211-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1605488969-5211-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 16. november 2020 ob 02:09:29 CET je Xiongfeng Wang 
napisal(a):
> Fix to return a negative error code from the error handling case instead
> of 0 in function sun8i_dw_hdmi_bind().
> 
> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied to drm-misc-fixes, thanks!

In future, please CC all people given by get_maintainer.pl script. In this 
case you missed Maxime Ripard and Chen-Yu Tsai.

Best regards,
Jernej


