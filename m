Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED18B2F6BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhANUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:15:43 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40233 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhANUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:15:43 -0500
Received: by mail-ot1-f52.google.com with SMTP id j12so6392606ota.7;
        Thu, 14 Jan 2021 12:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBbkkGY4rCU2rFpTt/58YJMJbTn2RPJ6lWwXRQf1jH4=;
        b=dviwZ2MkCkdtPsYp29tePTmhq6Nbf78pHGiQXtakRegTtGwyMbDxjjlU3d3qM29zIl
         zh9N8CZbHHWw1x6K4hxUOo9+hr0VZ4OBOQvVlUNfer/oyWl8zcWDy4jN9jN/X0WLc/Z8
         u2FN8sE1Pg6WRpilP39MqoBJA6WY+VZs3n1OoGZomF3X+Ak+UGFief65wyoxeH6O0Wum
         wXWHu4adLCkUiSyN8phdyeJ01WZKn2s1xUJahJPedzLyNQrLRzig5weqtzkP6K9IJgjH
         0Ok3MFpiqiWgPiEywWQv2meC0a3KXjNPAQD04dIkHXUCt5Ifz/kW8bATQdNPodApduLv
         dikw==
X-Gm-Message-State: AOAM530W50Q9ar1Z8LJAYhN3Hy2swTt/w82yM9p1ZqWsr27mnh4spw76
        v/K46c6JP05wSYcFbBX8PA==
X-Google-Smtp-Source: ABdhPJw+i0VjpVEzDN8mYQaz93ZXCB9OlV82gxmqt+xWnoiwGxyigND85Xo6Yp+3sOWyUODqqKpwmQ==
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr5562838otd.180.1610655302323;
        Thu, 14 Jan 2021 12:15:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 73sm1279661otv.26.2021.01.14.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:15:01 -0800 (PST)
Received: (nullmailer pid 3516147 invoked by uid 1000);
        Thu, 14 Jan 2021 20:15:00 -0000
Date:   Thu, 14 Jan 2021 14:15:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        shawnguo@kernel.org, kernel@puri.sm, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org, will@kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 9/9] dt-bindings: arm: fsl: Add the librem 5 Evergreen
 revision
Message-ID: <20210114201500.GA3516089@robh.at.kernel.org>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-10-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112095151.4995-10-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 10:51:51 +0100, Martin Kepplinger wrote:
> Add an entry for the Librem 5 phone, Evergreen revision which is supported
> by "r4". Schematics and more information can be found at
> https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
