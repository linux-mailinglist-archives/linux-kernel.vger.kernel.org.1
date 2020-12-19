Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D372DEEA7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgLSMRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:17:40 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46137 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLSMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:17:40 -0500
Received: by mail-ed1-f43.google.com with SMTP id b73so5037642edf.13;
        Sat, 19 Dec 2020 04:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HaZYWjwoz4Il+vDtKxdT28VigVltmPwXsNY0JZsWLw=;
        b=pWTk7zeKVUHCYIq1UilywzMQPzihaW+29xQgPpZLm+NKUU7+S1xOpybbiITgQ1oemd
         cj7cxSZCPY3rbMPko9skZbP/vp/BF3kWkIV8SlVXbi5x44GuP0lPa91y/ZKUm2xjLUZX
         cbcMF/c4ChJEiha7KOmYi0ZU7d/CPv/wxJ/PiA0L7tayLt0BT3wGWUo0oArItlyNlaAT
         omOIsfDPl+Lgsug7pgErpaONYOik2nJ2CnTV5QDKRTLjQ0822gi55v3EztKH88dNwKqk
         nz15QvQeOzFTOmVz2hYnF4xFM8vwPKu2BkFg36QzLcR0rx418P4Iz9wKtB5PDw9CXvMa
         7NVw==
X-Gm-Message-State: AOAM532sy3dXa8/aloU/ZDncGfB0kSwrmpxRxWeBPTKEnl8mzCiIcYct
        B03cLRj7omhKqp2jKi2Akt9hNw7Nm4vb3w==
X-Google-Smtp-Source: ABdhPJy2jVOsbrM4Vrb1tFIcDNJB9sXjNFw3ZJKrRWw056ozcgp6AH4cQR0tRSQEdPBMbkHqlEQuTw==
X-Received: by 2002:a50:8b61:: with SMTP id l88mr8714565edl.250.1608380218213;
        Sat, 19 Dec 2020 04:16:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t26sm6680248eji.22.2020.12.19.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:16:57 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:16:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Message-ID: <20201219121656.GA13886@kozik-lap>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218083726.16427-3-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218083726.16427-3-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:37:25PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> In order to be able to use NVMEM APIs to read soc unique ID, add the
> nvmem data cell and name for nvmem-cells to the "soc" node, and add a
> nvmem node which provides soc unique ID to efuse@30350000.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Changes for v8:
>  - none
> Changes for v7:
>  - add Reviewed-by

What happened with my reviewed-by?

Best regards,
Krzysztof
