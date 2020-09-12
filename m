Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785FC2678E9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgILIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:40:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:40:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so2032888plk.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtZpYqJi2Eh1iCduCHOJ+h77NknG0j+OKsQgYvK291Q=;
        b=aw7itSEeTJJzT2wS1waWn3QoWAFE2Rnm8cV2CO7tT69YDo7gEiKozK1mGeNQob02Ii
         c/lpmqphdvUbCf6NJO96JhB87t1IdfH17rWXMQbMN9nuNsyBtkvi2vD4peBSDiJfKnNn
         LhiHbyxb+UGBPCoCWciHsyiWAnhYi7pqC2YF0JUgaq+6TsH9iPOah3d/sk4dLvlkhuyO
         U+s8IyGWITEWrBw3DqZsEDzawfC3D6W9Cm8SolrMGzfSElybJO+ZSb8vKMtkGPXw4NcQ
         BRKvsvXKGx9LG5iOfH9sHiIBEqBk+dyKw6MaYDh8A1vr/+LnfiLGZsGagf/fahfxFd2i
         ugzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtZpYqJi2Eh1iCduCHOJ+h77NknG0j+OKsQgYvK291Q=;
        b=Xq3sHV8Zg3r1WDywvFh9h2kDWqUDgbgIB4J5vDIz2tAfWl1ZICbV3pOBYyRW1FY/wg
         aMyCni3atbhxCEOWCUCHIkpULU9IH6iaL69k+P99pFIsWA3lX15h+lumTTBKtG2AcPUW
         o2SelQCDM0+EIOPnHyQc/4sXBKtQsa4KzPG3/yvV2sSMUs35ZZXBCITtksbfyo2sNQRS
         IAriq8Ecrp5dg5QR1F8UK8+cJyNA04awbymejs7vDRJWKLRaLOa4PIiyevGXmMQctGaS
         i+BGFvVmBwmY4BrKfN0aOSecVI0i54eZVfT01eCV8vR7l+1KojSByTBRyN6zSGHaXckk
         LXVA==
X-Gm-Message-State: AOAM53395xoo5E2EpUK+DZ8z0zO+apbzzQRAI67i1MEp2k44C5WT8c91
        YYrBqaNu92E8YeSPQrxD7+E=
X-Google-Smtp-Source: ABdhPJzZcn+s/PFPMGentFcESDpGVRZhUChlRUiTJzIXjPkcJ269s9m/RC3BlMACaK3CVlK8JhLktQ==
X-Received: by 2002:a17:90b:4acf:: with SMTP id mh15mr5478887pjb.204.1599900044119;
        Sat, 12 Sep 2020 01:40:44 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id i126sm646895pfc.48.2020.09.12.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:40:43 -0700 (PDT)
Date:   Sat, 12 Sep 2020 17:40:41 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] openrisc: Fix issue with get_user for 64-bit
 values
Message-ID: <20200912084041.GQ3562056@lianli.shorne-pla.net>
References: <20200910233940.2132107-1-shorne@gmail.com>
 <20200910233940.2132107-4-shorne@gmail.com>
 <20200911205526.65llro2gnh7zlsu4@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911205526.65llro2gnh7zlsu4@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:55:26PM +0200, Luc Van Oostenryck wrote:
> On Fri, Sep 11, 2020 at 08:39:40AM +0900, Stafford Horne wrote:
> > A build failure was raised by kbuild with the following error.
> > 
> >     drivers/android/binder.c: Assembler messages:
> >     drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
> >     drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'
> > 
> > The issue is with 64-bit get_user() calls on openrisc.  I traced this to
> > a problem where in the internally in the get_user macros there is a cast
> > to long __gu_val this causes GCC to think the get_user call is 32-bit.
> > This binder code is really long and GCC allocates register r30, which
> > triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
> > register, which for r30 overflows the general register names and returns
> > the dummy register ?ap.
> > 
> > The fix here is to move the temporary variables into the asm macros.  We
> > use a 32-bit __gu_tmp for 32-bit and smaller macro and a 64-bit tmp in
> > the 64-bit macro.  The cast in the 64-bit macro has a trick of casting
> > through __typeof__((x)-(x)) which avoids the below warning.  This was
> > barrowed from riscv.
> > 
> >     arch/openrisc/include/asm/uaccess.h:240:8: warning: cast to pointer from integer of different size
> > 
> > I tested this is a small unit test to check reading between 64-bit and
> > 32-bit pointers to 64-bit and 32-bit values in all combinations.  Also I
> > ran make C=1 to confirm no new sparse warnings came up.  It all looks
> > clean to me.
> 
> It looks correct to me too now at C & assembly level.
> Feel free to add my:
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks a lot.

-Stafford
