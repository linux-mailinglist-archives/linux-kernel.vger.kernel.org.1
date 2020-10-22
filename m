Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C83295A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509354AbgJVIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508190AbgJVIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:37:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8319C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:37:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h4so616677pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5RWcwuVAEJ6m7aRhJ9AG30CGxLsrprrPwDup3rzWGEA=;
        b=R5+7/eYo6t4BYEgtqFWHviOWXF88X66wSpFfKf930qhzVPUQ8Uqp06pa2Fncrdjvmh
         OE51QHUeLuQ/5cOZ51pDZSqil6TFWeJ1Eb7eFB0IK0/EjPzOEJ/HsSMPdzW0pViTJ+8D
         MbLF6CHQ7Y9FEJU3KI8pH0JnBjU7iBQNRq2GETi7TWIqey73j/oG/sbAmQo6I9cKpGpj
         DcsOt8NmpEbm+K/3ZvZJjABoUE3lIGFrvTn2ogiTSNm11Aw4w3BCrxiyme8Hzb5zEsGX
         E/1zgm/RYrDCXx8tEXDhn2/rtXVsUOKLKG7+houhAnMaKHHb7pnGMF15CjG9sYwjJAG9
         eKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5RWcwuVAEJ6m7aRhJ9AG30CGxLsrprrPwDup3rzWGEA=;
        b=OgV0NaEdkV9bKWVXK4zITJmcM/QbX7qIZTATsjg+ePWJr3NAlEY2fKNTPXiw10+V3I
         bQ7MKFlgC6E0uq6cfhKcF6WvFjJyfJ0ObJ72AYGTuvrnlmxTYmHxlRGx1ntIkk4oankX
         ApRqkYomai6vZbrYyCoobcyS1RO8h7kFdk54kpfBaOgD1/RJ9BzTFaCxbyMGMfZ6dVM7
         jzPQ7TQ4cBtQNIsLW34zyCNhMO18gZjqcxLIS+z+KO0lXp751ohsaIjRcpTbsD9MalI5
         wQfuSI9fXxczMnkgDLC4OeSRprbtp7jOqcgTKoFUrKmA8mjPQmPB6o0ZQ9sPVIKTKfze
         NIww==
X-Gm-Message-State: AOAM530n6ugsZW8K4+yH7XzCiYFBkNzxXf/rgvxDuMvvT9J9wGPa3QRX
        6+6N/pDlbJqKhke606KtPQc=
X-Google-Smtp-Source: ABdhPJwjqqcfqI8wb0f1tjMk3NV/mR4epXUFMXRNn5E+8rBWtuE9PO/O6wwTyWyOyYU7DA4Kzou4Ng==
X-Received: by 2002:a17:902:7fcd:b029:d3:f037:d9dc with SMTP id t13-20020a1709027fcdb02900d3f037d9dcmr1407010plb.79.1603355830008;
        Thu, 22 Oct 2020 01:37:10 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id q10sm1193525pjd.6.2020.10.22.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:37:09 -0700 (PDT)
Date:   Thu, 22 Oct 2020 01:36:44 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v4 0/3] time namespace aware system boot time
Message-ID: <20201022083644.GA344600@gmail.com>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:52:54PM +0200, Michael Weiß wrote:
> Time namespaces make it possible to virtualize time inside of
> containers, e.g., it is feasible to reset the uptime of a container
> to zero by setting the time namespace offset for boottime to the
> negated current value of the CLOCK_BOOTTIME.
> 
> However, the boot time stamp provided by getboottime64() does not
> take care of time namespaces. The resulting boot time stamp 'btime'
> provided by /proc/stat does not show a plausible time stamp inside
> the time namespace of a container.
> 
> We address this by shifting the value returned by getboottime64()
> by subtracting the boottime offset of the time namespace.
> (A selftest to check the expected /proc/stat 'btime' inside the
> namespace is provided.)
> 
> Further, to avoid to show processes as time travelers inside of the
> time namespace the boottime offset then needs to be added to the
> start_boottime provided by the task_struct.
> 
> v4 Changes:
> Avoid type conversions back and forth between timespec64 and ktime_t
> in 'proc/stat.c' as suggested by Andrei.
> Introduced timens_sub_boottime() in 'time_namespace.h' to provide
> better coder readability/consistency.
> 

Reviewed-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei
