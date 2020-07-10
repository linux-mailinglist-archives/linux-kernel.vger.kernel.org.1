Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86121B6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJNlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGJNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:41:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCAC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:41:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so6211378wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/ZA0Mv8NdkQdP738drSY8vNZ7QUvkBua0yy5iWDaA8=;
        b=vuz2JZoJqFAW0+FjDz7LUDip+uu6EGgOtzTmR+2TUNwxSBMoB5XOpkxEnyrbPCj8qJ
         q8pj+Yv3r4zZhyrfWdfqUbeH/VzNh9/007rxkOntOqXFdlERnU2NFzV+5s8GgkDIglkv
         xVww0jfxdL3XLqjigWsKEuh+gRSVc6WTFo5zwgGhyDvRTLvNohS/cfmBku4m4Yx6C7Ot
         Kk169VbdkV8RpOt7kEixxTcduLOTXvVVz63q9Mi65X6gIYQl2x8jzQm9xG5+3getfZMh
         xt4saUboqABXxU1aUPw2ijTAfoolymk+/WW2dAlpFmEnU0ZswXWRwnDwOyJouXp18mqk
         HLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/ZA0Mv8NdkQdP738drSY8vNZ7QUvkBua0yy5iWDaA8=;
        b=NNSWx/AgF9f22pG+wqdFF3fABbSf+ERb+ZOUr2XT3PxVZeixvIlJDtWJiLoXZyNYhP
         zUJH0v/OWE4AcUoenSv6lDLkRt8To5n/vr1U7LpAKSflDLrRTc3U0RZ1tHqq3eqDSt+5
         iqeHTJymi4go71qJ1jPkfr0sFRJTpXcP5z/AsDAU1EntSJOCnZH1IvVERgC7X2rbzndg
         2PtVuh1pZwdLg8cPuhIYnA3vis8di9Yv/xpgJrkN6B7npQLXuezQ+VZDTR6oWfWu0d6j
         cwFyMtSSqSsiG04Mxl7aEAABbeCX2BauXeqs5oukAvycBQR8joLCMOqe41NPux8XmTW+
         h4nA==
X-Gm-Message-State: AOAM532Og3TTZ9gQ+OcI93f5hN0npuwUNtO/ifceS44RDiajTYrHjc7j
        oBaalg0Pw26VyoULYZUV+Oa3NA==
X-Google-Smtp-Source: ABdhPJy7mN8DlGdbaVh/uhawD0B97hOHCbVHTpQzoL9nDsGzKMxgMryaSi16uOFHKGvedQnIuww9XA==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr5556402wma.90.1594388508960;
        Fri, 10 Jul 2020 06:41:48 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b62sm9386006wmh.38.2020.07.10.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:41:48 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:41:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
Message-ID: <20200710134146.xk6je7ttp7ksmhj3@holly.lan>
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
 <20200630082922.28672-1-cengiz@kernel.wtf>
 <CAD=FV=XbMfwAQ+M7oMksd0dv9xjkQrGhU8hVNahn7+vxTuhT6A@mail.gmail.com>
 <4b91d92eda95cf4f1e153544ff4c17e1@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b91d92eda95cf4f1e153544ff4c17e1@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:15:55PM +0300, Cengiz Can wrote:
> Hello Daniel,
> 
> On 2020-07-01 01:32, Doug Anderson wrote:
> > 
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> Wanted to ask about the status of this proposed patch.
> 
> I have checked your tree in git.kernel.org but you might be
> collecting them somewhere else perhaps.

It's applied... but then holiday happened. Should be pushed out soon.


Daniel.
