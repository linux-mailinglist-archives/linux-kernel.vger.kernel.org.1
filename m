Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABB295D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897119AbgJVLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:16:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37679 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436687AbgJVLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:16:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id o18so1364137edq.4;
        Thu, 22 Oct 2020 04:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6LjlAqnltcowuKPFP7AlL+hzUKZELzInqRy8HOQGng=;
        b=PmGQZKY+aRxdgnH+la8Wwr0pnRYjPaTe4xMow9rru+ej14uKOazdLGip0VC723YyZK
         a4bttBWQxFz4h2TOmrGSXV1xspx5ncvZaqvZh2f1kX0H6WgODMrmDyBsJvzcGGqc8WZd
         biapV5wLZjak3QEmJYcZcKYQ0tdzAiORgsKBJQrd1CA76yHJtRyJHnMf+QlHdf86ihNC
         DpK2dw6qwxs7Fm3Rmslr0KsIo/K1biRSb/wuxeMsl3Ye395oLhFUz2qi3IVR/Pp6VtK0
         GrBI1l92AqPJtmOBELw3nK7YDx54HTjxMSEiw39r3rD1u74OG6msFnZOjv4HwIpUGKae
         oRlQ==
X-Gm-Message-State: AOAM531r141JMtUPpwVk3JfoqEJo217GqPfaJxVjwOXND9sMlzwWkRUb
        Km93A3n5477BthhrMPx5SHU=
X-Google-Smtp-Source: ABdhPJxsyCEWvreTBWM+MyO41TZtpnZlLYxdisLH4mkQW2lEvOqS0aNZBg1ii6oGaUdR7I5pbVZDuQ==
X-Received: by 2002:aa7:d384:: with SMTP id x4mr1748243edq.105.1603365395007;
        Thu, 22 Oct 2020 04:16:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id z2sm586109edr.64.2020.10.22.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 04:16:33 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:16:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 3/3] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201022111631.GA120389@kozik-lap>
References: <20201022102733.3277-1-o.rempel@pengutronix.de>
 <20201022102733.3277-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022102733.3277-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:27:33PM +0200, Oleksij Rempel wrote:
> Van der Laan LANMCU is a module for the food storage rooms to control
> proper gas composition.
> 
> Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Looks good, thanks.

Best regards,
Krzysztof
