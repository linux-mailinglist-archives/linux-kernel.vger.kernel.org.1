Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343DF304F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhA0DPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:15:04 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:45794 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404571AbhAZTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:50:28 -0500
Received: by mail-ej1-f48.google.com with SMTP id ke15so24689267ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/xNlPfGwnBKxfph+ywxuqzSguELReNCQiSKkwp5El8=;
        b=qhEKexmQAu0z85F3xnF+j/EcjXFRzILsYf8GVsFUTYkYhVIaBGtAL5rWmm1jRHlQgB
         ++40YZLvISg2+pnOWZrikmIRpHoa2A+w4R4JRPxvxV1+Hspvzrb/et+7+H2D9iO4gCq5
         4zfl9wd/O+BiLCfAS8bao8CNiE/BCIxyUYvGAI88EFeH/nKDw11eM3MKctHUxFmmXI9c
         vOrpMsuk9YQe6DYmWeQF/QQYcA/Sm95ofXv0KpeqcEdeU7UrJWN4F1VhtF312YPvrz3w
         PpwzTcrvL90fvz/xQvyzKtNAL2uGhO06+QQho1XnQV1o7zt0oC1a1fD2hUmnFXOGJwex
         Z7fA==
X-Gm-Message-State: AOAM533IRU4QaVZykkmpo9Tm3HvW4yLcYLAeMnbqSFAfC7ZpBCm6sxhO
        dQ+qos0obIYEkN6Er/P/srk=
X-Google-Smtp-Source: ABdhPJxK7hEpk5TYCend9Ub0Pc+g5IwKSV+LIkJ84QXUrE7AdhDzU/Qs2jCac4uMCvi4wSJ7Mt+SmQ==
X-Received: by 2002:a17:906:2e0d:: with SMTP id n13mr4302953eji.554.1611690586670;
        Tue, 26 Jan 2021 11:49:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dj25sm12801834edb.5.2021.01.26.11.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:49:45 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:49:43 +0100
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
Subject: Re: [PATCH v2] memory: mtk-smi: Support SMI modular
Message-ID: <20210126194943.n7xtgoa5axd2zajz@kozik-lap>
References: <20210126060055.11050-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126060055.11050-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:00:55PM +0800, Yong Wu wrote:
> This patch mainly support SMI modular. Switch MTK_SMI to tristate,
> and add module_exit/module_license.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This patch rebase on the clean v5.11-rc1.
> and this one: memory: mtk-smi: Use platform_register_drivers
> https://lore.kernel.org/linux-arm-kernel/20210121062429.26504-2-yong.wu@mediatek.com/
> 
> change note:
> a) squash the last two of v1 into one patch.
> b) Remove module_alias
> ---
>  drivers/memory/Kconfig     | 2 +-
>  drivers/memory/mtk-smi.c   | 9 +++++++++
>  include/soc/mediatek/smi.h | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Thanks, applied with slightly adjusted commit msg and subject.

Best regards,
Krzysztof

