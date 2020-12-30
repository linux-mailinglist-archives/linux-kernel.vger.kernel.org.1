Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4232E7AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgL3QGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3QGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:06:52 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C248C061799;
        Wed, 30 Dec 2020 08:06:12 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j21so3773043oou.11;
        Wed, 30 Dec 2020 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6SzscdfDYZ3AWwOMa8dxs5/f1OXDyD1UfZM98ruH7nI=;
        b=MOGEJ/eoMEkvsaKbFFRs7lpe4PAvsurB+6P/m83nMFfeM1f6uuuaU5CtP4CGJqR3Xj
         AiVre2G+pOEe9ZUxAp2md2LhD+rKvmrBFEsm6QbPMN0v7vLjlzuucUV3ziuwQpTxJsZG
         85WCZmZejYCD2qZ3TNVII/FWqgsakti+nL8N/QHIXTD5imoxkDdxwCu27u9KHOi/7w01
         uGkEVbFSZRdczVGHVILHIhKLjULq+LDPmCxZ0yHuAiHz0iUnmub0DHrA1kG9JyD03dnZ
         1bmUEPZwXr3WHuL9q734Cboa/pQr7VMqcJFrmSpxPVmDVPJpC+AGU6D4dIg8i49dO/d/
         TKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6SzscdfDYZ3AWwOMa8dxs5/f1OXDyD1UfZM98ruH7nI=;
        b=SsqjlhePVOX0wBlJqR1wCLHmwS/ggoM//qSxuF900KSGKYIRpl2nGnyGW1B/mHS+TY
         vRNllxGNaGI5gszEyY9eeNc3SyFE7pm1w1UooeDgjnheZmX7TuXBJfbCs/R5L+8tRQVo
         kQ50PV4zJ5VQWGeXDPX8hAAA/G4RTHuAbEj7erRrndjBLIOMC1c3tAlrFuZAZnLMCXhJ
         F7T4/cmo7Z66rhD0hsqZEVaZspEXrfX5zxsDmATYIjBFnK/sHtF9UMQEj0wDb2l3m5XT
         LXSJIe8CzQxJ43TdSv+o9Sv/1aEYCg5lHYWQjcU1T2cp1fQUfhgjO1gyoU6Ky1ISzkPY
         62aw==
X-Gm-Message-State: AOAM530TWimpgPYwHNlFAPH+EZZQq11uzTmRETe30+RxzK89nhfK9ifL
        hEARa2CtzRIxzIw3YPWd7lg=
X-Google-Smtp-Source: ABdhPJy1oniZW/w1U4QOcA/XYb8W7GTMg9HHc+CiZWGOy9Kq1kbT/yVBX4y6vCbMksF1qSnA84fv6A==
X-Received: by 2002:a05:6820:503:: with SMTP id m3mr37334650ooj.83.1609344371859;
        Wed, 30 Dec 2020 08:06:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a14sm7076406oie.12.2020.12.30.08.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 08:06:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Dec 2020 08:06:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kun Yi <kunyi@google.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: fix sbtsi_temp Documenation kernel-doc warning
Message-ID: <20201230160609.GA100770@roeck-us.net>
References: <20201229035428.31270-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229035428.31270-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 07:54:28PM -0800, Randy Dunlap wrote:
> Fix Documentation/hwmon/ kernel-doc warning in 5.11-rc1:
> 
> lnx-511-rc1/Documentation/hwmon/sbtsi_temp.rst:4: WARNING: Title underline too short.
> 
> Kernel driver sbtsi_temp
> ==================
> 
> Fixes: 6ec3fcf556fe ("hwmon: (sbtsi) Add documentation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kun Yi <kunyi@google.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sbtsi_temp.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-511-rc1.orig/Documentation/hwmon/sbtsi_temp.rst
> +++ lnx-511-rc1/Documentation/hwmon/sbtsi_temp.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
>  
>  Kernel driver sbtsi_temp
> -==================
> +========================
>  
>  Supported hardware:
>  
