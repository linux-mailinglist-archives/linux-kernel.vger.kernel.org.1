Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96BB2CC769
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgLBUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:03:56 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36517 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgLBUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:03:55 -0500
Received: by mail-ej1-f68.google.com with SMTP id lt17so6317015ejb.3;
        Wed, 02 Dec 2020 12:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EENxk0NCAtWvlOsSidebd3TSck2BOvE++cdkH7sHBY=;
        b=AjaZjlf+h8c9815/Z5JP775s7ipwo/O+UjX3k2xaTqSePAI6mmV47SYjWcrGuiVWow
         gX5gs81ao+4zaO0F1WDTHxXkckqQtQsb3ilU/zYKq/2q1jLsO/qjHg6vs7GbbjTil45o
         H4JNe0prS2Qgr9hRpXcE4wywoHFijTFAmnJ+C26NKHjymkvnWLqZTaSGDw/qF2V04MJJ
         rsy0p63rhVhq+0fc0RLxGHhkPC0ox7jpfVBt4yGucJ7USt7KmrR6PDgVJyQ65BejOrjg
         2H2MD9CqCtnlW7haGuNI2CC5YdW3/LDf9JkQL/rY1I6tHQUxB4KBcbrKkKIAZR6HQeY/
         HtxA==
X-Gm-Message-State: AOAM530WIqTgAxi5e4DJTi4wbZBdsDFcTIusVC38FbDdZ2ojYPCZyPnz
        SAiv/INu6VKlWKczkPvwdok=
X-Google-Smtp-Source: ABdhPJyF3oGjfU8JqPmwtQeWYp4q4j3mX9w1fP64gca9qoDR6zwqnuCgll1yqzErctxROcFMY5bvkw==
X-Received: by 2002:a17:906:118c:: with SMTP id n12mr1403066eja.167.1606939393668;
        Wed, 02 Dec 2020 12:03:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s26sm649328edc.33.2020.12.02.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:03:12 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:03:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: samsung: document S3C6410-based
 boards binding
Message-ID: <20201202200311.GB128771@kozik-lap>
References: <20201117201106.128813-1-krzk@kernel.org>
 <20201117201106.128813-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117201106.128813-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:11:04PM +0100, Krzysztof Kozlowski wrote:
> Add bindings for the FriendlyARM Mini6410 and Samsung SMDK6410 boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied.

Best regards,
Krzysztof

