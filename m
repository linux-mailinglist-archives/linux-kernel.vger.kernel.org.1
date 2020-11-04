Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530912A7089
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgKDWcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:32:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbgKDWcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:32:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so301007otm.3;
        Wed, 04 Nov 2020 14:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+xov9qNrCa5kR+k+88TJtmG8DM6VvKyohLxdnZITB8=;
        b=JKNoZ8w9XRE3wtH16G38mz8zkAKAadorbNGV1qMQ/oex31F2yKqAnLuu292Zv9ys7F
         RLyTuHRmnYVUC8NiOeMvDVChcAsFs9+Nm3aGPYEcMtf13pyMrFrBPBD1kWWUP107BaEO
         Np9hXLCK4lwgxg8GmPL1k0NvLlzbfHiNUChyDVj98K1g/J/hHwhV47op257ImvWx40I6
         GANNGz2GWV1OSu9BDFFUBSSfUYsBPto4ZhiPwpSod5RWe89C/7Hj9XEDfOXL91pYnnMm
         o7Tc0TOlICQ7o+OpEAJBb3/6d8sFn1cQIyb4pf1D7a9doWR8HYUm39NfSGlSK+zVt+82
         PgRQ==
X-Gm-Message-State: AOAM532q4t51EwP9m1dG1JHNZDWn/cbXhwLEQHVgPU9d71p0KkV05pPT
        vJU1iN1s6IlRozcozf3cDQ==
X-Google-Smtp-Source: ABdhPJzT3+IkXidl8JPgKMkkFdkJi9iO4FXdvOhbw7kKGwODl+3fCylb57kXfLctK5HLo2xPcY+e+w==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr20262297otq.208.1604529151638;
        Wed, 04 Nov 2020 14:32:31 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l89sm744690otc.6.2020.11.04.14.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:32:31 -0800 (PST)
Received: (nullmailer pid 45723 invoked by uid 1000);
        Wed, 04 Nov 2020 22:32:30 -0000
Date:   Wed, 4 Nov 2020 16:32:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, Christophe Branchereau <cbranchereau@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add abt vendor prefix
Message-ID: <20201104223230.GA45670@bogus>
References: <20201101093150.8071-1-paul@crapouillou.net>
 <20201101093150.8071-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101093150.8071-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Nov 2020 09:31:47 +0000, Paul Cercueil wrote:
> Add prefix for ShenZhen Asia Better Technology Ltd.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
