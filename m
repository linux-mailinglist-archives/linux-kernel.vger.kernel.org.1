Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66241275246
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIWHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWHZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:25:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A40C061755;
        Wed, 23 Sep 2020 00:25:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so5927793wmm.2;
        Wed, 23 Sep 2020 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63bE4w/V+85rYMI6Z+GuGmdQ20QRZeJUTe66Kkw6BBg=;
        b=lT/sPrDZKA100GJ4e8naAN7q0DddHWKJK7fkVQHKzZCwhbLcP+8KQogNTik8DMJhJe
         1hWxT6GwYUKRmFif0MhrajQzR2S7UDhyXr4VxmxQXJF8EuBN+2wmPRPX6wLwWsiAyx8z
         fART+ppKnUOIxBHplH5F1J9i5g7wyQl8E5uAd7z4nahixb7aJJsFOMGIRRuTJIGlTg+e
         RucIM7agw+pN6N2gVmjBst5tLkEljRdZih5yjQr1DhalbbQ1ruVvOvdS1/gyg52IzgNs
         b/KqBvWTfCuK0jc3QfSqcT/8z29wYoh3xA3xB6h1t7IsvRzZeK1xZYVjbyj66gD6mauO
         kTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63bE4w/V+85rYMI6Z+GuGmdQ20QRZeJUTe66Kkw6BBg=;
        b=PfRO8PGGfmCGLmsLlVlRXHe57r0h9HGSB9moBL+XKdHWyh0xg/v0KYlDrE8e1iredK
         JFWxm/lSHveAFELFWOC1n0yXg7xyVBEGt1o02nCHnWvVYCEjeJ56jBPduRlJw3pkotNP
         Qi/SLELKCsyrloEJ7lZeBCSRju7WlfkFpcejAqsWq5wC0pv7s5KXKgj5zD7lLc9voB1Z
         QvYgCbUI6OFi7eUblSrH9xDJFX76aqcFCGHe2ViCWfIyXzGouZYt1z1Yjz2TDKfINa+R
         OdtFCJB0TqHk68pSJtWZsWVqU66VA9olrxh4DmLNplP/mbDax/Da3yn+m5VtEtmObRNx
         Zj/A==
X-Gm-Message-State: AOAM532SUSJZOS30Iq3PxEI3t/N58jiHQ3IMFHEwU5TaIFuS4JW3htf6
        qp9xlhDMwJExD4oNqSo1cUI=
X-Google-Smtp-Source: ABdhPJzm9uAd6IV6nXmsv18oqTyueTrQD+GQ6AEGUTF0vrwASDMXrCrEhOcXy8YC7rhSePx+2EhuXw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr5147626wmm.102.1600845904146;
        Wed, 23 Sep 2020 00:25:04 -0700 (PDT)
Received: from BV030612LT (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id j10sm30422790wrn.2.2020.09.23.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 00:25:03 -0700 (PDT)
Date:   Wed, 23 Sep 2020 10:24:49 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20200923072449.GA31426@BV030612LT>
References: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
 <c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1600114378.git.cristian.ciocaltea@gmail.com>
 <20200922234207.GA3490335@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922234207.GA3490335@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:42:07PM -0600, Rob Herring wrote:
> On Mon, 14 Sep 2020 23:27:17 +0300, Cristian Ciocaltea wrote:
> > Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> > and S900 SoCs and provides support for handling up to 3 external
> > interrupt lines.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v7:
> >  - None
> > 
> > Changes in v6:
> >  - Got rid of the 'actions,owl-sirq' compatible, per Robs's feedback
> >  - Replaced 'actions,ext-interrupts' with 'interrupts', as agreed with
> >    Rob and Marc
> > 
> > Changes in v5:
> >  - Updated controller description statements both in the commit message
> >    and the binding doc
> > 
> >  .../actions,owl-sirq.yaml                     | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks,
Cristi
