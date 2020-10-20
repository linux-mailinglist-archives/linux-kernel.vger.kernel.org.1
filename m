Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604E294073
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394586AbgJTQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbgJTQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:26:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B934C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:26:09 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so4374932ioh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GA3j4kL10BVeDDcoWRy/1ddShG8Wsfa1YVT0x2H+ZOs=;
        b=JAzRiB+Q67Qeq63BJsuNSLCLiTTP3Cuh2tGhJTCSK0jYz1kG0qC/Dme68yg6slYozM
         HHqNEp3v+7xeIX3nF8g0fZkrVku+ySr5VoHHA1JD8zro0lO6ROEnxE1iuK/wHUAhsp93
         Wy+LR8sTNxjvHnbo+Glnd1m4FxVF+fsy8l12P2sE2vyYZ5ZFES2MDT3wdh3s9+lBMlJx
         XM9/UsEdxKHt6iHW1EcUBi3v+DjoVF3Fh2zpbmObf/hjWPNNVDgAjJnpZm1dNqIK0cx7
         SIRx4Dbm4vy10R6O3XXknUwwooRDohyUqaj7NxZuQ9FwIYzlOH79vPqVmOiZgLkNPO79
         vPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GA3j4kL10BVeDDcoWRy/1ddShG8Wsfa1YVT0x2H+ZOs=;
        b=cFOPnSHuY1ZYpekcVFjVPezqFDRpC5+V1oVD6c+y2EMkUziTQSif/XE6qr6zkyxQlA
         Z2Gyg6k5yL3zh66lTkpczmotM6XudCPayF8oDTeh2ljFHRS7Q/ipUpSnBoI+eywno0RE
         ocj39VUD3cDD4282z8nX4K7CrRIy92aODkCSBIj7zx8sSDQCfFty1tJ68e1UcWWfhGQk
         Z8FXQ6dQn23+h9f46rZtgBPTg1c1LU6jCZwYs3gVeRYB31+9t7PiFT7iKGWluz7Y8AXd
         RgXhuykYtTPrw0WE7Ixdcam6swhv9AtjDXMEw8bnLmtghemjncc2Q+ShWryqA86vVf+i
         2SfQ==
X-Gm-Message-State: AOAM531mUtGde/u3J14NApSquX2v5OL6+cCzTcm3p1GTEoK3mbJaXuns
        0SBFOO1EmfZWpwMbSQ8mIelKdHWbrEI/eQ==
X-Google-Smtp-Source: ABdhPJxDRUmDtKje3/MxFEcDY1rDJAW0z8CPJEXUYDVHt2ApMbzOFndmAckvl4Bece0h3x7+1W/JSQ==
X-Received: by 2002:a02:cd9a:: with SMTP id l26mr2808011jap.116.1603211168086;
        Tue, 20 Oct 2020 09:26:08 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n138sm1936558iod.40.2020.10.20.09.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 09:26:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: dmar compile failure in -git
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     joro@8bytes.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d090c378-bfb4-34bc-7091-64e2b83925de@kernel.dk>
 <D8207C14-26C9-420D-9AA4-1E6D3F2F2191@infradead.org>
Message-ID: <5646206e-ca52-4b1f-6182-4cb760ba712a@kernel.dk>
Date:   Tue, 20 Oct 2020 10:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <D8207C14-26C9-420D-9AA4-1E6D3F2F2191@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 1:03 AM David Woodhouse <dwmw2@infradead.org> wrote:
> On 16 October 2020 22:23:46 BST, Jens Axboe <axboe@kernel.dk> wrote:
> >Hi,
> >
> >Ran into this one yesterday:
> >
> >drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
> >drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no
> >member named ‘ops’
> > 1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
> >      |                                         ^
> >make[3]: *** [scripts/Makefile.build:283: drivers/iommu/intel/dmar.o]
> >Error 1
> >make[3]: *** Waiting for unfinished jobs....
> >make[2]: *** [scripts/Makefile.build:500: drivers/iommu/intel] Error 2
> >make[1]: *** [scripts/Makefile.build:500: drivers/iommu] Error 2
> >make: *** [Makefile:1777: drivers] Error 2
> >
> >which is due to the config I use:
>
> Thanks. Should be fixed by
> https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg45697.html

Can we please get this known build breakage fix upstream? It keeps
breaking my test box compiles, which is pretty annoying.

-- 
Jens Axboe

