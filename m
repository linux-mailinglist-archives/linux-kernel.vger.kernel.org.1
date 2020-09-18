Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D627018C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:04:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5902C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:04:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so6181352wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGPBvZR8CUnfQotLYT8j3DfYPkANaBdd6qXnZ8P4HKQ=;
        b=aGzrEAuL7V1FKlYHZis3rDDcifLSBFnlH9K5I0UKHwwHU0HSoh23qqkJJUDrMi86dS
         NPxOlW7DrGefJp+b19tUoHjLi98HGUm692Xt9jmI6ib0UU52x9SkroI4jf6nIqYC/TaN
         bpzPGB9++883/11GaBF3/Nrxd6YVqBlUsiZ6efvyK1As3Wslg0fi6JVlWYVyuE/iUvVH
         t6C4x1Ql2chE5Xhkyt0byFEbbqcIpQENExxaP+WBKkT3YIQ/ufHRAgeLxmSR7n3GY8SB
         DVbQEDBi0CHjghPw8TJvvhFGk/r+Hw+UvldgEqeYpRIYIGCE/vm/9qi7WfSGh1e+eO5U
         eGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGPBvZR8CUnfQotLYT8j3DfYPkANaBdd6qXnZ8P4HKQ=;
        b=AsB06rlBhraHBDxIbWaNpQdf4+US2J/q0WNBHL89J9h8TvOOi9Tz5jGCAud9u6v/DY
         AKtMKNNmQubvFGFR+owZN4TlrSDB0mtac/GJs777b3AKibipLVeNTLJ8z/32C58TCB+f
         dvw/iTOcRrusEGobS4e2o+iS9TTjqhhqNpBg2dvGS2/iStzUA4+XkFFA6l5hAb36jYAH
         6R1IbdjR3MePanq7LF0BpdEN7zUmRFQxfqWn+CyaYsX76oh7c9ru792wq2OrrYCPyoAd
         68VXxzQlh9SySkwI+a73fY1Gnd+hdod/mcv7Rv8eUVDOx17UtCfVSAEZpzhuVwegpZoe
         rgZg==
X-Gm-Message-State: AOAM530pM87bejs9EXXn2pgQsyIXP4oGE3y1TVpVWY9ZV5hDaUMnoyhx
        xz+cO525r3Sonrx0yrG81g+0aQ==
X-Google-Smtp-Source: ABdhPJyQUVhlzQB3ghRgJgATrVBOGBsM5WSkAvPv3FYn9QKx+lWk1LpOWS0Ikg7MnSNLmvsRXfz9zA==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr41615441wrr.105.1600445041377;
        Fri, 18 Sep 2020 09:04:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id e13sm6633434wre.60.2020.09.18.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:04:00 -0700 (PDT)
Date:   Fri, 18 Sep 2020 17:03:58 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Antonio SJ Musumeci <trapexit@spawn.link>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] [PATCH V8 0/3] fuse: Add support for passthrough
 read/write
Message-ID: <20200918160358.GA3385065@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <21e1b3be-6cc1-c73a-4e3e-963e2dd64f1f@spawn.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e1b3be-6cc1-c73a-4e3e-963e2dd64f1f@spawn.link>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonio,

It's indeed a great idea to notify the FUSE daemon in case of lower file
system exceptions, otherwise transparent when passthrough is enabled.
I was already planning to work on this feature as a future extension, glad
to see that this is of interest to the community.

Thanks for your feedback,
Alessio

On Fri, Sep 11, 2020 at 02:46:04PM -0400, Antonio SJ Musumeci wrote:
> On 9/11/2020 12:34 PM, Alessio Balsini via fuse-devel wrote:
> > Add support for file system passthrough read/write of files when enabled in
> > userspace through the option FUSE_PASSTHROUGH.
> Might be more effort than it is worth but any thoughts on userland error
> handling for passthrough? My use case, optionally, responds to read or write
> errors in particular ways. It's not an unreasonable tradeoff to disable
> passthrough if the user wants those features but was wondering if there was
> any consideration of extending the protocol to pass read/write errors back
> to the fuse server.
