Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C22C2207
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgKXJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:47:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41637 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKXJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:47:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id t9so20171852edq.8;
        Tue, 24 Nov 2020 01:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dk34/e/mxzNqyGJMYlOWAK9IKJtf8RN7D44FdJ3MzvE=;
        b=incordErnOUaNDKd5y0dHAtczDCCsiiEzG0wWi4M2yAlrF2OnA17fip7IceINMp8qa
         gjnXUzqKustDl5QcmSXRyNtLDwi4THTqj1fBLKIKzq8m+VqN0dz0H1OqW/Ew0pWLPTmx
         9GYMiMtbVYQoRfACufuYdT+W/5+VWesXy/9UiTZaC9U1xIIXwyxPwM3Nci/XmfOkXYzA
         3m9RgqxYSmVF1u0GLIDJa3q35lvVcH/OU/P94aQ5JBec/qtHqFCTtUGZ2E49AaqIq57C
         XQ+YAI14wq2ndVt7cfC3qgZbS6ZVVnSO3ZbAtwOBz5BVMr9yzKcBQymxGcc0ukisIhba
         1Ogg==
X-Gm-Message-State: AOAM530zhv2F0Y4VlzpesZIa4K5+XkwlyVSfCIpJoFq9E3CRU6Ll2xCI
        ayj3oWdXKgzprgrk+yWNTJg=
X-Google-Smtp-Source: ABdhPJzP/62o37kI8xbriHmwkRVBlNr3Mo/vCjuuGrr41wo+LoS/B5nho69Yk1vLW3JJ6J2wvob7sg==
X-Received: by 2002:aa7:d493:: with SMTP id b19mr3002612edr.279.1606211266000;
        Tue, 24 Nov 2020 01:47:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k12sm6349016ejz.48.2020.11.24.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:47:44 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:47:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Message-ID: <20201124094743.GB15030@kozik-lap>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201124015949.29262-3-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124015949.29262-3-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:59:48AM +0800, Alice Guo wrote:
> In order to be able to use NVMEM APIs to read soc unique ID, add the
> nvmem data cell and name for nvmem-cells to the "soc" node, and add a
> nvmem node which provides soc unique ID to efuse@30350000.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

I already reviewed it. Do not ignore received tags.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> ---
> 
> v2: remove the subject prefix "LF-2571-3"
> v3: convert register addresses and sizes to hex
> v4: delete "stuff" in subject and commit message, add detailed
>     description
> v5: change underscore of device node to hyphen
> v6: none
