Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C79269653
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINUXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:23:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46681 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgINUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:22:09 -0400
Received: by mail-il1-f196.google.com with SMTP id u18so789544iln.13;
        Mon, 14 Sep 2020 13:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q3VLEWo21v2+lZTdcr9NdzAw5X4kkAT4u8wJ7jG84ss=;
        b=KSrbsamtduTS3F82oTYfzqAkvyO6GLb3ZnI9vbbkyFRyaGiWvGeP5ud/bMbE3m04dT
         CrWF4jRQSp0IUq215FkAhEvu1a/KHeVdvUn1tMMg2lmZZ1/Hbu9oCNDdfRFfxroTtoz8
         4lo74yLAZb6bMYZrz/9eKLeqPnrZcF4RjYjZ1wYXNsgVwXBEDtLVQ/HEPqFxjKrO4Bfo
         mOpeJm75gpH3UYO3dO7WAUlFe6F0qzBtennW2r++818ewgRajrDGqDhQwMVYjvnE2CKO
         phdWnR+qPxADYlqpinp7SnEBujv+SkftvPAqZMmtBgErwe0Het4MpiOgUJ7O6Cc1AXX6
         8hwQ==
X-Gm-Message-State: AOAM532SOf9xhoAMaMrwrI7K5Z4faVHlh6bei7+PIhF/zxzDOg67f75C
        8TlYVPU5fhFtb+OTSSqECQ==
X-Google-Smtp-Source: ABdhPJyniwnr5IE6wyOFmgy00AYDRyRtCwTYvLXcSptoPP/IL0tjD7xbnDmScKhZDMLaiLwl1mz4tg==
X-Received: by 2002:a92:6f11:: with SMTP id k17mr14265378ilc.178.1600114928698;
        Mon, 14 Sep 2020 13:22:08 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f21sm6436833ioh.1.2020.09.14.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:22:08 -0700 (PDT)
Received: (nullmailer pid 176338 invoked by uid 1000);
        Mon, 14 Sep 2020 20:22:07 -0000
Date:   Mon, 14 Sep 2020 14:22:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Axel Lin <axel.lin@ingics.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: lp87565: convert to yaml
Message-ID: <20200914202207.GA176255@bogus>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
 <20200902142259.28349-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902142259.28349-2-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 16:22:57 +0200, Luca Ceresoli wrote:
> Also apply a few smaller improvements:
> 
>  - document that the only possible I2C slave address is 0x60 as per the
>    datasheet and fix the second example accordingly
>  - The definition of "xxx-in-supply" was generic, thus define in detail the
>    possible cases for each chip variant
>  - remove "MFD driver" from the title as it is implementation specific
>  - replace "PMIC" with "buck converter" in title as it is more informative
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v5:
>  - describe the "regulators" node too (Rob)
>  - add 'additionalProperties: false' (Rob)
>  - simplify supply description
>  - update commit message
> 
> Changes in v4:
>  - split in two different bindings (Rob)
>  - remove "MFD driver" from title as it is implementation specific; also
>    replace "PMIC" with "buck converter" which is more informative
> 
> Changes in v3:
>  - fix yaml errors
> 
> Changes in v2:
>  - this patch replaces patch "regulator: lp87565: dt: remove duplicated
>    section" in RFC,v1 (Rob Herring)
>  - use capital letters consistently (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       |  79 --------------
>  .../bindings/mfd/ti,lp87561-q1.yaml           |  83 ++++++++++++++
>  .../bindings/mfd/ti,lp87565-q1.yaml           | 101 ++++++++++++++++++
>  3 files changed, 184 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
