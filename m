Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E432A67F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgKDPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKDPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:42:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66041C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:42:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so11738464wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oJglqKn7dAFDLBv2qSAfqFzVJiIXW4+rpYveN069Vz8=;
        b=UCNVeyVG6ZaaZeyTmvgnw1owWC8e6Ye1YkZ4xntnZOgw6oqTKUlRbSw7p24oWOqEPn
         OTxID1d7mgBq19B+MLXf3Yo8LSC3N2+i07oVsNVdAP+0b9M/hYBTSz46kdmhkiz+UZxk
         j9rY5BzlUDD74Qeipszcr/fQ3/KcEEPtHGGczBTSM7AGaEvL3Cwmgm+fsI+N0R1UI4LF
         J2MDpnsJ7Z4LM/q2t8kdPAFxqoTcJ4g7fEfDBIfHHv+TbWbfId/IqFtSxkj1sdzYv5WI
         DEgyJMuZaRMJ9CtY1N3JtQi135gV4C4t3CYh7lR0vZUEIiMSGiAdi10wqxp8Ece7D+6e
         1fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oJglqKn7dAFDLBv2qSAfqFzVJiIXW4+rpYveN069Vz8=;
        b=kL4Szaru1tJHYNIWUwie+HU/BVsZC/gXqFQ6BI1VIOe0u4WNgr4gr1v2FXP+pNZrQX
         G/oTmCEKTefqKpiHaiKs0yfb6QAPLX8msTVyz9gERKXHX2cU3tCySjUSX1gY5UBoNXsL
         EvUmtfm0JE3PoC3d4I4XgzSj4lNARv2NtdDrHFXXonXWlDSNrhnkeqlWR5N1/gSfK0JE
         s32d3ULzAqIrqS0y1x1pHxomO9lxGZnVfoKCxfW1wSgHpXj5mMfqrDP6/s5V8iPpXKi8
         vPYEBCHQMB6MMm8zUs73nACGQFr+U8sPxaioBvZyL0G3XqI/m47JGlhzZ20397OjjDTy
         GQuA==
X-Gm-Message-State: AOAM533tO7Ijv0nBg2jzBsf2wdgCgnU7B4HOocGpEZpTaATwfmew00PO
        EEWKct0FSc5sqBefje/FY0fARQ==
X-Google-Smtp-Source: ABdhPJyPHWI6PRkRXqwBYesNlTcVo+E9rezqWWhMG2ej1xt1sK03O53YvUw9ofKB1vHRgv1mYX1rgA==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr34135265wrs.423.1604504527105;
        Wed, 04 Nov 2020 07:42:07 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y2sm3267485wrh.0.2020.11.04.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:42:06 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:42:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 2/2] mfd: madera: Add special errata reset
 handling for cs47l15
Message-ID: <20201104154204.GP4488@dell>
References: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
 <20201027094132.16472-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027094132.16472-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020, Charles Keepax wrote:

> An errata exists for cs47l15 where the reset must be handled
> differently and removed before DCVDD is applied. A soft reset is used
> for situations where a reset is required to reset state. This does
> however, make this part unsuitable for DCVDD supplies with a rise time
> greater than 2mS.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c       | 25 ++++++++++++++++++++-----
>  include/linux/mfd/madera/core.h |  1 +
>  2 files changed, 21 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
