Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54FA2B10C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKLV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:59:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56042 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKLV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:59:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACLwZE1113296;
        Thu, 12 Nov 2020 15:58:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605218315;
        bh=OOeBWSQvhsy+3jfHtSNM278WeZaeyoAEkPd6w/G4npk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MSm8hK/TDHc0Gnl0QYAs1mhFU/5+495vGUOEn5khlC2OUN1eRH4DkMsG9DtYSpy9L
         79R0+s1DpG5bcYziaxFyzGjKoOGU5bkoYK1TPCdC6fEcWhAXG/qXQKlvasEiAcxdcp
         XrwdRYgF7y0zjW3LXdMWJL9ScTCYAM/vhBgn4rwA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACLwZaK089963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 15:58:35 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 15:58:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 15:58:35 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACLwZkO015177;
        Thu, 12 Nov 2020 15:58:35 -0600
Date:   Thu, 12 Nov 2020 15:58:35 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Swapnil Jakhade <sjakhade@cadence.com>, Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: bridge: cdns: Kconfig: Switch over dependency to
 ARCH_K3
Message-ID: <20201112215835.ufjrvdz4p2keyosm@product>
References: <20201026165441.22894-1-nm@ti.com>
 <20201108100642.GC1129714@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201108100642.GC1129714@ravnborg.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:06-20201108, Sam Ravnborg wrote:
> Hi Nishanth
> 
> On Mon, Oct 26, 2020 at 11:54:41AM -0500, Nishanth Menon wrote:
> > With the integration of chip-id detection scheme in kernel[1], there
> > is no specific need to maintain multitudes of SoC specific config
> > options, discussed as per [2], we have deprecated the usage in other
> > places for v5.10-rc1. Fix the missing user so that we can clean up the
> > configs in v5.11.
> > 
> > [1] drivers/soc/ti/k3-socinfo.c commit 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
> > [2] https://lore.kernel.org/linux-arm-kernel/20200908112534.t5bgrjf7y3a6l2ss@akan/
> > 
> > Fixes: afba7e6c5fc1 ("rm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
> > Cc: Swapnil Jakhade <sjakhade@cadence.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Yuti Amonkar <yamonkar@cadence.com>
> > Cc: Jyri Sarha <jsarha@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Applied to drm-misc-fixes with Tomi's r-b
> Fixed the "Fixes" line while applying - someone ate a 'd'

Ooops.. Sorry about that. Thanks for fixing and picking it up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
