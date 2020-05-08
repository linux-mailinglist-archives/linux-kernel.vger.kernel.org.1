Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65C1CBAEF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEHWw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:52:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F49C061A0C;
        Fri,  8 May 2020 15:52:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so12386010wmc.5;
        Fri, 08 May 2020 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WpsbmFr34r/z7Vvaga9c8bP7hFD8XFkqa4vrJTCUU20=;
        b=fQr+nYI08FQGL6H7MhUIYs3wQMkrKzGrnCfxvarT/AQ1+Jqx3KP5k0RV5ahRZD0iyv
         Z78MUzNujRRXrW8yMSkfilrGEtybvnZnWiy/oOgoZB/fUu61ycAB0w835U80dVED+H6q
         ZATeJJtqA7PDiEZUXdvWMANoFya+nDiQenPZLQxVpRT1xgwNPdcEIpelD+F1McDQGCHY
         DTvG+KF/5kuK0G95Gcfpz9RZzA87WIvkm9rAQLfBN34aBnGifHaLYNSAcA8Ct9ijudWU
         J8sJukrlABsIeI3Zr+axhf5K0vhd6pyOSednFrul+mb9DOkGUlBiDBUKdTKI70GV7ug5
         vQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpsbmFr34r/z7Vvaga9c8bP7hFD8XFkqa4vrJTCUU20=;
        b=oIStivhJn2ajRrhUjrT9XzNrYj4OzFrfYwAtd53GuswafoNGCh3Frtqz8EDrJP5mkK
         cg34FOajOUG6/iCBNduWrvC1oyPy0RIuDJvkWLrxdxIgeQQH2Nj1ZEIBshPU6y9IWt2v
         /zz2WInIhQgkntX7WalnVQ2v72bSG/zpSL0UXXzGgZPU9BfphAMtfQzDYVrom6gwhUNw
         dbBmlX1yLw2YDOsIs52L/eyMDcTm3bci5P2OPjzCu7YEYWJLSEQVJwfIlhCovcJ3Xfcw
         GJX9itpezInP19XIf2HC1P/x5rb9qoDC8fXPIRibEeWD7ZXHyivV4gkhmEW/SprgGOC0
         eNAg==
X-Gm-Message-State: AGi0PuZJFEyoa6KXMBdBBJD9JzjIhpp+6GEvfNIeJu0/nstg677UwzpO
        dG4xygzsWZ2vN/z4zTwjkjg=
X-Google-Smtp-Source: APiQypIhiz+fO+JBgPd6XJG0+lXiYaWerz9NVH6QhBdEQPz2qjDHpCnnr1/84JwAGMVPjcNUEwwEzw==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr19405733wmj.100.1588978345157;
        Fri, 08 May 2020 15:52:25 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x7sm14618291wmi.17.2020.05.08.15.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 15:52:24 -0700 (PDT)
Subject: Re: [PATCH v8 4/5] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
 <20200508211929.39020-5-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <20f7eed5-4364-3466-05d4-1e350abeac88@gmail.com>
Date:   Fri, 8 May 2020 15:52:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508211929.39020-5-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2020 2:19 PM, Al Cooper wrote:
> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller. The primary workround is for a bug where the Core
> violates the SOF interval between the first two SOFs transmitted after
> resume. This only happens if the resume occurs near the end of a
> microframe. The fix is to intercept the echi-hcd request to complete
> RESUME and align it to the start of the next microframe.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
