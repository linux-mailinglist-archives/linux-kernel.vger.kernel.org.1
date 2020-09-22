Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C3274D72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIVXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:42:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41893 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:42:10 -0400
Received: by mail-il1-f194.google.com with SMTP id f82so19015474ilh.8;
        Tue, 22 Sep 2020 16:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3LREYHOAe6KBBDJ72chqebiJacmUeECiPcO9j+F2Cs=;
        b=AGcsR7a8K/SstV4ORDipw77ICNTvQXdcm4YCF0OaRYDQnv1YWdMYCy//wPKmXBIOxu
         3O7N3001XByUmmh+m69dIDV3xfVwC6xRGn0o7rNbCOkStENla6eTUABgE8QE8BAnmwlK
         f7hHBySGlG2Ola5xucsvhRWYWR03P+X3W3jtLWyoU8D3Tk7CXBkP4HsTzbeIPkPZB4HJ
         UuLAYWKA1du4CpQoPj+LEK4n+Tl9FSQJ0kfcDmzFGzqS2XZzARYKCP/yCv4JvyPNcDHd
         0DNjQFOkEiffurCw//pdUZCEKnnpHEUmOQNqg15cb/B0HEgxa6fhBaSAeeBIrBFPAmx7
         /zSA==
X-Gm-Message-State: AOAM531vW6/GRnkibRUT3m0D4OmjBfRTYPB8c5lB1Aml+q2gnIwGIx2p
        lPdLsC/qudHiILG8L+3PDQ==
X-Google-Smtp-Source: ABdhPJyHPVqxyKHEsa6FybwS3z0bnO0mRtAEVRacG4LxXr2EbVZEYbdzay+p6EVRT9EQflUfrT9OtA==
X-Received: by 2002:a92:cd06:: with SMTP id z6mr6259385iln.252.1600818128906;
        Tue, 22 Sep 2020 16:42:08 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i144sm7993950ioa.55.2020.09.22.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:42:08 -0700 (PDT)
Received: (nullmailer pid 3490365 invoked by uid 1000);
        Tue, 22 Sep 2020 23:42:07 -0000
Date:   Tue, 22 Sep 2020 17:42:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, parthiban@linumiz.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
Message-ID: <20200922234207.GA3490335@bogus>
References: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
 <c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1600114378.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1600114378.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 23:27:17 +0300, Cristian Ciocaltea wrote:
> Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> and S900 SoCs and provides support for handling up to 3 external
> interrupt lines.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v7:
>  - None
> 
> Changes in v6:
>  - Got rid of the 'actions,owl-sirq' compatible, per Robs's feedback
>  - Replaced 'actions,ext-interrupts' with 'interrupts', as agreed with
>    Rob and Marc
> 
> Changes in v5:
>  - Updated controller description statements both in the commit message
>    and the binding doc
> 
>  .../actions,owl-sirq.yaml                     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
