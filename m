Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC122F995
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 21:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgG0T4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 15:56:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0T4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:56:11 -0400
Received: by mail-io1-f68.google.com with SMTP id a5so3060582ioa.13;
        Mon, 27 Jul 2020 12:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8UHP2DIuI2PhUn6nQlydwILHy7h5veWF+bWL7pWmYI=;
        b=t6aHTR0rhje2Y1yZqvcoadZgdBqa1fv/bvvSvorRyM7ZhInaaQkh2Rxw9bkIH9u0wm
         pY8Bpy5tUZj2C8ZpL9GsgQi9U9F1DayB/dTdmxHAJzJdfcEXlAOLwg0wj4eNKvyJDGCr
         gU5c1TtrSYLij5zMyxx+cKwrSAfDovKnSUTqiA8Dv5geZ55ynDPtTK07GUjtd2P/5EUW
         k9dxNoofTVGIjJwmOgFAebRUu2rw8HfW8/LHdkdkYcquBM/xj7d2hTs+iUBvKMyvXuE9
         diE2OEzuM6iuxgkDPEYMv++1aYJ3fhvhH9v3Xf25jfWnY85zGLSWuxL+9a/DX1bwIGHr
         DWXQ==
X-Gm-Message-State: AOAM533dkLlfuab1fn7JiYcxT/Fu2Ac5tqKIn2T53RQqGzGgaOZNb19Q
        3ApsiXB9htOK6EKt6KVqRA==
X-Google-Smtp-Source: ABdhPJwE+bqEac4f3wM8AlVwnQRJLKAVkJx8XhPsguZt8wv7uHc9/LrC6MgxM35EmhAD4wDtwDAGKg==
X-Received: by 2002:a5e:9519:: with SMTP id r25mr21081467ioj.199.1595879770589;
        Mon, 27 Jul 2020 12:56:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r2sm6613651ilc.58.2020.07.27.12.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:56:09 -0700 (PDT)
Received: (nullmailer pid 777930 invoked by uid 1000);
        Mon, 27 Jul 2020 19:56:06 -0000
Date:   Mon, 27 Jul 2020 13:56:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] dt-bindings: timer: Add CLINT bindings
Message-ID: <20200727195606.GA777876@bogus>
References: <20200724071822.126758-1-anup.patel@wdc.com>
 <20200724071822.126758-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071822.126758-5-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 12:48:22 +0530, Anup Patel wrote:
> We add DT bindings documentation for CLINT device.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
