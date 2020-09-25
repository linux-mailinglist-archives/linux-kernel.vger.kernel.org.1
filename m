Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD4279329
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgIYVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIYVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:22:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD34C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:22:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so3641671pge.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H/xkNUQ9AL53IRTQws0KA1y4kWYJ8e6J7sN1LrxVju0=;
        b=x5Z7WdMZDXjclD+BlNPj+JsPJPPxljnRj672cYVxJX5698lFVwTIWXERE90CCTUyYp
         J4lKJhVOkZn4TOfmfq9J5OrsTur0DMEXqoEYOD/wTs2BXWE31nkSgW3Hcr7riywIio3R
         +INJm1eIE6ntozMNAstAxSIi+jj7KnX4JukCqHAJmUu/y+tZs/S3LxQYoTzr0deTMHA8
         Vg+Dxv0rtJ9HUqlnSTC9P+5IreUDSTsosifYLVz++2vQUgrxYdO1xyb/4+0AgleDb/4D
         1OjhYfnG8wMPVqM1d80BAKay3uHtSL07va8p3jlShX01iWsaoQtF0aKVwsdWqtQKFN4I
         TDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H/xkNUQ9AL53IRTQws0KA1y4kWYJ8e6J7sN1LrxVju0=;
        b=KD7/NPzeRpU6cxcz8XsZ6q36WEbPnEIWiKvfmSoioUzt1V0ll3m2ZFEwMRtccwtUKy
         SMU+2BfbET5QIsky6gvhIMhh+RfZXpsk01XtfgWSQ7R/eNKh2k5GtvEi84pPaomGU3P0
         hKMKohwoa77ZPmorO6c/qNYWGJjqmbvVorB9Vdc5uVw6WLRCVliCCPrZ/YaWNEizTRHb
         UPBNubcTAXcW+QKN669TG0mHDGVoQIVK5UXUmfOH2C3ljItKmKcrkBQD0i9sM3+D5IDL
         DUmdQSTgFX485v+hULK/PK2mpc48+xtdVcr4h02ogk/dLIQI34HBfasiR/RgxZ4FY1nA
         xRCA==
X-Gm-Message-State: AOAM531xrUuRxc9d+qFscXQKzV2y4OSCR7jNWjhi1L0R8zuHFN41e5S/
        x0pEcXinROhIWqlifIcv98J17YmoHB8qVg==
X-Google-Smtp-Source: ABdhPJyeGb4Kq1WQ8lRptcUg96gRv1AZnN1zvWkgcxxDcN7c92BQ3LC6N3qwo/vXI38whEbt4CiJjQ==
X-Received: by 2002:a17:902:c404:b029:d2:564a:e41d with SMTP id k4-20020a170902c404b02900d2564ae41dmr1271446plk.23.1601068928625;
        Fri, 25 Sep 2020 14:22:08 -0700 (PDT)
Received: from debian ([171.49.209.12])
        by smtp.gmail.com with ESMTPSA id u14sm3514692pfm.80.2020.09.25.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:22:08 -0700 (PDT)
Message-ID: <6b36894105c87c32f83958d5e161184e42ff7ad5.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.8 00/56] 5.8.12-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org
Date:   Sat, 26 Sep 2020 02:52:03 +0530
In-Reply-To: <20200925124727.878494124@linuxfoundation.org>
References: <20200925124727.878494124@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-25 at 14:47 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.12 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Sun, 27 Sep 2020 12:47:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in on
> greg k-

Compiled and booted 5.8.12-rc1+ . "dmesg -l err" did not report any
error or errors.

Tested-by:  Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


-- 
software engineer
rajagiri school of engineering and technology

