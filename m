Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD81E5788
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE1G2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1G2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:28:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0BC08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:28:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k19so22237675edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5MkFrDgF5VspAmYHCjE3L+lmTwqFXhsdmwItUzmmYmQ=;
        b=AvzTFCIHVx3qfAhRrsnAgFy2dWlhXhf4W3nNrKWTSpdP/0vWamueZnjT+6Qs8JAro3
         5rjN8JXoaG2c4HdCxOcNy99MI2yU/5vz6+7j+ClH+CytbQYkhcPSeCHTkZI4spzSxCBJ
         juz7Wh3eEzYXfttxG4mP3rNmCJwrNae088M3lSqsJeV7jlbM/q+hsoPw6+rYpyyc/mjJ
         CcZKDi//5Xi7MHxG3GKhC+ywBJQTD1NFoA3h5VyuvCpKSriDvVQ3j6y+ncf8aZJzPq/O
         2tv1dd9+pgN8blm5WB6UwrsZ9dYHkDSJf5TJl2bph0yxJKyybUKP9grgfWjJEwX7zc9z
         0FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5MkFrDgF5VspAmYHCjE3L+lmTwqFXhsdmwItUzmmYmQ=;
        b=JSj8nAUsb6gK2fM8TqgCgSD+e+QaUKQhXAfFnmSl0NFbP2OVA4JRsWhFXQfvtKrTBs
         s/5Ft49dPcqhdS40GKanS5hFuQ3MuNdRLAEAQV5LV1SM0NN6PdDG/W1JwRdWxrcxGODg
         nUQw6OnkFHix+WGJji5GBq91FeJmS2Qw1YM40wlqD0UhhZQ+OPgJWto4ms+1HKFRW3oY
         e43t7iS/dq9M9KU5PRnPP001u7niGiiWm/e+Hhyb2M6z4GN6TCVMUFPqyBaG7LImK4LG
         5jcgzXech5DCAttlv9FuXzzN6f/LWvzoLASD97RLZNwAXEdT9XgcKPIfoAHiYz+1W4kp
         5d8Q==
X-Gm-Message-State: AOAM5300VMdcXkG0JhV1QG1gtc9NwRmfTHqrGXrqmC47v0o0sUs+Rlg4
        vl+2xVgFXgtAFiLxpImdZQszsw==
X-Google-Smtp-Source: ABdhPJyc8HLOjeL5rh9/6pD/emZOr32Ehyiz+rzW7XmdKPV7S2MgDdVX043h26V6pipPZ4iBM1fI5A==
X-Received: by 2002:a50:ace4:: with SMTP id x91mr1503734edc.361.1590647314911;
        Wed, 27 May 2020 23:28:34 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id b21sm3999199edt.15.2020.05.27.23.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:28:33 -0700 (PDT)
Date:   Thu, 28 May 2020 08:28:33 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Matias Bjorling <mb@lightnvm.io>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lightnvm: pblk: Fix reference count leak in
 pblk_sysfs_init.
Message-ID: <20200528062833.clbghpoqizjvl7g4@mpHalley.localdomain>
References: <20200527210628.9477-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200527210628.9477-1-wu000273@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2020 16:06, wu000273@umn.edu wrote:
>From: Qiushi Wu <wu000273@umn.edu>
>
>kobject_init_and_add() takes reference even when it fails.
>Thus, when kobject_init_and_add() returns an error,
>kobject_put() must be called to properly clean up the kobject.
>
>Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
>Signed-off-by: Qiushi Wu <wu000273@umn.edu>
>---
> drivers/lightnvm/pblk-sysfs.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
>index 6387302b03f2..90f1433b19a2 100644
>--- a/drivers/lightnvm/pblk-sysfs.c
>+++ b/drivers/lightnvm/pblk-sysfs.c
>@@ -711,6 +711,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
> 					"%s", "pblk");
> 	if (ret) {
> 		pblk_err(pblk, "could not register\n");
>+		kobject_put(&pblk->kobj);
> 		return ret;
> 	}
>
>-- 
>2.17.1
>

Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
