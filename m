Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94782CC76E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgLBUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:04:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45787 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbgLBUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:04:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id r5so5295121eda.12;
        Wed, 02 Dec 2020 12:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3H+/Pk1vdtBMbkvkEWzPL8rGYs8KMTBkqJOiGXFAT3Q=;
        b=tBy6VxcH1Ikj73anh+ivLNdOR3qNMV1WJ02+5iTnUHvaERIlMI/Rt/zyiK/NifINWj
         ctt7l/DyjkZ2ucvniURAOwel/9h9AnzX3s7c3fHdPKVELPxLomAjDnY/+hTHfHffvGQK
         YESUtaoTmOdyam191QiZIeKWcAMBSmKH3QOGqZZSMWw98AVOBV7JVLyuRbbXYHKjwxoL
         urtT9wVFKR40vdu/5opteiikY0Nz+vBkYRik0Yks4rxX8cxDVhQmTXd/sfsjdm8AabeR
         UQGLiGjXMCeW5ukf4dNMOe2yVMQbBPBmw3kzneYwyUQiG8nVdPaDlF+YHpLcTACF309c
         K7+Q==
X-Gm-Message-State: AOAM533XTjX5CtwhuUp1bVz9QVtXyfQoV8cSVm0LrgXoNh94Ut/8cnkU
        pz9Mc6CiVOLJ+auQvVDk3LzUaakFPb4=
X-Google-Smtp-Source: ABdhPJzO0jbYldQ2/2+yVGNdxtARvimDdd5sq6FNqXdRkYf0ADzfizL7+23C8Dv2bEJgzmQg3Ns3lA==
X-Received: by 2002:a50:fc96:: with SMTP id f22mr1713481edq.162.1606939421359;
        Wed, 02 Dec 2020 12:03:41 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e21sm631481edv.96.2020.12.02.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:03:40 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:03:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: s3c6410: correct SMDK6410 board compatible
Message-ID: <20201202200338.GD128771@kozik-lap>
References: <20201117201106.128813-1-krzk@kernel.org>
 <20201117201106.128813-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117201106.128813-4-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:11:06PM +0100, Krzysztof Kozlowski wrote:
> The SMDK6410 DTS was incorrectly called mini6410, probably copy-paste
> from FriendlyARM Mini6410 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s3c6410-smdk6410.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Best regards,
Krzysztof

