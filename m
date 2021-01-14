Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220742F6BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhANURs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:17:48 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45605 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbhANURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:17:47 -0500
Received: by mail-ot1-f45.google.com with SMTP id n42so6371153ota.12;
        Thu, 14 Jan 2021 12:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mGHLGcG+fywDOIWv6535mLboQsZK9zujR6OLm58YUu4=;
        b=PuwE6T2B0sWUfwE20m25f+m7KEdmYek23P1PBxnQ18wbqMkf7KB3j7FNvCHp0e8/9S
         gnu7fE5IOqg2PbioHhgSvffiINuDEG1vV0pfcI54GfEsF+i2hiNq4hrTj2OKMyqi4W42
         QleaUtRMULKK/GSWIYwFImjWJsSPsPFiPMREPq1I6GrgKsUzYmaEQQXfkqGnhCbCVJKB
         FhbxWPi0P2f5clg+yaIJmxvooF2OwPf63Yos1XPieKoqiTYodiNcrpyidyHEeiN5Pes1
         rX7gLkc4gdXi38bGVnRF3TqPnH5m82d/5/V4+096/cTnf3Dr/h6iT/xpxuy+w0gi0fkE
         fdCQ==
X-Gm-Message-State: AOAM533qdNzxqxiP4war/hc2JmU37xNGjtCFnU4YD8RlPju5wEALVXjv
        ZdA0Ni8XqhlE7Sq9QQPio5cJYctu7g==
X-Google-Smtp-Source: ABdhPJzFZXNmojmUssMedbd8EPqAAmbYxFcQvkQmHlvqQoYzfUWnSx7dHUxGCKL7+HvmlQe2loxIlw==
X-Received: by 2002:a05:6830:118b:: with SMTP id u11mr5807949otq.130.1610655426475;
        Thu, 14 Jan 2021 12:17:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm1278096oof.31.2021.01.14.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:17:05 -0800 (PST)
Received: (nullmailer pid 3520269 invoked by uid 1000);
        Thu, 14 Jan 2021 20:17:04 -0000
Date:   Thu, 14 Jan 2021 14:17:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     tim.gover@raspberrypi.com, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, phil@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: nvmem: Add bindings for rmem driver
Message-ID: <20210114201704.GA3520207@robh.at.kernel.org>
References: <20210112142342.7290-1-nsaenzjulienne@suse.de>
 <20210112142342.7290-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112142342.7290-2-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 15:23:38 +0100, Nicolas Saenz Julienne wrote:
> Firmware/co-processors might use reserved memory areas in order to pass
> data stemming from an nvmem device otherwise non accessible to Linux.
> For example an EEPROM memory only physically accessible to firmware, or
> data only accessible early at boot time.
> 
> Introduce the dt-bindings to nvmem's rmem.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v2:
> - Run yamllint and fix indentation issues
> 
> Changes since v1:
>  - Update schema to new driver design
> 
>  .../devicetree/bindings/nvmem/rmem.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
