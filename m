Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484662C50F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbgKZJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgKZJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:20:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB6C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:20:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so1312287wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vjnri2iG884jsAbEDtenGOoYQ0PUwGM2neI6pEIa5dc=;
        b=E4q1C0OhNiqgpJRWbspAskdXQUtb694RK9cHy3KQGyn4VMInesTx0hP5NyEwaf/iIq
         wm6Xtgdwz6inZ0QyqTud1/5vMQeoOcShkRBGjBsNNeu66oUOB1/ewB/ZnrQgHdjFO57z
         TmDloB/kZKJ8oq7nNAerejkEAtnYzDlK7Hpmb+adcmyw5GCVjWRpTaRLmRWm/27rOI25
         9bPYY4caUgNQ7lf+ic0my/cnnN07m2arAdmw5uEe6KRbd+Il5ckAGisDfM9tKGglE0Zi
         kq87RjvTDFNICKa8PnKl3v2nfyDwDCWy+I/76Ll/vr/OraO4Lt6ek5kk8f2KqKUTOGJW
         feKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vjnri2iG884jsAbEDtenGOoYQ0PUwGM2neI6pEIa5dc=;
        b=dF/YLO5hm6SGkMY+bYV3SdL8dJxQcxclbvTfaKao5lfwlUWrijOcxtb3RdL4+ssBR5
         e7cYrT/0awBDsZLujr33hAmMI+VoTIjHj4pWubNQCBReY0pijYg/URrLTdUHCezDGeiV
         euqLGgezabeID740M+UyAMs0wBRbOpTrp4wo7y8a7A1Sh++W/Hm4gcB5Zm1XXU4wPg7X
         H9T9hSHD8gbg9105b/qvKIUmEENHhxzG5THronJScj9m7GN0kD3QgL1L/WqTPGEbrEOd
         6g9jj/DCFo5vPMcinO9CjiRD7bZhfLVd+nSkDQ4NZ7+poSpftEGrtp8ukMYCtsBi7epC
         sKEQ==
X-Gm-Message-State: AOAM5329HDchBK6+qHMki4XhWEwgCXJ3ndhahASdvzZH5jgbh2b3yXwt
        ruvdc0n5RVZQDJKbTyzU6UagSw==
X-Google-Smtp-Source: ABdhPJwyQTAl+vIICKHZZXXyNsl5/ZUR3KUvyPfg0OL/W2B4swO4CCBJ64qFtF+RVrbSp/mSsgUquQ==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr2616604wrw.123.1606382441862;
        Thu, 26 Nov 2020 01:20:41 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id a12sm8651164wrq.58.2020.11.26.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 01:20:41 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:20:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] soc: bcm: brcmstb: pm: pm-arm: Provide prototype
 for brcmstb_pm_s3_finish()
Message-ID: <20201126092039.GB2455276@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-2-lee.jones@linaro.org>
 <20201104032507.565008-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104032507.565008-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, Florian Fainelli wrote:

> On Tue,  3 Nov 2020 15:28:14 +0000, Lee Jones <lee.jones@linaro.org> wrote:
> > brcmstb_pm_s3_finish() cannot be made static because it is referenced
> > from brcmstb_pm_s3(), so let's provide a prototype for it instead.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/soc/bcm/brcmstb/pm/pm-arm.c:395:14: warning: no previous prototype for ‘brcmstb_pm_s3_finish’ [-Wmissing-prototypes]
> > 
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> Applied to drivers/next, thanks!

Does your branch not get sucked into -next?

Only it's not currently there.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
