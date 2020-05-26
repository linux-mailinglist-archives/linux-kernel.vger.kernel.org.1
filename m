Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7D1B77BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgDXOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgDXOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:00:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2AC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:00:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o19so10205701qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9cLGx+QGfWcf8ukx0R9LHr5CQPeNn9g6nUF/5lr9wQ=;
        b=ZXVzbXS7kRKx/pV5JUuQYoD2vDMUZ19nDVoEnLyE5uHXa10feagwqkH3wBvpM1hcTo
         KnfcB1Gdxin2HnJmVpbVQ2XqX5y44vudMJPDCxV748/p1I4CLpKzC/V8AXCwQsW0YUZt
         9q9CthT09jFSr+h/rlb3NPCwXtIz42tSqpAiPDAH+hxzMH5hrzZEM/b897LLTSntLhgj
         kL0paLMbvAuNnOluOmB33SEbfziUsSvcxRfi5cyElC+CcJC3dn5/XZTcHNdD7rv+/ZTX
         ndhS2c3nN/zwByZjpTSrFS9KZAXr9O5ieGulen4uK3xmze55NcChxhKOBYsLCjJMiUuU
         88mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9cLGx+QGfWcf8ukx0R9LHr5CQPeNn9g6nUF/5lr9wQ=;
        b=sFpVIXK7E+TgyFM4Y/k5AgAu6tuXgWa4W35iYGOal5fOwJkgl+WnA8yZghWLQfaMF/
         MMBgDVXyiQ6HZuh8+W2V4E+vcdRbffXYspjE9nizqrP25WuE+Yuj+y30FD7HsRQzvhhh
         mG8IFBtcfv9fY3017p7Xq5R2bk10imedpdvS/HSbVKx3dyXHkgClwuF9d9lFnNBDo9x3
         tDFQGohcKiRs5lVmgqginDlNoM33yHLXO+l9/w8g4uH9VNXzskDVZjbXnEYX5WWTvsaO
         QNjrjdnkRugocrv6e//AkMt0BFiQbwyaTtp0uFgLbd2Jo7nbkQ1uR8ygcoFNv0wjHNKB
         TdtA==
X-Gm-Message-State: AGi0PubgRSGIbC699FvLQqwOeo91QaB73GKqh7hO7FBjFuexQAujT501
        5lXhJQj/NeCm0fTBNwbYo+MIIQ==
X-Google-Smtp-Source: APiQypKwhCaYoxjCOz78+SLWX2ndDulXg83sqxP2DW83RSiXGAua+iNcWpNnnGoN/CxZM3jiQ9/Rmw==
X-Received: by 2002:a37:50d:: with SMTP id 13mr8998308qkf.494.1587736848848;
        Fri, 24 Apr 2020 07:00:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s14sm4011594qts.70.2020.04.24.07.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 07:00:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRysp-000860-Na; Fri, 24 Apr 2020 11:00:47 -0300
Date:   Fri, 24 Apr 2020 11:00:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] IB/rdmavt: return proper error code
Message-ID: <20200424140047.GF26002@ziepe.ca>
References: <20200423120434.19304-1-sudipm.mukherjee@gmail.com>
 <20200423140947.GX26002@ziepe.ca>
 <BY5PR11MB3958DBE0C624D035D00E5AAB86D00@BY5PR11MB3958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB3958DBE0C624D035D00E5AAB86D00@BY5PR11MB3958.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:50:22PM +0000, Marciniszyn, Mike wrote:
> > Subject: Re: [PATCH] IB/rdmavt: return proper error code
> > 
> > On Thu, Apr 23, 2020 at 01:04:34PM +0100, Sudip Mukherjee wrote:
> > > The function rvt_create_mmap_info() can return either NULL or an error
> > > in ERR_PTR(). Check properly for both the error type and return the
> > > error code accordingly.
> > 
> > Please fix rvt_create_mmap_info to always return ERR_PTR, never null
> > on failure.
> > 
> > Thanks,
> > Jason
> 
> I agree on the ERR_PTR return, but the patch is incomplete.
> 
> The original patch:
> 
> Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
> 
> Broke all the call sites: cq.c, srq.c, and qp.c.

Sure looks like it, someone make a patch..

Jason
