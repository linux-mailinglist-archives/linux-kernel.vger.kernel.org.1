Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5475923507A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 06:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgHAEqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 00:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgHAEqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 00:46:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 21:46:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so8308070pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eAOX9UrxPIOomqROH0waMwB/lcef6OrlafyxMLp9bQ=;
        b=jna6ZdIEYE/Xh//wsaCdzyN+1hy0bJqKi2PGS7bu3veIPCwCg9K4In6ylF95hymXIO
         ThEVkE9WtswmUyazhG807PRSUs1Kqco4BQ+hC7ebO0L22dXgC1oDB2lyTZ67kJ3KGOgM
         VxPLRVGeVwVgVC+uwmR7pgxIMk7R+aUJ4+5Ju4U/ub2XwckOnlVotttxr/7JXpMYNT2G
         UqjunHEGAHIfzztqZBxupcY/NuMCg7eJ23SRZIHvBHiiUL3w4GJRDTGDHddaAiPk52+r
         wbIljvLxatNKipTigGkADMSxLVgd09bAhUhrrqQMiOm3xzVknU3HL/35mIFPHb+pTYg2
         n1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eAOX9UrxPIOomqROH0waMwB/lcef6OrlafyxMLp9bQ=;
        b=eXY4yKmA2GvMzFZGaQbVh9S7f5m/0TQGkeY7i18g92rXUTu5gGS17Vtfmk35qu1e7I
         nI4nYbmsQHiBZ031Tixa4oQkLGvaRWvxaEhlKKO9nZlX/EBfrZsBNCVoB1TsMF9q2Viu
         x3RJD1zMemBdd58RPPEbwe/Cmn13GDBq5RNVBFJtiuH5Hsf0XjFA5s+kN8gegReBsLKw
         cGte9C1qMtCvxJJ7Pq0Tfp5W1WfQ1jEvIdJ3SB5wTwbrV5iViSScF8OcKyfJNhvSHWRr
         tc3lw0DJdCFWNw8hTfU9ySzZPOAPXMACuU+k5ilfVgQ/e2zmttpKZWUazPzecBSr4pSB
         wZ6A==
X-Gm-Message-State: AOAM531St5n3nDqYC5jwQZIw0kKLpX+Kdq1hdu42ApAPRRxLGbpt3UTb
        S00+wmaQnt3ENwgLxueblRmCU+do
X-Google-Smtp-Source: ABdhPJwQvwJ9GZp5qXVxaEuN0ywU8uDfDvRtej3R3yCh6DOnb5lCqsowa5jIzfUI/7b5FP0aCAIhhg==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr6897946pjr.144.1596257183420;
        Fri, 31 Jul 2020 21:46:23 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e13sm11562563pgs.13.2020.07.31.21.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 21:46:22 -0700 (PDT)
Date:   Sat, 1 Aug 2020 13:46:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with
 static_assert()
Message-ID: <20200801044620.GA683@jagdpanzerIV.localdomain>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/31 21:08), Andy Shevchenko wrote:
> First of all, there is no compile time check for the SMALL
> to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
> is hidden in the code.
> 
> For better maintenance replace BUILD_BUG_ON() with static_assert()
> for ZEROPAD and move it closer to the definition. While at it,
> introduce check for SMALL.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

The series was applied to for-5.9


I ran more tests (+ cross compile tests: ppc/ppc64/arm/arm64/x86/x86_64).

	-ss
