Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD742F09A8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbhAJUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:13:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5093C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 12:12:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i9so14345601wrc.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 12:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=An+QxtFW/VPB9KSvU4gnvsIFY2A2uZAxzzqmCzbKa74=;
        b=YKHTKzMHx5p0pqY54uW0fbp+IwXR4nAZB/RpUw8atLmlStwtkWeNdaUuENMv/2+yW+
         IB5TQNKhcXBXeIaHqpMc9Hw0aJ4T8Oys+flM9S+6GPt9ERd/baom88I8UujBvZQn4g0N
         J0S0kphIwdqLPdRz2vrAjNfUPaemQhtV+kTHXV+y8H51f5GkB0NZWe19Hfbnmw03ZNAi
         DuRSq4GZV1V4UWJdtp1zapxtXjjltQnPrxNvaNZM/PR9v8eN4t6W2IqURFKhyanFUVt7
         G0hlja4SOPdSMtV+a11+YZysn0Af3RQwQwKmKrtwxefoTyCbiNrWzajC/BU3PioTYoVH
         nIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=An+QxtFW/VPB9KSvU4gnvsIFY2A2uZAxzzqmCzbKa74=;
        b=A8nb/3nUa1u7jrSNTivk5IWQD+cL5v973JS/jvG0yf02+djGuqKsFYOV9U46zqvI6x
         ocj5UJ7VSmanv8yFk0LPhAUJ57RAFcJMEWyUgmIwGsvnPP7cMDuoLYA9jj1RZQpRzNqR
         GFpJQFLMO+28mtQdEA20lVMvaPTIaFQfKuanmzLZJdqGlc269ghbe/5D1mn73+9QxfNJ
         odLi/qFE0FM+EgQ6D/BbLXfjVDrLhMTSljnCkDXXHXB62WIBciUMaRQB3jpPWvWNXrWp
         YOUH7caG6cCYHkA4WRO044y5f92ilBQoFMtiRs5CtqTwh/OQkvi+2aL5IWlRYbQbpAa+
         iOLg==
X-Gm-Message-State: AOAM533tTTq/UeYsvJUjgvhPxka0Q36g+Rfgz5uNmQ+myApXTQ1W3qNA
        Xd6fh2WxKbfmAsrBM1sh2xlT3g==
X-Google-Smtp-Source: ABdhPJz4VyEU2aS9YABa1UfHDVDsTij2GADFAt3K6QEphcuzzNHAOnB2bv4F8wPt5S7YzYZanRlBKw==
X-Received: by 2002:a5d:4e86:: with SMTP id e6mr13587511wru.33.1610309538702;
        Sun, 10 Jan 2021 12:12:18 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y130sm20467748wmc.22.2021.01.10.12.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 12:12:17 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:12:15 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [kbuild] drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c:443
 sun8i_ss_hash_run() warn: possible memory leak of 'result'
Message-ID: <X/tfnz9UfW+r6ags@Red>
References: <20210107131236.GB5105@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210107131236.GB5105@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Jan 07, 2021 at 04:12:36PM +0300, Dan Carpenter a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> commit: d9b45418a91773b7672e4c60037a28074b495c6d crypto: sun8i-ss - support hash algorithms
> config: arc-randconfig-m031-20210106 (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Hello

I will fix it

Thanks.
