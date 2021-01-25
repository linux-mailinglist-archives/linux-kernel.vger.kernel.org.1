Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5D302C98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbhAYUd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbhAYUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:33:24 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2013C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:32:29 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so6817355qvd.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIwQuMBHka7gokpbJ5MIBj9FnPmCdt3O6QrbAG8k0HA=;
        b=L+SrTmGx1a32S6BmbmN6EB1+MJP4SexQUa3GG6ckuFkYGGGP+8CUH1IP1zM9V2ne/z
         XiSzgjQfRz4pRWpCOJFng+ypTkrYPQeq9tbU3SehKZ1wT3kDb93iFpJIvqPQnLNq4GL8
         D6mzacXnXZYq1ikinYsaRwOqzUu6IWm8WrCPOysU45W4EoZNk9j1o878CIdtWsIzDpiE
         Vw0CczRotj4Hw/IRD/mD8PLFzVVbbMx1EWi9mi4ySrLtsMW0YBXmcmxVoZZPy72vFIBi
         TOgDwaRm+qDhm1snpRA4YcTFJQw/jJEIIUttlZ6OkiXH+Yp6EJjLranlX/Gi3JjoocV1
         20+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mIwQuMBHka7gokpbJ5MIBj9FnPmCdt3O6QrbAG8k0HA=;
        b=PO5WETxGag/r5jeLEYpCghWahVDgzo/1bM0xUxAFBQvp7Kjx5GvMiZgm26zkAeVFWN
         RSTmbHfc80gbTiQu6KCx7t9a+pNIkNC+OcvoSShXhit547bECvnfjouDU1jNJctm3ubk
         06FpRQcKMd1QD9fzoOfs1cl45R252OgiA6lqUU36PLQNr7/yBT5o5yHjMioTzIdotcZp
         V3iCvbGgv55fb+Ms3ncX7wA3ElkdcO6AC+4vz6hWsc2sJSDvwQOIZy0+7Z8TKy+EIn0/
         ALyYrfJ9Fx0eVdAra0GZhg1b7jaui5nxZ0oLnPDkZsKiBp42nh9YxXhDEQmGIDehokFm
         It9g==
X-Gm-Message-State: AOAM533iV8q/L3fesvD5gYg6ct0oBeTEoA6SzcO3FMkvATG6XdQ5yR5k
        3ySKKEJlC7gbbCvTYZmKidg=
X-Google-Smtp-Source: ABdhPJxzM+5/1kdRPBOEGm/nz15p9YtqXPoaI2oTmlAFRnXoZl4k+smbki10+SiXkQPJFp5lT9sgvg==
X-Received: by 2002:a0c:bf12:: with SMTP id m18mr2557411qvi.40.1611606748796;
        Mon, 25 Jan 2021 12:32:28 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id l35sm6579161qtd.90.2021.01.25.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:32:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Jan 2021 15:32:29 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Saravanan D <saravanand@outlook.com>, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] x86/mm: Tracking linear mapping split events since boot
Message-ID: <YA8q3eSTuIrUmPeM@slm.duckdns.org>
References: <BYAPR01MB40856478D5BE74CB6A7D5578CFBD9@BYAPR01MB4085.prod.exchangelabs.com>
 <30752f8e-16e9-d093-e6ec-31fd45715e9d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30752f8e-16e9-d093-e6ec-31fd45715e9d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 25, 2021 at 12:15:51PM -0800, Dave Hansen wrote:
> > DirectMap4k:     3505112 kB
> > DirectMap2M:    19464192 kB
> > DirectMap1G:    12582912 kB
> > DirectMap2MSplits:  1705
> > DirectMap1GSplits:    20
> 
> This seems much more like something we'd want in /proc/vmstat or as a
> tracepoint than meminfo.  A tracepoint would be especially nice because
> the trace buffer could actually be examined if an admin finds an
> excessive number of these.

Adding a TP sure can be helpful but I'm not sure how that'd make counters
unnecessary given that the accumulated number of events since boot is what
matters.

Thanks.

-- 
tejun
