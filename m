Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D942224DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgGPOIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:08:48 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52536 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgGPOIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:08:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6F036FB03;
        Thu, 16 Jul 2020 16:08:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8_DNoGSdlg8i; Thu, 16 Jul 2020 16:08:44 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D8C5942576; Thu, 16 Jul 2020 16:08:43 +0200 (CEST)
Date:   Thu, 16 Jul 2020 16:08:43 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix st7703 panel initialization failures
Message-ID: <20200716140843.GA359122@bogon.m.sigxcpu.org>
References: <20200716123753.3552425-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716123753.3552425-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,
On Thu, Jul 16, 2020 at 02:37:51PM +0200, Ondrej Jirman wrote:
> When extending the driver for xbd599 panel support I tried to do minimal
> changes and keep the existing initialization timing.
> 
> It turned out that it's not good enough and the existing init sequence
> is too aggressive and doesn't follow the specification. On PinePhone
> panel is being powered down/up during suspend/resume and with current
> timings this frequently leads to corrupted display.

Given the amount of ST7703 look alikes i don't think you can go by the
datasheet and hope not to break other panels. The current sleeps cater
for the rocktech panel (which suffered from similar issues you describe
when we took other parameters) so you need to make those panel specific.

Cheers,
 -- Guido

> 
> This patch series fixes the problems.
> 
> The issue was reported by Samuel Holland.
> 
> Relevant screenshots from the datasheet:
> 
>   Power on timing: https://megous.com/dl/tmp/35b72e674ce0ca27.png
>   Power off timing: https://megous.com/dl/tmp/dea195517106ff17.png
>   More optimal reset on poweron: https://megous.com/dl/tmp/a9e5caf14e1b0dc6.png
>   Less optimal reset on poweron: https://megous.com/dl/tmp/246761039283c4cf.png
>   Datasheet: https://megous.com/dl/tmp/ST7703_DS_v01_20160128.pdf
> 
> Please take a look.
> 
> thank you and regards,
>   Ondrej Jirman
> 
> Ondrej Jirman (2):
>   drm/panel: st7703: Make the sleep exit timing match the spec
>   drm/panel: st7703: Fix the power up sequence of the panel
> 
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 29 ++++++++++---------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> -- 
> 2.27.0
> 
