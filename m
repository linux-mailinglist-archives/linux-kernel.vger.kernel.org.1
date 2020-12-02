Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05422CC909
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgLBVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLBVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:43:40 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF2C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 13:43:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so219409qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 13:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JB3b9Bzlr3vwZoXnJPmqqq5ZpwFVGAQML1vKA6tGxhI=;
        b=HiC2dOgjdxZtNAMarfFFlrB18x5ZfcYJtaS5VoXGWj6xTdNfzh+fnH58ENmjDqtGQf
         +vPjOhQSKCM5bMYiRsVkIb9Uu2EGYrSCXrhE8nH4h1AbWbUaawaCpuFQu9s1b2ZWBMXN
         FI2yVeeaQIlFTVShMAozOs9M3wG5bhb2XXVi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JB3b9Bzlr3vwZoXnJPmqqq5ZpwFVGAQML1vKA6tGxhI=;
        b=oz0I9sS2TE0N+r3sZ5/+HbesZxAWqrAcJd0wdD1BmSuMY/2CYJgxzvimvCZj3RA3Ll
         nSq4gYCgmizPdIta1AfvKsWfkLudwIxIogj2VLIip9ihaxdrHGa2Ww/jF+sd5BPfgfm+
         0DwdNXXzOi1B+/D2CEzX4juxnsldTbc9IMIjOUk+c0pqOpVg/Mfy7D10+ruDn+KtHYra
         NzAawLWWYsGkCmOdc3MxT8DY94pth2usGzFv9nnXrpVd4hQMOLmKzOO8VNxU50fQRu8d
         cVLuC2ZNKzURFtaa15PalqM+UAzRwa1y8UKhWKyLVFf7f+yZWjBTRIaXb5iwUxg1Zy6H
         wJlQ==
X-Gm-Message-State: AOAM5319lfa/TfqbECazhWI/IRQGB/22vubFD/o3N3zNcHmITCNv/zS5
        jKgu8nsXs+e9spSbP9XVtne+cw==
X-Google-Smtp-Source: ABdhPJzH5FrKmNTLwQqPkItjWZdeRObwOOuNe8jXfgFWRiwuYnRmKefn0UvSTyGbr+3CIQa9gUS7tg==
X-Received: by 2002:a37:a481:: with SMTP id n123mr4947935qke.114.1606945379305;
        Wed, 02 Dec 2020 13:42:59 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id n95sm164566qte.43.2020.12.02.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:42:58 -0800 (PST)
Date:   Wed, 2 Dec 2020 16:42:57 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Move kmsg_bytes default into Kconfig
Message-ID: <20201202214257.36wf5a4ui2axr3es@chatter.i7.local>
References: <20201201201234.137572-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201201234.137572-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:12:34PM -0800, Kees Cook wrote:
> ---
> This was sent off-list, so I'm resending it to lkml (with the commit log
> cleaned up sligthly) before I push it into for-next/pstore.

Also, nice:

Writing /tmp/20201201_keescook_pstore_move_kmsg_bytes_default_into_kconfig.mbx
  ✔ [PATCH] pstore: Move kmsg_bytes default into Kconfig
  ---
  ✔ Attestation-by: Kees Cook <keescook@chromium.org> (pgp: 8972F4DFDC6DC026)

Did you use the sendemail-validate hook for this?

:)
