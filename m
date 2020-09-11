Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778882669CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgIKUzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:55:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848AEC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:55:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t16so11502456edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggDeVKUI4NGl/o8mg/fjLzMDUrlaYtxa8WyaQiJ3Zzk=;
        b=Esc1QmdLi/6Qx3KaIAIQHQvS4P7JAMBYZoivizjNtvFSxIcRM6aFcTDwUlzVgp7zVl
         xZfGAKAd4+K5GljAHRzQZaFdXoJ3mXWzLg6BUVNC5gyMgAiISesnHGUQil3rv03vqihZ
         9X7HRf6C06TSG9WAVFbYL6tbU1PNR/YXoB7wnpZk4eTiYiC3BmLzfoVtp4823QwJRVGy
         eaH9FxHjNJs1R8UvvB+s3VK/CtgVkp/qRGS08ycITkIDCNI85AidVJPONdTdvj9S4zB2
         GnTXKALTM4Y5rXO3v+mJPh8qyUdYFkccTxHUp8gnLj1M9n1mnnvRXa1LwOjccbvfMbzM
         oRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggDeVKUI4NGl/o8mg/fjLzMDUrlaYtxa8WyaQiJ3Zzk=;
        b=jo7S/a00RZYlboPhTJ9st39DiHrpRAztOOSpD73zur312FQS9ec22gBg/I6h1dIoRS
         LaQl2xqxO+S0kxKTl7lEQfLDBrq5dy5r5+ivXzQ+RVTEtRSw5UChQOJ6z/8VEooK6+eZ
         0EFBT/ePi9GbqCjxtkpUQdar1vtiPil0Et8/NyMD+C98Jrfvyk9y9IdjPbKYICATiNJT
         d5D57bZb48bZbiC1bFa7Q78LMGtUShNzDxHfW625nNl4EUK8U6J5s2jwIwtnPEs1En7l
         KFri5bJsoghhxB7Ap2QenujF+qebAeoJncDVRb85DmbiEdw7H4CxYyZ8w0kDSqnGwfGq
         d1/g==
X-Gm-Message-State: AOAM53166SaTel3vUZ7ASR6SIvmEA52TTfHsTaroclOT0hxhxJkZrjyh
        cyWX+vMdlfvFAoT070Ah4Iw=
X-Google-Smtp-Source: ABdhPJwe7IN3NAF7/5APCdifVHq2JNF9augUg+dt+qFalvnsfMz7Z0m4AuUDYm3aoMQVPr/iCU4J9w==
X-Received: by 2002:a50:84a2:: with SMTP id 31mr4534948edq.138.1599857729206;
        Fri, 11 Sep 2020 13:55:29 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:e86e:d952:c3c2:494c])
        by smtp.gmail.com with ESMTPSA id q26sm2169824ejr.97.2020.09.11.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:55:28 -0700 (PDT)
Date:   Fri, 11 Sep 2020 22:55:26 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
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
Message-ID: <20200911205526.65llro2gnh7zlsu4@ltop.local>
References: <20200910233940.2132107-1-shorne@gmail.com>
 <20200910233940.2132107-4-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910233940.2132107-4-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 08:39:40AM +0900, Stafford Horne wrote:
> A build failure was raised by kbuild with the following error.
> 
>     drivers/android/binder.c: Assembler messages:
>     drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
>     drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'
> 
> The issue is with 64-bit get_user() calls on openrisc.  I traced this to
> a problem where in the internally in the get_user macros there is a cast
> to long __gu_val this causes GCC to think the get_user call is 32-bit.
> This binder code is really long and GCC allocates register r30, which
> triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
> register, which for r30 overflows the general register names and returns
> the dummy register ?ap.
> 
> The fix here is to move the temporary variables into the asm macros.  We
> use a 32-bit __gu_tmp for 32-bit and smaller macro and a 64-bit tmp in
> the 64-bit macro.  The cast in the 64-bit macro has a trick of casting
> through __typeof__((x)-(x)) which avoids the below warning.  This was
> barrowed from riscv.
> 
>     arch/openrisc/include/asm/uaccess.h:240:8: warning: cast to pointer from integer of different size
> 
> I tested this is a small unit test to check reading between 64-bit and
> 32-bit pointers to 64-bit and 32-bit values in all combinations.  Also I
> ran make C=1 to confirm no new sparse warnings came up.  It all looks
> clean to me.

It looks correct to me too now at C & assembly level.
Feel free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
