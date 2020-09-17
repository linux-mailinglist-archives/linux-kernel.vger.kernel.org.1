Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAD26DAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIQLqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgIQLoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:44:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:44:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so1710025wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/xNh3KK7BcpDa/un4n60xPyDcwsxLG5qRFTw4dutHI=;
        b=mw2CaSdDgO2djAMShMNS+yV5rBMcw37ffv1hnAUlPtneAb/Spmn/TuGEh3Q3kNrI+d
         okiHJyzCYoYYz6zAWHpaqzvMvLl4mADzo1Kw5gD6IbwVN7bPhftUsKuDfW8U7GRXo/Fh
         +p75QvjR8tsdFqKwTSq2jhQieyrGaQGkJDK6zSQTsuVT9cTyBJOVfGoikhz4PmVyy+lj
         beXtLcvhmuCcqxphryNnrFiRCXGJGfWyym6gEh/Hn3imxC6Xsz1IiqI+E6HZFRM8TynB
         6OYVwfW9r54d1gIu8c3n2gdOLnBiMFRey06OGNLQEdlkZhhiT2w7ZFEkQ9FzUKjgSCYX
         JcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/xNh3KK7BcpDa/un4n60xPyDcwsxLG5qRFTw4dutHI=;
        b=RbtwgYoxXVIL/el+Ak9hdufo+DC0bGnffNDuql76MFYULaSER2QsNvWCn1ys1SSvwK
         /+aDUMgnKgDIPhptiC0fWTgVb8aM7vOYNCSE2cZ8tbulnA/ReNboG6gr5LtBLrxhbTf8
         YTY6Cv4EMT97zhStMlrS+DMczjsZJH9dRyQnfTduLIMRGvlgOmpGnsNQDTTz5p6vj7cY
         ozPOS7NVt92gjekf3cw0T2TBx+XOEdIQ5M+TKPOkkgX5Cm0wzy7d8dq/6JJDKoZQToIT
         qAwdgkDbEoTp6kCIwkV1NZzko2mph0UyOKm8O5MHQBLye/FzkjuXyK8LBx9pSB1t9gwd
         ZwNg==
X-Gm-Message-State: AOAM530N3459H+dsxdpmjkIkBuGtEX0FlrVc3Mo9d8a6+FNzXbBiVqON
        g5IlL+GM8jC2lZQA6qhlftWLRQ==
X-Google-Smtp-Source: ABdhPJxorxK4ik5Io6/q+rnDtp1V2PR0T3H03RS5/LrOQIskiZ3SLWoGSEoc7BKLAGuaQaOOmF3kow==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr9211873wmj.57.1600343052160;
        Thu, 17 Sep 2020 04:44:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:7220:84ff:fe09:a3aa])
        by smtp.gmail.com with ESMTPSA id m18sm10538595wmg.32.2020.09.17.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:44:11 -0700 (PDT)
Date:   Thu, 17 Sep 2020 12:44:11 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gprocida@google.com, kernel-team@android.com
Subject: Re: [PATCH] ehci-hcd: Move include to keep CRC stable
Message-ID: <20200917114411.GB3897889@google.com>
References: <20200916171825.3228122-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200916171825.3228122-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:18:25PM +0100, Quentin Perret wrote:
>The CRC calculation done by genksyms is triggered when the parser hits
>EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
>types of the function parameters, and uses that as the input for the CRC
>calculation. In the case of forward-declared structs, the type expands
>to 'UNKNOWN'. Following this, it appears that the result of the
>expansion of each type is cached somewhere, and seems to be re-used
>when/if the same type is seen again for another exported symbol in the
>same C file.
>
>Unfortunately, this can cause CRC 'stability' issues when a struct
>definition becomes visible in the middle of a C file. For example, let's
>assume code with the following pattern:
>
>    struct foo;
>
>    int bar(struct foo *arg)
>    {
>	/* Do work ... */
>    }
>    EXPORT_SYMBOL_GPL(bar);
>
>    /* This contains struct foo's definition */
>    #include "foo.h"
>
>    int baz(struct foo *arg)
>    {
>	/* Do more work ... */
>    }
>    EXPORT_SYMBOL_GPL(baz);
>
>Here, baz's CRC will be computed using the expansion of struct foo that
>was cached after bar's CRC calculation ('UNKOWN' here). But if
>EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
>trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
>late, during baz's CRC calculation, which now has visibility over the
>full struct definition, hence resulting in a different CRC for baz.
>
>The proper fix for this certainly is in genksyms, but that will take me
>some time to get right. In the meantime, we have seen one occurrence of
>this in the ehci-hcd code which hits this problem because of the way it
>includes C files halfway through the code together with an unlucky mix
>of symbol trimming.
>
>In order to workaround this, move the include done in ehci-hub.c early
>in ehci-hcd.c, hence making sure the struct definitions are visible to
>the entire file. This improves CRC stability of the ehci-hcd exports
>even when symbol trimming is enabled.
>
>Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>---
> drivers/usb/host/ehci-hcd.c | 1 +
> drivers/usb/host/ehci-hub.c | 1 -
> 2 files changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
>index 6257be4110ca..3575b7201881 100644
>--- a/drivers/usb/host/ehci-hcd.c
>+++ b/drivers/usb/host/ehci-hcd.c
>@@ -22,6 +22,7 @@
> #include <linux/interrupt.h>
> #include <linux/usb.h>
> #include <linux/usb/hcd.h>
>+#include <linux/usb/otg.h>
> #include <linux/moduleparam.h>
> #include <linux/dma-mapping.h>
> #include <linux/debugfs.h>
>diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
>index ce0eaf7d7c12..087402aec5cb 100644
>--- a/drivers/usb/host/ehci-hub.c
>+++ b/drivers/usb/host/ehci-hub.c
>@@ -14,7 +14,6 @@
>  */
>
> /*-------------------------------------------------------------------------*/
>-#include <linux/usb/otg.h>
>
> #define	PORT_WAKE_BITS	(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E)
>
>-- 
>2.28.0.618.gf4bc123cb7-goog
>
