Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7C2CCA58
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgLBXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgLBXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606950601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TNiA1EC0PZeSV6z61SrYzEw361aXmtRmDOfY3tQLKM=;
        b=Si1R6nupYqE5gwAjgGj5795HlV4pF3MmePKPoIfo21XLX9L8PaDqcEh92lMbDketop/qLV
        Lds1IF+anCTst/RhLnEQgxr0SwI1sha2rwXK4kVgcgmvNVDinX6jXDrbyQQlAUcC3jjv1k
        fADEBbu8/NEx7vaQvwgctFa20ogox5c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-V7QBDxhZNiy3Fgk8OSme4A-1; Wed, 02 Dec 2020 18:09:58 -0500
X-MC-Unique: V7QBDxhZNiy3Fgk8OSme4A-1
Received: by mail-qk1-f200.google.com with SMTP id 141so320651qkh.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TNiA1EC0PZeSV6z61SrYzEw361aXmtRmDOfY3tQLKM=;
        b=d5xp1TOXL+d5lBwhgCtN0QlbGX044Rtipmjv1pFzjoWylJbAcBnI2VxOoyxPSdSOJQ
         jkfI/e8PzQaG/7CDUE6kPbH6/+9/PbHuGBz7bpReYf/Yg1ZiONkgs1k11DA843ShaEZc
         b5/AHYC5D2utLK4OwU4H5MJYkD/UM+MwA14bCn2BsmsjlyqYHNngvENW3kNCdW1EN2HE
         KRJ1Z2I7cHUf7Dla288ETD7tRyGxzGd48f3FDmLruQ+OgpilYdX0xEt6qf+XYfi/WP/W
         /3/3MxhJc/PutRm5epZmOff4TrJn/+Wps9YJUOJk7TU01gZfE1zu6K19XMpuLLfHSKUU
         FlwA==
X-Gm-Message-State: AOAM5302rtgC3j55n7gSAoOyHSCa1KDSu9fIJW5+wtmhgJbFBl6QMXri
        JYIga5gpsxskrhGJ2uSHdSLI7k8I+2rcdTU2kndvCx7+itckWjkj5zA0/xyvYbTvRXL3g7FY2k2
        O4PMTDCX9S/z+VeAlwr3uZrk0
X-Received: by 2002:a05:6214:29:: with SMTP id b9mr332651qvr.18.1606950597610;
        Wed, 02 Dec 2020 15:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwExtlsTU0fsMGHmFJNZJIn0zRNxa83R1RNYHP2U77HnxFqWx3IezzuhvYhYVJqvWn2fWH/Zg==
X-Received: by 2002:a05:6214:29:: with SMTP id b9mr332631qvr.18.1606950597431;
        Wed, 02 Dec 2020 15:09:57 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id t126sm120531qkc.76.2020.12.02.15.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:09:56 -0800 (PST)
Date:   Wed, 2 Dec 2020 18:09:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers
 portable
Message-ID: <20201202230954.GB108496@xz-x1>
References: <20201202211542.1121189-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202211542.1121189-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Axel,

Looks mostly good to me, but a few nitpickings below.

On Wed, Dec 02, 2020 at 01:15:42PM -0800, Axel Rasmussen wrote:

[...]

> +static void uffd_error(const char *message, __s64 code)
> +{
> +	fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
> +	exit(1);
> +}

IMHO a macro that can take arbitrary parameters would be nicer, but if it
satisfy our need, definitely ok too.

[...]

> @@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
>  	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
>  
>  	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
> -		fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
> +		fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
> +			(uint64_t)start);
>  		exit(1);

Is it intended to not use uffd_error() here?

>  	}
>  }

[...]

> @@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
>  	if (ret) {
>  		/* real retval in ufdio_zeropage.zeropage */
>  		if (has_zeropage) {
> -			if (uffdio_zeropage.zeropage == -EEXIST) {
> -				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
> -				exit(1);
> -			} else {
> -				fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
> -					uffdio_zeropage.zeropage);
> -				exit(1);
> -			}
> +			uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
> +						 "UFFDIO_ZEROPAGE -EEXIST" :
> +						 "UFFDIO_ZEROPAGE error",

Nit: The indents here are a bit odd..

Thanks,

-- 
Peter Xu

