Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507222C899D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgK3QeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:34:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33553 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgK3QeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:34:05 -0500
Received: by mail-il1-f194.google.com with SMTP id y9so11879802ilb.0;
        Mon, 30 Nov 2020 08:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZBBwW3NkUSuFPPRYNjLGyBC//UcL1yNtoBYCa8FcsK4=;
        b=ZCnA5OhcK1zttpXixcGIBvgg7tB4wK3exzkRPip6aNgaTvcJ69ehPYbi/ZjzhVmOKA
         nmoH9hE2tLi6DZJ0FzfIw+0u6nIb82U2BpuyPwWysostnHbmx6nPUOJ6+eQsDphnbOWx
         ZzL866n3otTYuDSCKJPUXOXOSfu62cKaT2PY2xdp893TJawNOEd8FK7YsafBlSjTbfdS
         AWgGlMGOtXqWA1raf+GukMQ4GBkjWKvesHGFV2iyd4c4n/VJIC84LqFb1zhr1Q4mhUmW
         roucR7HJEzwxmKcfiuy8mPX9ll5J2b1D7ThiEITJW2au/AJoxa+k9xWTXKutq2KVihRm
         TMYQ==
X-Gm-Message-State: AOAM533XlfEi2HMk+ElEyQCR0Owz/Ey/ECeoP4BlM25uQNd82jm/sKWV
        Q0Xh8nUJBxNZ8/KU1WysVg==
X-Google-Smtp-Source: ABdhPJwo98x9fcLfGsa/fOEkRiiTPfg0HG5OZjgyT5/bJuvDcYPknYRrLNe/75450Ba2DHlYQ7En3w==
X-Received: by 2002:a92:444e:: with SMTP id a14mr2066584ilm.129.1606753998497;
        Mon, 30 Nov 2020 08:33:18 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c8sm8427863ioq.40.2020.11.30.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:33:17 -0800 (PST)
Received: (nullmailer pid 2583689 invoked by uid 1000);
        Mon, 30 Nov 2020 16:33:14 -0000
Date:   Mon, 30 Nov 2020 09:33:14 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/8] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20201130163314.GA2583085@robh.at.kernel.org>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1606103290-15034-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606103290-15034-4-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 11:48:05 +0800, Hsin-Hsiung Wang wrote:
> add dt-binding document for MediaTek MT6359 PMIC
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6359-regulator.yaml  | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml


See https://patchwork.ozlabs.org/patch/1404625

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

