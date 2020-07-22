Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84D22906F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgGVGVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgGVGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:21:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CC8C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 23:21:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so710348wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAzrsApk4VDHwo72IBIJNtqOrqLOrpegciq43liSn5w=;
        b=qBWKXhuBxi4P7/ALiJhnN0/3BOb4QCSz/f3nOTO8A+Fr9K/geRWYwDfMVEIdPcLPrr
         G+qKk0mI9DXgdJ5XsxVrHslDFH9Kptsc+1985V9JQR33yZHRD+Sh4g/uE/kAyDVfsuPk
         kffk+OsBK+RYUlneEpTzwJXSUYMqIs1TYVymaY5gcljFptTSy5Y1/FFMKZtUJ0krvk1m
         1+eeQ+dUz+a0Gz74wHcA0Rv3rx9sK0npYfrqUIq/IwRhcQDt1FBnW2VsoMRe+aH2gVLd
         zPP6D4Mrt6Op/g6d1jvLt+LzkCexsrSVwrUDJUDo2zSWt9bxv2gOblwlOoKqRiCLXxrh
         uH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAzrsApk4VDHwo72IBIJNtqOrqLOrpegciq43liSn5w=;
        b=ozpYchej34GBdLOdJktjcffKInKgVrxaIHiKt5gtBp1rXjj0mE6YCb1+hzp1TlG/nz
         4Y2STnUz4gx1i6iODnNtPvNoOuYMOGLT7uWwC1WKRo+0wbZywOqXnE9wWUE0iWHWnNrh
         BGGSPH+Af3UR3Ya+QUqDn2x7w0qCaNIvWOgzn2fnkSx9rS7alhWqEEdNXrsUhlK2VNM8
         e/XOQWK/xcplB1msPr9ZtZoZW07pMtHM0QJ+iDx9QX/CAE003P/Kp3Q/UAAsLbI54GTT
         m7rUoSgKk2H3Lfs3Ja0lYfwto42EFjl5uuuAvb7SgZ4OD9WV5VX+7VJVgwD69ufZRKRQ
         MR7A==
X-Gm-Message-State: AOAM530/BQFrp2VQfznC6mqY2zx+1/WZRU9z4CXLWmrbSsABeOR3G/Cm
        iFVy1jf4cxv6tYh27Cc+D50CoA==
X-Google-Smtp-Source: ABdhPJwuEjzYobRCatFsIux9YRMMuoKkRkV6U/KMc5KHMCsjUCPkOux1K3X1tnegkZe15mFE/NVfFA==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr31237364wrw.423.1595398893567;
        Tue, 21 Jul 2020 23:21:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y11sm24709367wrs.80.2020.07.21.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 23:21:32 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:21:31 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Joe Perches <joe@perches.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/17] crypto: sun8i-ce: fix comparison of integer
 expressions of different signedness
Message-ID: <20200722062131.GA24080@Red>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
 <1595358391-34525-17-git-send-email-clabbe@baylibre.com>
 <11ac49bc33546ef9ebc4120878206bd882667d8a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ac49bc33546ef9ebc4120878206bd882667d8a.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:32:15PM -0700, Joe Perches wrote:
> On Tue, 2020-07-21 at 19:06 +0000, Corentin Labbe wrote:
> > This patch fixes the warning:
> > warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
> 
> I think these do not really need conversion.
> Are these useful compiler warnings ?
> 

Since ARRAY_SIZE(ce_algs) will never greater than MAX(int), the conversion does not fix a bug.
But at least the code is more proper.
So I think the patch is still usefull.

