Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4439275C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIWPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:46:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43114 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:46:33 -0400
Received: by mail-io1-f68.google.com with SMTP id z25so24217552iol.10;
        Wed, 23 Sep 2020 08:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0eLuc20wM3rutphtpf0ybWVhtVQuefUmzqK174Lo2M=;
        b=hfuv8BF7uvcBtbgmn1Rr3fyxtIrojjKCb2v4RHpnjvkk1wCId3zBAgRii6RiXUUxS6
         l8NfR0kumYBvjzVptexVjUEBAhkqy/3l4PPUoWimIYCTZA+lOJ+viK1VuMAqUjwjHsT+
         GpVjW0BqbKNDRCjl2gU7TW1nky7NxHTBJhUZT6I+lUNGgOQnLi8cz9nyqeWaNAeYUsmO
         Xkiom1AEA03CC9gkEQYIQiBJwKqRAJex0U4gXFrPmI98sy7IuMA+77O23TFAuZ9XCO9V
         ZbxQDGP3ywE4E7YYZrdqJgYoTOtoU4PjHLVF3IfrIUNakXZSfjLMgusljo5v7Os+wlBD
         v0Mg==
X-Gm-Message-State: AOAM530XHZ2j24GQwBwMu+/Nn1XXwRUrWTuNbgpViYoFc8hNhjyz8Ekd
        fg5qqI2XrJsnvM/N3dCuEg==
X-Google-Smtp-Source: ABdhPJxt9xuMrJswNzGVxGPdh0gY6Juik/ZMzKlNdud+UnA/ayysP66gyJ1oPh0MYMJ9djztFePPaA==
X-Received: by 2002:a5e:c017:: with SMTP id u23mr93228iol.139.1600875992120;
        Wed, 23 Sep 2020 08:46:32 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y8sm9542iln.17.2020.09.23.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:46:30 -0700 (PDT)
Received: (nullmailer pid 809171 invoked by uid 1000);
        Wed, 23 Sep 2020 15:46:29 -0000
Date:   Wed, 23 Sep 2020 09:46:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Rob Herring <robh+dt@kernel.org>, Bob Ham <rah@settrans.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Brougham <jusplainmike@gmail.com>,
        linux-kernel@vger.kernel.org, Leonardo Bras <leobras.c@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add vendor prefix for Ouya Inc.
Message-ID: <20200923154629.GA809116@bogus>
References: <20200916122247.534374-1-pgwipeout@gmail.com>
 <20200916122247.534374-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916122247.534374-3-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 12:22:46 +0000, Peter Geis wrote:
> Ouya is a defunct company from 2012 to 2015.
> They produced a single device, the Ouya game console.
> In 2015 they were purchased by Razer Inc. and the Ouya was discontinued.
> All Ouya services were shuttered in 2019.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
