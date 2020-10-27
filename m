Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A310F29A773
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895484AbgJ0JMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895383AbgJ0JMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:12:19 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468FB20747;
        Tue, 27 Oct 2020 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603789938;
        bh=2FkRBoqShA/bmLCc3PG3RGPFCejiLZ3iDbDEpEun+oY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K+VOAPJvQfJVKSQbmIBiqaUL3myfEXlVMTNxg90F1ATJLg8tw9Fv4EDF+OIfR+W2R
         NAwn4uj7+fmjCOHYLbJKyFmMQYdwWCmMii+cEze+1fz6AYMmDKcX2lCBCOCrQwgPeJ
         tibrGIUwIIrQLTy1mxZ7/jfRuZhHVZVU3Om3jJlU=
From:   Felipe Balbi <balbi@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: Re: [PATCH v1] usb: dwc3: core: fix a issue about clear connect state
In-Reply-To: <20201018134734.10406-1-zhengdejin5@gmail.com>
References: <20201018134734.10406-1-zhengdejin5@gmail.com>
Date:   Tue, 27 Oct 2020 11:12:14 +0200
Message-ID: <87pn54c9sh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dejin Zheng <zhengdejin5@gmail.com> writes:
> According to Synopsys Programming Guide chapter 2.2 Register Resets,
> it cannot reset the DCTL register by set DCTL.CSFTRST for Core Soft Reset,
> if DWC3 controller as a slave device and stay connected with a usb host,
> then, reboot linux, it will fail to reinitialize dwc3 as a slave device
> when the DWC3 controller did not power off. because the connection status
> is incorrect, so we also need clear DCTL.RUN_STOP bit for disable connect
> when do core soft reset.
>
> Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/usb/dwc3/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2eb34c8b4065..239636c454c2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -256,6 +256,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  
>  	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>  	reg |= DWC3_DCTL_CSFTRST;
> +	reg &= ~DWC3_DCTL_RUN_STOP;

as I mentioned in the other thread, I would rather figure out why we're
getting to probe() with RUN_STOP already set.

-- 
balbi
