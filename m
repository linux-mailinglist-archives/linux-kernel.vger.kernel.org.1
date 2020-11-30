Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C492C8EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgK3UMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgK3UMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:12:05 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466ABC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:11:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so12093552qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kO3c8jFNnrYhfTQFD83uebtL85zMmeqUHdIq74926tg=;
        b=OD8itAkkawtanACkX7JR3tnKgtLsPw2EElv+hh9ks7Nl2nBXQPuvN1RTNAYWEf/IUb
         rkib84IKKNdxTgWU4dJiU2OegjB23HQyL3627Ib2GV2eHfnRqWePZ7EXikxJWi/VYQNT
         lG3rZMbWaZJs78dGkhTy832j5fPWqzaJM0qqT99VZT6Ld8cp6p5VAdTZ/AfgTu1p/rQq
         BzG72jRIvu/I8INEwHHjUOrBetpbVMCeLRKf30x5bgIfyiTzT2z3mR/llagRuKX+sJn1
         eiuQKWtSF0wbVXEev3KEkxrYg0RaJ17kKAP9bJICKm7m60oEbWL3g93gfVaPKb6m+KIc
         EJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kO3c8jFNnrYhfTQFD83uebtL85zMmeqUHdIq74926tg=;
        b=Xfftm3lz5H7ZfJIhm3yKda0jto//4mcJaZEnpQH8G0rtuuoICHft37hsjBBIC85bj9
         Z280KsXRnIor+/ijagOJTtTk4HD3e9NHg01ZX/RDIye4M48CNO8LNtt9QlbrOKmU6f6/
         qyS/R1vlkl8jsJ8bxZxoWE9TUknKtPgL+z1RHzWIG2tlbEXmPiboVLQRgnKNDXWWZAWI
         gUKUgt8XaHkb4Fh8ElIW1r2QfTcLfuzgC4PLWLFoIJeLCjJUN4Q/qlgueZ/ZBo6XDED7
         JuP62vgzftoTbIzHpnk7AHiwTh5gaoQCCKRXBeJvfHbdXewhOPb7pp8XOu4wpIqBdv0u
         JONA==
X-Gm-Message-State: AOAM531mVMFHT3hfBvMgnQ34zD3OFUFIXugpUtH38I+wpeXKqVmAeiKZ
        xKGQaGoAsuQ+1mtRTMZ47yIMMQ==
X-Google-Smtp-Source: ABdhPJyvDjiXAk712YRtI7P2vu5RDjLQk0Mje3emoELHeH3xj4jp2rg4jtolQFilf+zU92UMT6w6tg==
X-Received: by 2002:a05:620a:2202:: with SMTP id m2mr24385531qkh.251.1606767084496;
        Mon, 30 Nov 2020 12:11:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a2bc])
        by smtp.gmail.com with ESMTPSA id w54sm17820460qtb.0.2020.11.30.12.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:11:23 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:09:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: move lruvec stats update functions to vmstat.h
Message-ID: <20201130200922.GA23216@cmpxchg.org>
References: <20201126005603.1293012-1-shakeelb@google.com>
 <20201126005603.1293012-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126005603.1293012-2-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:56:02PM -0800, Shakeel Butt wrote:
> This patch does not change any functionality and only move the functions
> which update the lruvec stats to vmstat.h from memcontrol.h. The main
> reason for this patch is to be able to use these functions in the page
> table contructor function which is defined in mm.h and we can not
> include the memcontrol.h in that file.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

This is a better place for this interface in general. The lruvec
abstraction, while invented for memcg, isn't specific to memcg at all.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
