Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDF28787F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgJHPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbgJHPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:54:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95101C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:54:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y20so2524764iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K87Z76MUaMwGT4jUWUnqmzUL4QRao9GTWVhIdgVOY/E=;
        b=e4G8JbIBYYn4byga8lFuWrt9CFFn9lYWoAD1LGBR+e/tZ9poYwiZqM7gs3ybG/gIBq
         zz7dL371KLKSGU4f/NBlLH3fIBgSyxzXtghqEaeYZfJRMNpkI0lMQUcDgm83at78bStx
         Zc5xkxTsJtNTTgSVb6C5zeNi4HJEQKN4gDzA77kH6lJvcIcwRV2pmVwq5/PgqmSrASUG
         xbrn92HnLUWQ6gUEymthXOXuR+hO60OOsqKfgFo7bBNGjVva2ymBMjttK1FZrqr6B/G7
         ZlF+88bveRMRKdWikJfadYEq0z02G/ow6P9+CaJF4ELyIevNQlcDIqcngP7Yq/AUPwvN
         W9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K87Z76MUaMwGT4jUWUnqmzUL4QRao9GTWVhIdgVOY/E=;
        b=XarWjSX8F+IqBDKO2jl76ij4037qtfl4MQIBUmSWVDmQnfGZXhP1U2hz3bU+gf8omI
         9aENvqYyQg6NajYVVP51r5JxBMDUkL6bnh6mOXNAT5TnxpolRkp40ZxXnJUaXxnca+lF
         /lQdK0FZowBRQ9WoEp/nimL0kiEBpRxucQ8kyKtYNpgw43m7LWb3fOQBePYF/t+9cK8z
         8NkabE1fYJtV4xQ3ernZYjUOvsymcBbH/VL1ykrJ64nmjkuWLGB+lFeOQ1lIUOWM9O1+
         uac7j3RVx93HYw4WaRXMnyPqL93i7xtHkTsfLqmwMLD8bQOes8IYCk4glcFHWuHmg08T
         yvsQ==
X-Gm-Message-State: AOAM533FlEiLXZNVOT6eNTdg0jksIMDXYbze/ta1qmNo7nKGuQOWU1n5
        OFIKjJEPqSkSEahXA4KvdQgTYQ==
X-Google-Smtp-Source: ABdhPJxhx7JoupFXMCiMHmWdoKyUTtxiD0NERl7t1I0IK9IlW8bYTtunZy46ck3A+NMEuATEqSoQrw==
X-Received: by 2002:a02:6a4f:: with SMTP id m15mr7245672jaf.2.1602172467984;
        Thu, 08 Oct 2020 08:54:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g17sm2801603ilq.15.2020.10.08.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:54:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQYFO-001WnB-6r; Thu, 08 Oct 2020 12:54:26 -0300
Date:   Thu, 8 Oct 2020 12:54:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: remaining flexible-array conversions
Message-ID: <20201008155426.GE5177@ziepe.ca>
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
 <20200424034704.GA12320@ubuntu-s3-xlarge-x86>
 <20200424121553.GE26002@ziepe.ca>
 <36r41qn8-87o3-2pr1-856p-040167pq097@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36r41qn8-87o3-2pr1-856p-040167pq097@vanv.qr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:24:03PM +0200, Jan Engelhardt wrote:

> In the case of the RDMA headers, even if we assume best conditions --
> a block of malloc(sizeof(struct ib_uverbs_create_cq_resp) +
> sizeof(u64)*N) and not some struct -- it smells a lot like undefined
> behavior, because ib_uverbs_create_cq_resp::driver_data accesses data
> as u64

driver_data[] is never accessed, it is only used as a pointer. Aliasing
should be OK because all accesses to those bytes consistently use u32.

Fixing the compiler warning requires significant edits of kernel and
user code, not entirely sure it is worthwhile.

If someone wants to do it let me know and I'll give some guidance.

Jason
