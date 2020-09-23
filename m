Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D3275C51
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIWPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:46:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43057 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:46:56 -0400
Received: by mail-il1-f193.google.com with SMTP id a19so17094ilq.10;
        Wed, 23 Sep 2020 08:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcUWBscIPHyYy3WPszDKh/+hciVUg18KKkd9cn+Y5lk=;
        b=tn+JKF0n/y+sOwgw/Fj32R9jEFSLW1r+9iRXKYtcfgkTRNwkE0K/jC70i2IL8mD758
         rG68uUrCRbQu+sMUbMhJe2fzg2KuQmy4CvrVzvUAYrKdCSHjk9FREfxLLJTCKDDZssXz
         qg8VCgfb+qicSjvwBX3PknwhHhbXJy4D7VB9fG9JtlX2x2gPDHVNiwdjVGIRU4RjzOEw
         lIAGVrBjnEq6MY12/PCpuAr0ZAfSqU2cJoKr5xNDx/BFVNhjDJ/h1gXzdcCIGN43/pwW
         ydpakL16S8folnzs+Hdk6UvTLG5uJfhywCIK0xZJs4+rNg3lEr0vCYX7WI/rZkECIeLN
         8RsA==
X-Gm-Message-State: AOAM532xygRkFErfNnlH0DYSOPTkxFWED2XjzYCFKKGZ6eFLh0Nrv8Wm
        EFYkRRCd+7QqgHe++y4PrA==
X-Google-Smtp-Source: ABdhPJzc2bg567tNHGR1zBgCyAAojRU5RF+wVPMTLKiGwEgu90auZXs1z945nZqz8sap+GOLMuZNKA==
X-Received: by 2002:a92:96c5:: with SMTP id g188mr309118ilh.283.1600876015132;
        Wed, 23 Sep 2020 08:46:55 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 2sm116552iow.4.2020.09.23.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:46:54 -0700 (PDT)
Received: (nullmailer pid 809927 invoked by uid 1000);
        Wed, 23 Sep 2020 15:46:53 -0000
Date:   Wed, 23 Sep 2020 09:46:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bob Ham <rah@settrans.net>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Michael Brougham <jusplainmike@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: ARM: tegra: Add Ouya game console
Message-ID: <20200923154653.GA809872@bogus>
References: <20200916122247.534374-1-pgwipeout@gmail.com>
 <20200916122247.534374-4-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916122247.534374-4-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 12:22:47 +0000, Peter Geis wrote:
> Add a binding for the Tegra30-based Ouya game console.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
