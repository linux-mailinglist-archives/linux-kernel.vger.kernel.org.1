Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D8026CB53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgIPUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:25:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38734 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgIPR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:27:38 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so7266587ilp.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzLg3ZfFwjb5ztn4qpshcHnu8BZ+evVJsI0I2BOv1lg=;
        b=MMPU5YKfARq6hdiCsnivKs4l/ZKW/3N5oag8F0FaZoHrvrzT/ByUO5styFp8XwvFO4
         sjwJe+zDvdGYSKyly2eJNDCfkKr7ZsgHa5wce7TJ7CNAXXxSqea4IZaZjFh0pDtco6ti
         9eHbOxTxZCBGOTbQQEuv60Cudr7bsA6MymACrpCtSIBMqBPsZMnL03yVKmGWxYYAmWc+
         HiseDwdKoc3r3z8qC5DjuDZ9k/X+aQrZd3MtxrUWpVSFx9kIHvtwzLlLJzfzls+m8cWc
         hgpSsbgFGosQxdzpudnfQ/KmbXPiOhkbjUZj+cmqFELqkpoPgfF0ZREdqi/G7J69ccD9
         HsTQ==
X-Gm-Message-State: AOAM531DADzBt3KE1uZKgDke7XFjKIt2AlCQWb7WqjZEEln8ZuyQYNvY
        VTEIzT2P+gcwXcmRHZnxJwekd/oJQzrk
X-Google-Smtp-Source: ABdhPJz+eZmBm1fA84xLrVeztI2UZvbXmOzM08dD6YdLXEvTuwJKtqpMZXzXcVPqUG9WujyLVxfY4g==
X-Received: by 2002:a92:dc43:: with SMTP id x3mr21323380ilq.199.1600269894014;
        Wed, 16 Sep 2020 08:24:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o10sm11131350ilk.36.2020.09.16.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:24:53 -0700 (PDT)
Received: (nullmailer pid 3994973 invoked by uid 1000);
        Wed, 16 Sep 2020 15:24:51 -0000
Date:   Wed, 16 Sep 2020 09:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 04/10] PCI: brcmstb: Add suspend and resume pm_ops
Message-ID: <20200916152451.GB3991893@bogus>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
 <20200911175232.19016-5-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911175232.19016-5-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:24PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> and resume.  Now the PCIe driver may do so as well.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
