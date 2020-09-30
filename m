Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432427F5EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgI3XX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbgI3XX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:23:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DEFC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:23:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so2537278pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kREN/bOevCqCefEiqcu5963AVtvCoPNDNjWTDSgQ4bk=;
        b=WEHLJvORopfW9SqVzjuIBplovl593zKzDltPW/iKhjkazT8C9tkdavbcR6JpyM1PkY
         uyLweiQZF3Vc/EeISGMjIdoz2rHu7kBTj0eX2kBjstC+iuwEwBg+doSVlBTw+nkCqnaE
         YAOl/QveetXkwgDn12/InOw/fdsLMGwWt1otE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kREN/bOevCqCefEiqcu5963AVtvCoPNDNjWTDSgQ4bk=;
        b=ZwavMVALkntvbInk4iNrQhFQKV4GynPl8TCLmCoby2AE65jjI77ReFWEnV+bWhH3Iu
         zoludWOgKcFc+zJ2oeWWvU4SqtMLKdwNgVpO948n8heAGCCe41zckkjNnWxEF51nFd0B
         zGZNOIHC0mboRh5dvG4eMnCX3G5OU+IkR5MhbMYylfeXEYc9+CxdyCiz79/t71jaFhdx
         GO4MHNnYsSU+a/jZ31XQnHlmmbD3+ICbd2efTQ2Oxa34N5EDOPucmPkhuqvo6BHTszzX
         m8W+GtlJeVqQTU7GNQJZf0s++hnw8KF6F8tUwFWxKK7CBKd93x2S3Ep5cUwYmEk59KPU
         NAuw==
X-Gm-Message-State: AOAM530iMu+FJ72UqPG8KJMIHTaAkp3rhdHOW4MagsAA8qzUXXtQvObh
        K8rzYw4cPi4YXsYHT0LgF42k8w==
X-Google-Smtp-Source: ABdhPJwNUmbl/VUroCr+GBxQXdRFOKbvYJq+bsGNQATMyYAT4Z3stJW+wxY/tA4Qll2558gPZN7CBg==
X-Received: by 2002:a63:591e:: with SMTP id n30mr3969654pgb.340.1601508237388;
        Wed, 30 Sep 2020 16:23:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fz22sm3260765pjb.46.2020.09.30.16.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:23:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:23:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 34/52] docs: pstore-blk.rst: fix kernel-doc tags
Message-ID: <202009301623.496E3F85@keescook>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <cecf37b806ceb3bd53e642fc5437111e29e1c1f3.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cecf37b806ceb3bd53e642fc5437111e29e1c1f3.1601467849.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:24:57PM +0200, Mauro Carvalho Chehab wrote:
> There is currently a problem with kernel-doc tags from blk.c:
> 
> 	.../Documentation/admin-guide/pstore-blk:239: ./fs/pstore/blk.c:175: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
> 	Declaration is 'register_pstore_device'.
> 	.../Documentation/admin-guide/pstore-blk:239: ./fs/pstore/blk.c:432: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
> 	Declaration is 'register_pstore_blk'.
> 	.../Documentation/admin-guide/pstore-blk:242: ./include/linux/pstore_blk.h:43: WARNING: Duplicate C declaration, also defined in 'admin-guide/pstore-blk'.
> 	Declaration is 'pstore_device_info'.
> 
> Basically, the internal parts is shown with :export:, instead
> of :internal:. Yet, there are some other exported docs that
> aren't at the document, because they lack :identifiers:.
> 
> So, instead, let's just use :export: at the kAPI part of
> the documentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

That should work; thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
