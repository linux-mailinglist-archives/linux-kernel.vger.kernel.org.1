Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB267300F04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbhAVVgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:36:50 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33598 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbhAVVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:32:31 -0500
Received: by mail-ed1-f50.google.com with SMTP id c6so8205274ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKbz4bexTx7l/78Slh9DnlQKMn+C9Oab3FDAuPgpk2E=;
        b=Ri6FAHpZvKwx+aEXD/R0Ky5X1mAhh7mDcqVL9Ik3EYeDVrKTC36/OmoPCsp1LGdosy
         WAUB8EcMHXeDx9SW9FKLEQY/JqGF69WVwvIOXN10pqy6RcZnE/NwFoaJgTTVOOy8T2/O
         UI5819pa0m8BkHxM+O2C2MwE3Mdns3279gn5fo+l6Vl/xkRhWy2w3T8WNbl/sSnGrFzf
         UfTDWDEX5ogqPdZZCBpJyC2VtmlOv5q6UV9uUMXsz/VyFM0Vw3CofyQg6wdYtqcpFf0Q
         aHRp3AML1oBBowOHjFdTDTqfc5IwJQpuxC63xUOq/LbY1UN8LkLBEtGq6Ke8p+ikrK3j
         sy3A==
X-Gm-Message-State: AOAM533RnWJEy3ongFw2AUGGfzfFb8YFObBU2I0JF6EFYv2pEtWXPwPW
        mqq9j2RwIdChWz30Kx5qfrg=
X-Google-Smtp-Source: ABdhPJxXm/UbYQOfzbAmGUe58u7tjks2ZQmC4I68zUxUVhfyqoVwnv72PHYQdHbTCixwPsYtg2RNUA==
X-Received: by 2002:a50:934a:: with SMTP id n10mr4681152eda.26.1611351107962;
        Fri, 22 Jan 2021 13:31:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id qh13sm5216877ejb.33.2021.01.22.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:31:47 -0800 (PST)
Date:   Fri, 22 Jan 2021 22:31:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com
Subject: Re: [PATCH 1/3] memory: mtk-smi: Use platform_register_drivers
Message-ID: <20210122213145.ampvsg4egk7yiz55@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:24:27PM +0800, Yong Wu wrote:
> In this file, we have 2 drivers, smi-common and smi-larb.
> Use platform_register_drivers.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

