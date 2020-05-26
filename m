Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA31C5CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgEEQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:04:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgEEQEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:04:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 882CBAF22;
        Tue,  5 May 2020 16:04:34 +0000 (UTC)
Subject: Re: [PATCH v2 02/15] ARM: actions: Drop unneeded select of COMMON_CLK
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20200505150722.1575-1-geert+renesas@glider.be>
 <20200505150722.1575-3-geert+renesas@glider.be>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <89ad77c9-4bc8-039e-1ba5-e8eb67734597@suse.de>
Date:   Tue, 5 May 2020 18:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505150722.1575-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am 05.05.20 um 17:07 schrieb Geert Uytterhoeven:
> Support for Actions Semi SoCs depends on ARCH_MULTI_V7, and thus on
> ARCH_MULTIPLATFORM.
> As the latter selects COMMON_CLK, there is no need for ARCH_ACTIONS to
> select COMMON_CLK.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Andreas Färber <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> ---
> v2:
>    - Add Acked-by, Reviewed-by.
> ---
>   arch/arm/mach-actions/Kconfig | 1 -
>   1 file changed, 1 deletion(-)

Do you intend to apply the whole series through soc (my assumption due 
to soc in To), or should I pick this one up as maintainer?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
