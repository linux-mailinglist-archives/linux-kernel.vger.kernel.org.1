Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF472F81AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbhAORJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:09:34 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34926 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAORJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:09:34 -0500
Received: by mail-wm1-f45.google.com with SMTP id e15so1826381wme.0;
        Fri, 15 Jan 2021 09:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qj5xjZ8pehkTSz45VvmvqkYgWH5pE9pcEgHD+C9611k=;
        b=L780ke4BitK9GzCJPoS4Gal4oECENNR/S7kKBf9Wya88A5d7vtRm2WwMwEfMzXcK1l
         7VInyfOfONpEVIHQs55cFUzWucxzl1eOJXerQTNitkWb+mR2Yf6ovLmnnCdtKOD0ybP+
         8KD2gopiDDFKMusXfu9hnC2yPsshEirwJhPyYnKhS9YWteDjV6zjaA1S/RcG4Mf90YmG
         0R8TDXYV51BsD6K7EGqiucByCRzHsN3Jw6WLfnUPCrlhJi1GEWBJ+oamLqCAf4uCYBx2
         kzHYsGWffnu/SVLDGevNhZ89g5cZjWeKHmInsKWXmxdvtu+i8X6AVbR7q+RemzNrxdd3
         UZsA==
X-Gm-Message-State: AOAM533gz985xXhTsw/00HsLj1oUgwBJVw9oWF+Fkl2hyE7DIRQZou3y
        CF8o9t7ikdOUyCQc/17Qbs4=
X-Google-Smtp-Source: ABdhPJzurmSQQa/bJdXOhhtSX1aBWN9k6U7wX5fZj5YzTnxVHCE40TjoZ+ZpRLdg+wYpb24lty/e6w==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr9198010wmq.89.1610730532183;
        Fri, 15 Jan 2021 09:08:52 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z13sm28100146wmz.3.2021.01.15.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:08:50 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:08:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: imx: add imx8mm nitrogen support
Message-ID: <20210115170849.GA45379@kozik-lap>
References: <20210113173855.1509417-1-adrien.grassein@gmail.com>
 <20210113173855.1509417-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113173855.1509417-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:38:53PM +0100, Adrien Grassein wrote:
> The Nitrogen8M Mini is an ARM based single board computer (SBC).
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

You received here a review tag. Please don't ignore it but include it.

For the record, second time:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
