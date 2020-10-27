Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6629C897
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829604AbgJ0TTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:19:30 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44427 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829606AbgJ0TT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:19:27 -0400
Received: by mail-ej1-f65.google.com with SMTP id j24so237638ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GLsg8xAJa7lsmvnhL7MEixQfOiGx2wcrOwoQLIxETJc=;
        b=S4+fDDK4NEkgje8BueT2YGDVHQ5gX6cnqxznp+DrgQkzVJUi3TDtaWAaCtfv1mBYqm
         pKfQHR7eAeA091T4jzkzNooFCFPnbpRjHl6GB1Xf+LRU8mEfg9kPCyDXrlYpBkuPv0+x
         pnutOBeLPcPuuK5HqJTLEwgFRBQ3C4XSyKUZw5bBIkx8Me+P3kk8JjWYpbpft26r7Eqo
         bI9Owvu9RpCKFjPhdw1SyBr2BdW+Gdadxj4UWg2qMCmvNsRNek0DMIMrXub7modhgE7w
         CZhnCag7FmCec6zutL75+AlKYRr2U9i1sWLiR4y65f9+MzvEZLk5I3WqUlQZSrl0D32u
         thvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=GLsg8xAJa7lsmvnhL7MEixQfOiGx2wcrOwoQLIxETJc=;
        b=SAKpnzBFzGrGwG/QDWqeNvt6cHOb/0ZbsjcoiaIi1UkgM0rWBqXiPgMNh77xpeRYl5
         XQTS17cuzuHuBHOn8HLxKfOn4rz358x2nQAr0t0hd3ltdONZnIkZ6NmAwNNLE29fFB04
         CeVIslNVJYo/fzeIe5prKTm/EtyiYXy/Cx4d+e/wxLd4qI7EPCj7S8Sfp4C8k56EWX7H
         0smDgL16MfTPhibce0wpoE908fH1gemFF0nMfhAV9uNUlldIoEnsPW6eAoV7/HMxkhru
         +bXVHn81iJWEkJqYA3VAwBxwpVDJ1ySoMpjAiZhC2zxinrd/M0LuDjHjH28UCgBrWe2b
         hXUA==
X-Gm-Message-State: AOAM5331p4UXPO06LuvI69w91OEl4c/jFgmSu8Pkn244Y1En517cWWe9
        Cb9BAgHb+7JW58vENuuChHFRZYTX6lZpoh95
X-Google-Smtp-Source: ABdhPJwN1xb6Ild379uvD/kdR6RLKxyQqqjhnD996Wks+nXvDm3xlh7tYCJE/YTwkxodvyu57d0ARg==
X-Received: by 2002:a17:906:814:: with SMTP id e20mr4154068ejd.367.1603826363565;
        Tue, 27 Oct 2020 12:19:23 -0700 (PDT)
Received: from centos.familie-tometzki.de (p54945642.dip0.t-ipconnect.de. [84.148.86.66])
        by smtp.gmail.com with ESMTPSA id q2sm1573956ejd.20.2020.10.27.12.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:19:23 -0700 (PDT)
From:   damian <damian.tometzki@familie-tometzki.de>
X-Google-Original-From: damian <dti+kernel@familie-tometzki.de>
Date:   Tue, 27 Oct 2020 20:19:20 +0100
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
Message-ID: <20201027191920.GA262123@centos.familie-tometzki.de>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 26. Okt 18:03, Jens Axboe wrote:
> The removal of compat_process_vm_{readv,writev} didn't change
> process_vm_rw(), which always assumes it's not doing a compat syscall.
> Instead of passing in 'false' unconditionally for 'compat', make it
> conditional on in_compat_syscall().
> 
> Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
> Reported-by: Kyle Huey <me@kylehuey.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index fd12da80b6f2..05676722d9cd 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
>  		return rc;
>  	if (!iov_iter_count(&iter))
>  		goto free_iov_l;
> -	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
> +	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
> +				in_compat_syscall());
>  	if (IS_ERR(iov_r)) {
>  		rc = PTR_ERR(iov_r);
>  		goto free_iov_l;
> 
> -- 
> Jens Axboe
> 
Hello Jens,

i got the following error when i try to build. 

m/process_vm_access.c: In Funktion »process_vm_rw«:
mm/process_vm_access.c:277:5: Fehler: Implizite Deklaration der Funktion »in_compat_syscall«; meinten Sie »in_ia32_syscall«? [-Werror=implicit-function-declaration]
  277 |     in_compat_syscall());
      |     ^~~~~~~~~~~~~~~~~
      |     in_ia32_syscall

-- 
VG
Damian Tometzki
