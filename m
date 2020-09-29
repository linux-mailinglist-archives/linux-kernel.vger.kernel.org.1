Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFA27D837
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgI2Ub6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:31:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36337 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2Ub6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:31:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so5786461otw.3;
        Tue, 29 Sep 2020 13:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZpDCXi33xYMdZ4fkDsToUqUQjwLCzkdHP38hkkOuS8=;
        b=nqhqO7YKx+BsdPW72qYunHCu0z4QijfLezVjRFW5QQ42rwvjNQe5wN+dtwN6RX0ykg
         n/yqzIHTyjPcxTzud7hmD8gyRucUC3/hIW3fGeVMikr1phQyzWMt9kmtCwGFiOoaNInJ
         tvye8J6vw58yAzrXmq6ewEVmrOurDQq2hzYi1iaMiywWO6SCyx1Oe5pVR0r0aGXk3yuZ
         7G1R8my5PdasSo1njoJDtN/AP5YqZsoUWQmszp/wSN2ZUkQhj/AP4c1fcNazOjH+I88+
         9F6N2fdcVU9y8fMMvAd6FZMLeYVULJC6kn6BMkp4OGs6zzMM3zapS3yiXUT5hRVMb6lR
         HsLw==
X-Gm-Message-State: AOAM532VJo96xcvbdqdyVi6H+M7Hf54fCBapKp7OE6dOT9RLr2kGaHpK
        SFCuf42Kzuz36xVeRkEpzQ==
X-Google-Smtp-Source: ABdhPJw3T9HsrVFXDzPRfCUqAvg9r56p9ZIQCTrUujFEwZ7NWfdVAZkC05VlQ0VMNHZZSbd3C0kjbg==
X-Received: by 2002:a05:6830:1506:: with SMTP id k6mr3827634otp.142.1601411515923;
        Tue, 29 Sep 2020 13:31:55 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm1249481otr.12.2020.09.29.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:31:55 -0700 (PDT)
Received: (nullmailer pid 1118419 invoked by uid 1000);
        Tue, 29 Sep 2020 20:31:54 -0000
Date:   Tue, 29 Sep 2020 15:31:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, yash.shah@sifive.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, palmer@dabbelt.com
Subject: Re: [PATCH v4 1/1] dt-bindings: riscv: sifive-l2-cache: convert
 bindings to json-schema
Message-ID: <20200929203154.GA1118332@bogus>
References: <1601381896-29716-1-git-send-email-sagar.kadam@sifive.com>
 <1601381896-29716-2-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601381896-29716-2-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 17:48:16 +0530, Sagar Kadam wrote:
> Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
> controller to YAML format.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 -----------
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 98 ++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> 

Applied, thanks!
