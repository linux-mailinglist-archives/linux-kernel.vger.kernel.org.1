Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920126AFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgIOVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgIOVvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:51:15 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DDC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:50:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w12so6010185qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zss3uHpc3ttf17gwYIy/82ETb9atEX8U54o98v0HqrI=;
        b=JMx5zfQ9BbjulbIHdSy28ZcOznZ5f/Xq/6bQkDVISIJi/F6I+QwAqWdwZgSziPAwI4
         q6qj+407GzYNZpUbx1+GlMj+qTcnd/tJqcvfpDyAi7wX+5/LrauFbagH2upSl0nw+EJM
         MZCBN2RA3v9kKzKA9BwuNSqT7l4rpEz/IL/7AHpbJPuUsngNsVOHYyY+1EmxEKvQn1sC
         +f63PjgfPZUyD3/DR0ksbL68deXDnhkoEFQLbDcVbbo2dRUtJ270M0W3SyTSu6UJHYvb
         B0ettbnl/CEZ7NvWzNTMQHloMSnB1GVPSXnGld9tuAZBKJMpVxRETkfqgptrg5qf1OAM
         zgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zss3uHpc3ttf17gwYIy/82ETb9atEX8U54o98v0HqrI=;
        b=TZR4cfN2hPOWiTyuwupXRT2zNJWeYi8kADKz261oD993d6er9flo/xLw+G32iihkez
         NmKVmo6ZUaBmDLKLPlxzG6jn434IbUq9VNGNHllI/QWHt833D9IxP0Q/WXRSaMQgNyhV
         VeASS39/gJDAz4GGejHyrPUPtxUZIaTtMcxvPCNUFpkOC8H0TX7cGY30eqHCMz7Mfok4
         alS4tzUgO7tR8hzsDv6p3lt9jZz34A1Eoney+oAKfvs5nOTiubDfLM13tlGiWdWddUZn
         YIAgv6KT0VqG1BNFMqHtQNExmp97GXZcZ5z+gt7KL5uwF6TiI6DOeVwe5jUrPfevpi42
         9fgg==
X-Gm-Message-State: AOAM532Vvz12azJVRGi5av1mOkBV21WPNBvVOg38YlZn0LxONdCtoIKl
        z7AnuPU9OLLYfmyLt9oqD/s=
X-Google-Smtp-Source: ABdhPJzYrBdnyxvf9ORk3FEMnVid6O7hmMVUBWDu3Mb28AsA7U+nutHMqdw2PHZU7WHYLQWk0sK4Ug==
X-Received: by 2002:a05:620a:a45:: with SMTP id j5mr20266791qka.367.1600206656635;
        Tue, 15 Sep 2020 14:50:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m24sm9337458qtn.59.2020.09.15.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:50:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 15 Sep 2020 17:50:54 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915215054.GA1104608@rani.riverdale.lan>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915204912.GA14436@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> 
> (Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should not be
>  returning, ever. :-))
> 

I think this is because panic() is varargs, and clang doesn't support
gcc's -mskip-rax-setup. The normal ABI requires the caller to set RAX to
the number of arguments in vector registers.

https://patchwork.ozlabs.org/project/gcc/patch/20141218131150.GA32638@intel.com/
