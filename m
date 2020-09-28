Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B827AD87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1MLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgI1MLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:11:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28155C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:11:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so1047667wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dSCxwiqKRk3ATbymtzeQC9qksnA3TkeXNr9IJqsFWpQ=;
        b=wy0o6NnsOoh0GoAIIctBC1EbY6C5mrNEkbGncKCRB8r1m35TuKrtJCBU5hfpSsAkKF
         r0ovnbrRLOgcHsG+gRSGr2NZOv0v4Mxx8mhkbdxjxF2b0n035KEWdylsfGskjykUYVmM
         O+nAG1LlqktH7cZgy9UgxxG0KTv4d8UMZ23jNiLliWM4n8Y+xJiwZYMRP+8YNoUnmdjS
         u6JRzAIX62VL+TSvCyQF3xYU4QMvCN+1BdKu9xs4/s69w6BnSNUfdRvm9T/yOlZK8hI9
         92oCSRe41tpm0QWt3Ov6VuEA+MZi5k/gldVA3ZLpcPqDtneLF8wPx3FY7I8eKIS7QdB+
         ghHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dSCxwiqKRk3ATbymtzeQC9qksnA3TkeXNr9IJqsFWpQ=;
        b=StakVV/863iG9q/B+l0osaZRjkLLgG/cY2GsBSgG5lVBITrkR6Oy9uQTgy7bdU9gUf
         aVy92quURqVrPEMvQaG+Vqzu5snrUcGm1/dQAj5Rdm6sBEil9P6LkfBKJbmFiwTHrN3+
         EnlzzGuzmNHN2e0JlzmQdyvaV8Gq7f5+EufMPBMBL9eSw/nECJmZJ820gEgtRvoH3dnz
         OwojQE0JxeNjDWLBvOmwxa9euaIkmOUaWepnfKRhrFTmZMi8r+L1/1M9lKOiLey4B1LR
         Lww+YsAPOduWvFV7dt4gqiOOJBvYC1vcXR2g3mjR4tFJIyxkri4SZ1pQFl2v84+03xMo
         3xBw==
X-Gm-Message-State: AOAM530p3HZty9tfOkqyKHODryr3iLcNaboN8/tznltnysMkdqNnxwoV
        S1sftVU5te9Xaq/56Yys6n0TUiwLEMDaNg==
X-Google-Smtp-Source: ABdhPJzqVMSev9ryvCDq2ToJJdkuTi2ySD22RS2nWyED1C0kALSNSjpl7eOCyQ2HMK0sHSXUsb6ckA==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr1483046wrn.394.1601295079756;
        Mon, 28 Sep 2020 05:11:19 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id z9sm991104wmg.46.2020.09.28.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:11:18 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:11:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: lp87565: convert to yaml
Message-ID: <20200928121117.GD4637@dell>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
 <20200902142259.28349-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902142259.28349-2-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020, Luca Ceresoli wrote:

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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
