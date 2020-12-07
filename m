Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6612D1BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLGVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:09:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41018 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgLGVJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:09:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id x13so6368430oto.8;
        Mon, 07 Dec 2020 13:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKVvjJWc9OSjiXaprXNkt0WW9iu0RQ9BqZVBt0mZKwo=;
        b=aUDOrRFafzZ53yRVzHbLg0sFRqaiLhkfuBpWArC7446z7e6ajuJeWMshUSy+pSnCnv
         T0DzTRAs8YAraQzActQP6iI+B0F4rWcvIgk30TMDC004xUJ3PzkkkVAJ0Ds+ySAHdgdW
         2etK3Nj5n8ZVVK6ebe6/JmX8/YB2fpjVNjNTdemLVWZvq3HMucoo1C4vXWxLir3nCXIj
         sxe3XDGEbHAlVrWMvDvQqR6ibjocptuUbj7anzbG/bejfexOO3FTYR1LRs3NxAN87AkW
         guB0MxWDGhXdiKQFp4R0D7l8uXwhTKp6R8+k11z+rouchn99WARMu5bLopjgYI8Y5m7d
         kHUg==
X-Gm-Message-State: AOAM533DMJPjxoSy0rNqJgQlWcUd571o4C7/95Pc7/BdxeIqz6TzAwe5
        52EofBaO2n4HBsfdAgM24rokx6YIZg==
X-Google-Smtp-Source: ABdhPJyW44Q0Osq/CeAta5Ib6oxadSRnlEq3jrCH5C95F2V1euHJQ1oB9IyTCUMVdE7v+OJu1/oyTA==
X-Received: by 2002:a9d:72c4:: with SMTP id d4mr14729969otk.149.1607375337130;
        Mon, 07 Dec 2020 13:08:57 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm1201668otk.58.2020.12.07.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:08:56 -0800 (PST)
Received: (nullmailer pid 827134 invoked by uid 1000);
        Mon, 07 Dec 2020 21:08:55 -0000
Date:   Mon, 7 Dec 2020 15:08:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: arm: vt8500: remove redundant white-spaces
Message-ID: <20201207210855.GA827049@robh.at.kernel.org>
References: <20201117201752.129766-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117201752.129766-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 21:17:52 +0100, Krzysztof Kozlowski wrote:
> Remove redundant white-spaces, no functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/vt8500.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
