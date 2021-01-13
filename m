Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8F2F4313
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbhAMEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:23:05 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40750 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbhAMEXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:23:05 -0500
Received: by mail-ed1-f46.google.com with SMTP id h16so443671edt.7;
        Tue, 12 Jan 2021 20:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCkN6kVpRqfOapK54mdqLd8w9YgJ3diPsbpEXoHwS2A=;
        b=HhIfuV2LCseIDAu1377ZTshUrkoZJOkOvdbbUQoC0qt+4+u3S/IIylMRNKOpcCEHx2
         PS7rVmQ6x9moum7VvorZ5fqpr6SF5SpCzFQXfFP0oJyzlUcnLAc6z83UorHiMZxohNdh
         XTrtI+/ICNSOM1q/SHodi1x+keqL7Hts30gq82bKygu34K7PyXXcwARLu8vsptiaxqkz
         83yZHEduLjxPKc+QLtmNhBL7j90UUw0bC7O/SlOTwBfUrqlXuoF3VarPPrP8nMxNWFga
         oGh29gQ5IBlTcOEg0qJ0wxVqF7AxXAvak6dceUgjX0z9RuxdTjfGU/Sx9SynqWS1K3A3
         0F3A==
X-Gm-Message-State: AOAM530LxU+JvrNKOkf5inrd9lso/6C1ifjJAZP00OnIdiYZBAnYqt38
        losbrKfzy/SfRbsFS1aui2c=
X-Google-Smtp-Source: ABdhPJzL0V3qLXCeb6upxUFdE9IiL0eAjs4YlST2C82wNS5eptb489rCmyP1vNpwSIbX1x5OmpmszA==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr273732eds.328.1610511743650;
        Tue, 12 Jan 2021 20:22:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k6sm197332ejb.84.2021.01.12.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:22:22 -0800 (PST)
Date:   Wed, 13 Jan 2021 05:22:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] dt-bindings: arm: fsl: Add the librem 5 Evergreen
 revision
Message-ID: <20210113042221.GB6486@kozik-lap>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-10-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112095151.4995-10-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51:51AM +0100, Martin Kepplinger wrote:
> Add an entry for the Librem 5 phone, Evergreen revision which is supported
> by "r4". Schematics and more information can be found at
> https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
