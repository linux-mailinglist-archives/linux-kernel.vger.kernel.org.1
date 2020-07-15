Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07022213BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGORu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 13:50:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33861 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:50:55 -0400
Received: by mail-io1-f66.google.com with SMTP id q74so3206316iod.1;
        Wed, 15 Jul 2020 10:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lm4/CoMM23brYGuvxbzrBI7XMuUz0kmq2vfp0FBfrio=;
        b=oe+iOCAXYpmDl/5rLGROqQQlhIE45MTH6rH+77OQfXB8pplA6efjLiaFrI6zil4P94
         3E6TdxkGhTDhFbQs/wbE19lXQ5SPTRt+lwdFWzKJK1p37qzZlGQp+JR+vt+wpUvGaLWX
         QWwAfV2Qm0i0CyiQRqKEKtANDqH5UUvmHeB3tAESOAAPklov/KPVSoetUm9dU1xe9dQo
         G4BBMeHYdVC1pMpCOIITB+qgUtC6+JFqFbkfC3pcbZGND/wJkK+zSbF4IZBi5opRbyfq
         p3Duax6L3IvFCar6lsKgykrSeURa/wtBErVSJWUDw02M4iLuppaN/hYzcD4P62Dsou/l
         97bg==
X-Gm-Message-State: AOAM530nX6PQyXEX+QRCQP5tVyPWUkmUQyR1aHMq35SWLuvYpYjmcjHJ
        8Qo3Klg8x3zaAbwsEuuY+ErhdB4GrQ==
X-Google-Smtp-Source: ABdhPJyue+QezUbFaV7QPT2tl/LvbzrBcrcPqpdUNFSnX/aKU/OdMBSFB1DJCISh0lxFHd9o44zJdg==
X-Received: by 2002:a5d:9a97:: with SMTP id c23mr418430iom.179.1594835454796;
        Wed, 15 Jul 2020 10:50:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 69sm1435476ile.60.2020.07.15.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:50:54 -0700 (PDT)
Received: (nullmailer pid 498027 invoked by uid 1000);
        Wed, 15 Jul 2020 17:50:52 -0000
Date:   Wed, 15 Jul 2020 11:50:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: timer: Add CLINT bindings
Message-ID: <20200715175052.GA497000@bogus>
References: <20200715071506.10994-1-anup.patel@wdc.com>
 <20200715071506.10994-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715071506.10994-5-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 12:45:05 +0530, Anup Patel wrote:
> We add DT bindings documentation for CLINT device.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/timer/sifive,clint.example.dts:21.39-40 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/timer/sifive,clint.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/timer/sifive,clint.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1329276

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

