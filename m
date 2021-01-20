Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D292FD62F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbhATQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:54:48 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39484 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403809AbhATQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:32 -0500
Received: by mail-ot1-f41.google.com with SMTP id i30so11078511ota.6;
        Wed, 20 Jan 2021 08:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Nevn/Hsb1/pSSLD/4PKRZrIOGJGLolaHEVGjwXHh7g=;
        b=VA2JRK6XbQyUxFc+e7gPWkoHVPvfxNWup/KTgzs0Uv5WL/yfgobfQ85evNGxJwciMM
         rnmkNcoVMhtWFARSD669/fR2dXDMfp/UWRwiRbPAoqq7zGxbGl33m+lRlpG+kpqOkAEg
         sbIjwVz2hAUyMErC7r690IT7zxidG6JD17sk468HfqhYZLgOk4NDBgnSyrfRzT5rfWWz
         GLG+w4DdIJVpu0QvKmjYxTlopoz80ljRcEjX37uP7i2gjV8ao5uplrqOT4NWNaZBPHY1
         1NtofNDmfgYK9Y2qGVQXcI76EevwEwPD+UCgwEx1spHLLe2om3Mej32UVMx28UuzHJ9X
         n4SA==
X-Gm-Message-State: AOAM532cPJQsOpJQ53EEpQQgeLmGgL2ccs6WmRCa32mSkcXDM8WIufXW
        P7dKqknY2D2iwQzj7mNzNw==
X-Google-Smtp-Source: ABdhPJwaG3j9UrY6/UvK8tGFavZ8pchhV25GbY2yn1OpU1TWw5L3kI0PQYj6i0y3Xx2xzLR+yGRYiw==
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr7356498otq.322.1611161630884;
        Wed, 20 Jan 2021 08:53:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm444480ooh.32.2021.01.20.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:53:49 -0800 (PST)
Received: (nullmailer pid 328496 invoked by uid 1000);
        Wed, 20 Jan 2021 16:53:48 -0000
Date:   Wed, 20 Jan 2021 10:53:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210120165348.GA220770@robh.at.kernel.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-6-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-6-tientzu@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> Introduce the new compatible string, restricted-dma-pool, for restricted
> DMA. One can specify the address and length of the restricted DMA memory
> region by restricted-dma-pool in the device tree.

If this goes into DT, I think we should be able to use dma-ranges for 
this purpose instead. Normally, 'dma-ranges' is for physical bus 
restrictions, but there's no reason it can't be used for policy or to 
express restrictions the firmware has enabled.

> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index e8d3096d922c..44975e2a1fd2 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - restricted-dma-pool: This indicates a region of memory meant to be
> +          used as a pool of restricted DMA buffers for a set of devices. The
> +          memory region would be the only region accessible to those devices.
> +          When using this, the no-map and reusable properties must not be set,
> +          so the operating system can create a virtual mapping that will be used
> +          for synchronization. The main purpose for restricted DMA is to
> +          mitigate the lack of DMA access control on systems without an IOMMU,
> +          which could result in the DMA accessing the system memory at
> +          unexpected times and/or unexpected addresses, possibly leading to data
> +          leakage or corruption. The feature on its own provides a basic level
> +          of protection against the DMA overwriting buffer contents at
> +          unexpected times. However, to protect against general data leakage and
> +          system memory corruption, the system needs to provide way to restrict
> +          the DMA to a predefined memory region.
>          - vendor specific string in the form <vendor>,[<device>-]<usage>
>  no-map (optional) - empty property
>      - Indicates the operating system must not create a virtual mapping
> @@ -120,6 +134,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  			compatible = "acme,multimedia-memory";
>  			reg = <0x77000000 0x4000000>;
>  		};
> +
> +		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> +			compatible = "restricted-dma-pool";
> +			reg = <0x50000000 0x400000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_device: pcie_device@0,0 {
> +		memory-region = <&restricted_dma_mem_reserved>;

PCI hosts often have inbound window configurations that limit the 
address range and translate PCI to bus addresses. Those windows happen 
to be configured by dma-ranges. In any case, wouldn't you want to put 
the configuration in the PCI host node? Is there a usecase of 
restricting one PCIe device and not another? 

Rob
