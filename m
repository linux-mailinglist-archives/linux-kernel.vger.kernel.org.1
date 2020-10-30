Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5929FC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgJ3Dta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Dt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:49:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBDCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:49:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so4061738pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=POKlFlvAqzthNcFgF5vrqxopTlKMhI/9XKBoukQUU8Y=;
        b=h1V0jDWUp1S3U6KREeWgcIWN1e0DzycLLMqGfeC39oGAgIucVZpXu+qs/YF1id8e7H
         BfXsvLNFBOmQoSkP6umfYlOK0LL+bZeye00jojwKQHx2PHvznXOQc2ij0dDZqIzHkDMp
         04HAiQaUGMojBG/+Ute7s7GQ3j2DNesgGx4BtHo3Q9kgWAs1ZaQ78PWXVxyY0sNeBYgF
         h5BshH3kayBonxs960k9E5nUWeqQiU25v0K11oSCrm4vTtAk2JikLlIwRhyrmZES249n
         SnwrxtKtr/aCdn6l2cQB7cxzCmMdT3XxPY99goQOx7YHh4k3cT4mvq8ogUbWoTgPM6P7
         +aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POKlFlvAqzthNcFgF5vrqxopTlKMhI/9XKBoukQUU8Y=;
        b=rGY8E+rWRbN1eX9ZJTGtYlTOAdi1wekaHCxPcyEOmSJaxVGD7YLZ9D4PUtn2/SpDpJ
         sI8DPa8t5VXrWGERnblfFuPORIdCfUsDCX+O3EEmhXyTWuM3OdtZiqni3GvJM7buMSrc
         m+CfhlTEU2KzudZ2X4DlhndlWXwENOAL/rTzgXxeNRWiOBkC9Y7FJh9ULBaDjPG2bgCm
         2U2v3HGxOc5jlDVovyE85gKVFT9wGj0IlzVqB/2W4uKOunByU8MN0tMupVGqCaGDNuE4
         xvMiirJNxI+YtS2jTQ1RU25EcBAZilIgiF8l8Jm5rlSdgT8hSvHGCJxySm0jzSYJ+tJ/
         eKfg==
X-Gm-Message-State: AOAM5319Hsc+IUAGcV6Jh8yPcepW569TyzF9suixnWJnaS9yuif95OmM
        cvlKTODamBwzbUWdzhV6F8s=
X-Google-Smtp-Source: ABdhPJwDGHNezweuCs5v1Slkjg0XOxMIxqhPAXFU8ZNNBjzXucjZ5NGURqeBtYJPkN5q74VxmTeM0g==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr429782pjb.228.1604029769012;
        Thu, 29 Oct 2020 20:49:29 -0700 (PDT)
Received: from [10.230.28.251] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t129sm4578814pfc.140.2020.10.29.20.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 20:49:28 -0700 (PDT)
Subject: Re: [PATCH 03/17] phy: broadcom: convert to
 devm_platform_ioremap_resource(_byname)
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Li Jun <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Al Cooper <alcooperx@gmail.com>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-3-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9c33597e-34e7-f94b-a4fb-bfc2e6b0f8ba@gmail.com>
Date:   Thu, 29 Oct 2020 20:49:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1603940079-8131-3-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2020 7:54 PM, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource(_byname) to simplify code
> 
> Cc: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
