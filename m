Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93497281B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgJBSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:53:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12173C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:53:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q18so1375134pgk.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=iPAQMAMc1hYTdFsccictID911P3trsdKp6hSOQvOeKM=;
        b=TbmjMQuBlCveAwmWwmy0rJQ/hA6alnl0KmM8J0ZZ58RmP01IE5DTu2H3o8e5bX6+6i
         0YwyoLs9btHGeslavZk5eR6mazSh0Vp56XipFnfOSms2ZLhxONKw1FBfgQUmT7N0OHeO
         0Qmsf5V6Dfx/L64zKA4I+egZpuHu0tIpULzjvF6KJIgs3+UEe7vhvxb50hmLE30oCTJJ
         z0sqXQx19yAtu78ZbE66rGH8j2v7WPhXkHGfJcFSJCCNuY8eATn0k0r71+mxZn0DJiiu
         GANK0TBCTARGx7mLBm3ERcQkqwVWH6HUggvBkiEa0pztkARv5aN3GdSHv+3Iaf1YwO1Y
         sXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iPAQMAMc1hYTdFsccictID911P3trsdKp6hSOQvOeKM=;
        b=MQ0qXa2SXv3IcU0PK7FSl8FJyK8sm8jutocUgs+nixGuoIcQwShBf7/jlwXwkHvywf
         4v0sTLs176ViJgEFd8NDIDNSzf0CyNxB3z9+JGcpz5zzZDVhZE2xpXOuVSEdGagkexEa
         i2pKMx/2eqr5sPLwj99nKYATxSSNHA22eajY7G2HTRBvVY7u9Wsc8lORiuhvOxY8gCon
         ZTNy5TD5mRcuy12KgrKRiKUbX0QTPEByAPVozZnPivQO98cvRjKGMJn9ipIicSFmGc4S
         8moeNLY4aKzR3Xe3Sv6wIw8D3iaHuLo6Z7c0gRZXwxJkGM9tB4LsJltXAsvuRRCwtQjg
         uFfw==
X-Gm-Message-State: AOAM532ShH1Y7ekevFMSnFl7L5Px00p1qwowe2P/kmLvdQ5iu8z3Mrna
        p8c5BMFLyl1UVEvkhXxTxUjdsg==
X-Google-Smtp-Source: ABdhPJzg9saFTkFjFL/6YScANuADv4CnZG6bZfHBk7SDK2lhxGXr30RQbFBKLPsfKq04zJHatQgCWQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr3374536pgh.273.1601664808545;
        Fri, 02 Oct 2020 11:53:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b3sm2798336pfd.66.2020.10.02.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:53:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>
Subject: Re: [PATCH] pci: meson: build as module by default
In-Reply-To: <20200928163440.GA16986@e121166-lin.cambridge.arm.com>
References: <20200918181251.32423-1-khilman@baylibre.com> <20200928163440.GA16986@e121166-lin.cambridge.arm.com>
Date:   Fri, 02 Oct 2020 11:53:27 -0700
Message-ID: <7h362wmpco.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Fri, Sep 18, 2020 at 11:12:51AM -0700, Kevin Hilman wrote:
>> Enable pci-meson to build as a module whenever ARCH_MESON is enabled.
>> 
>> Cc: Yue Wang <yue.wang@amlogic.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Tested on Khadas VIM3 and Khadas VIM3 using NVMe SSD devices.
>> 
>>  drivers/pci/controller/dwc/Kconfig     | 3 ++-
>>  drivers/pci/controller/dwc/pci-meson.c | 8 +++++++-
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> Applied to pci/meson, thanks.

Rob pointed out that the MODULE_LICENCE wasn't the same as the SPDX
header.  Could you squash the update below before submitting?

Thanks,

Kevin


diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 7a1fb55ee44a..35b167e907aa 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -604,4 +604,4 @@ module_platform_driver(meson_pcie_driver);
 
 MODULE_AUTHOR("Yue Wang <yue.wang@amlogic.com>");
 MODULE_DESCRIPTION("Amlogic PCIe Controller driver");
-MODULE_LICENSE("Dual BSD/GPL");
+MODULE_LICENSE("GPL v2");
