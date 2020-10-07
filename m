Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82696285F83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJGMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:53:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78983C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:53:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so2481684qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KlA515YbaSqlZ5HdNJAxX67ZQ8wURO94VZx2F3akvw4=;
        b=dA67AYL8tGOQlFUOvo+QfRF/rl708XyhW4ispHSDIjZUKoGwkNntK7W2xWj9iBaHJ/
         x0xkBYLHJjl3a5eqM7H7qoi85DQQsYG/ryEuhELpzixIFzbeD+0b74najSwroNNHv6KQ
         8KLYcVfT80YrOBoXHWS4mmVeWM5CyAJB/I+Dd1XYR+SFCOIE9eWrMZFnHZSLOt2h5z6b
         wdlJ9aIV+yR+uzmrApUfnNMI+ESMAYSyuF6cI6bMj3w2RrNx2b9djiIsffeY07kizVIx
         UZ3M90hqFaR76BzpxUy3pJtEIdNRElC69aB9VWMbcXpy/NXxCyaLaZuuZp0UdU7jdbsr
         qSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlA515YbaSqlZ5HdNJAxX67ZQ8wURO94VZx2F3akvw4=;
        b=qVfmc2nUtq1wd+Ki5f6tlCZ+EGPA0zDjFkOuhNfsJ6GOKDG29O7Hod9F2K1cW2z/aw
         Idd0zq0cpJHdio6YoWHbIdfS6Z3yPVz7onFdJWIfpqpREr0O4ekvO9Y6jHVNsWhc2vdE
         5u8OR24dgi9kX5v8uxpYC3IWNaJBVAatgWABLSEghvq4MBGdTlU+RjrjgkmxHpv7ZozT
         nv64ak6bl8Jb18xvTKbrRPxC9ptCf2leVd4Cs9deQq4QiyGao9UQjl2ECznlQdW6KPt6
         EjvQ3B+0LLhoNTYfrbdQk9IsT3rt/aNMRYuOSex2iB14ySi4EiHuFfXtHoft5cA3gV9e
         mA5A==
X-Gm-Message-State: AOAM532lOS6e9l4LdEQBtRlfKvPp4CDUJ1+y0T7FlAZEGWvvL36PQi5c
        RtF0kwmWzUEHe/DFzgO3Ozvapw==
X-Google-Smtp-Source: ABdhPJzv+HysSfOnyOeXJ3JMJvf8YUeslpFrIcXI9E6+9Z0oxuRHxXjv/IG/ZBeSCeIiFaDb8EawUg==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr2639025qkk.28.1602075211631;
        Wed, 07 Oct 2020 05:53:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z69sm1370364qkb.7.2020.10.07.05.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:53:30 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQ8wk-000tgl-9U; Wed, 07 Oct 2020 09:53:30 -0300
Date:   Wed, 7 Oct 2020 09:53:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] mm: Use sysfs_emit functions not sprintf
Message-ID: <20201007125330.GO5177@ziepe.ca>
References: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
 <202010070014.76AA763CE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010070014.76AA763CE@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:16:01AM -0700, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 09:28:17AM -0700, Joe Perches wrote:
> > Convert the various uses of sprintf/snprintf/scnprintf to
> > format sysfs output to sysfs_emit and sysfs_emit_at to make
> > clear the output is sysfs related and to avoid any possible
> > buffer overrun of the PAGE_SIZE buffer.
> > 
> > Done with cocci scripts and some typing.
> 
> Can you include the cocci script in the commit log? It might be nicer to
> split the "manual" changes from the cocci changes, as that makes review
> much easier too.
> 
> Regardless, yes, I'm a fan of switching these all around to
> sysfs_emit*(). :)

Yah, +1, I'd welcome patches for drivers/infiniband as well next cycle

Thanks,
Jason
