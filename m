Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B82C91A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgK3WxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:53:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46918 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgK3WxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:53:18 -0500
Received: by mail-io1-f66.google.com with SMTP id d8so12408593ioc.13;
        Mon, 30 Nov 2020 14:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQxo5nO8zmqw2jwvx/vy+F9rgLp3uMdl3MFsTPmA484=;
        b=s+oxCt+2RXVRvLJF1FMNJ1YtWHM6NU9jW2ACplK362nJyB2O0zlf8PfPErv3GWYqh+
         Gs8d55+HloylGkl/3hfNrETyle1rYWx+HT6XNbBMpAkG/7fEX00j5N12g4r+o1vfKrGG
         OtXVQ5K/sEDxKPws4KnihdGAS5b78QALA8NSsebXzFraRx/5GmJFu4XhDnhCbImZOI4u
         GxnvHlG4NeP6zC/pyTYcvJTMVmQZjwzbJpdz4mFcMhZj+SJ1npLAnTNWzv9HwFiQm942
         lhdaNyhBsRh9N3BG9hC+k5Vkd80ZQo9nTyn/NF/a1RmViwdqtxN+T3eU14GhSiACmLqc
         XICQ==
X-Gm-Message-State: AOAM5323jPffxtFcgPmskjNBYSEsRFG6DEyiFquAunbM6nS0zoeLE39m
        W27HJW+vYPCJtLShU3hOVA==
X-Google-Smtp-Source: ABdhPJydhW/G4MdLCL1q9Gm4u1FaokUX5UUzaA1Sb7cgD7Rk6NHP4vg7vt34/NMJkGVTxiSbjNX0Ig==
X-Received: by 2002:a05:6602:14ca:: with SMTP id b10mr71037iow.40.1606776757519;
        Mon, 30 Nov 2020 14:52:37 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r4sm5231004iop.24.2020.11.30.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:52:36 -0800 (PST)
Received: (nullmailer pid 3188013 invoked by uid 1000);
        Mon, 30 Nov 2020 22:52:34 -0000
Date:   Mon, 30 Nov 2020 15:52:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        devicetree@vger.kernel.org, Steen.Hegelund@microchip.com,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/6] dt-bindings: interrupt-controller: Add binding
 for few Microsemi interrupt controllers
Message-ID: <20201130225234.GA3187956@robh.at.kernel.org>
References: <20201125103206.136498-1-gregory.clement@bootlin.com>
 <20201125103206.136498-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125103206.136498-3-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 11:32:02 +0100, Gregory CLEMENT wrote:
> Add the Device Tree binding documentation for the Microsemi Jaguar2,
> Luton and Serval interrupt controller that is part of the ICPU. It is
> connected directly to the MIPS core interrupt controller.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
