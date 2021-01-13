Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59E22F5008
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbhAMQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:32:56 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45057 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbhAMQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:32:55 -0500
Received: by mail-wr1-f43.google.com with SMTP id d26so2762449wrb.12;
        Wed, 13 Jan 2021 08:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/0YpXOLKzCymABC8q5K9YunqMSayJGkNXnIdHA1Xpw=;
        b=QoeAJ7zWhYpcr80xyWL4fVNJNYPcaxL25mXmV+AdpY7M6cr4cIMSDMuJ/tTrvEoNhS
         f4ZWRwuXzGCp9qfG43Ty34ybofDsyb4Fsm556Z62TQod0AaUsuFSsteL40PngkQW/JWv
         c+w9D1w/9f2mkIh9mvCUE6qetWdASBw9at2S6iYLTKUvOU5MGkbTBpGnWM1Rpuy7C9Wh
         bWjAZwUNZA34fV7u9RlH43lnR67p7bjTRJiZ3CnfE253/QxnuluFuj8FWYQ0VsTqbex0
         cLQ0zMRe+UxfmAg2bdd7dtWcvmhuOUFfDPPQiPfSjUCbvv9Ulpj9uF2M39//tl+H3Kyq
         gcyw==
X-Gm-Message-State: AOAM532gswV8ouo+emNmwIDpIW4X66NYDv7n4EPKZuXtZlSCyPDTiMuK
        F3epLLATyc0zlwRq4N6lAb4=
X-Google-Smtp-Source: ABdhPJz6iBVrES/TG1frhHwf+3ytjT14b05yJODt6AFv6FpcEUjBlCxLJfnlooXuyr7dGGoxXzbdow==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr3558131wri.380.1610555533571;
        Wed, 13 Jan 2021 08:32:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u83sm3849606wmu.12.2021.01.13.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:32:12 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:32:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Message-ID: <20210113163211.GA5599@kozik-lap>
References: <20210113143443.1148506-1-adrien.grassein@gmail.com>
 <20210113143443.1148506-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113143443.1148506-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 03:34:41PM +0100, Adrien Grassein wrote:
> The Nitrogen8M Mini is an ARM based single board computer (SBC).
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
