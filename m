Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC36F2FBCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbhASQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733193AbhASQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:53:23 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C71C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:52:40 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h21so449423qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGojdeA20zzASlYpdW76UKnqe50ntC8qShndn6zJIz4=;
        b=xtAjKAEtfJQvTQE5lGL0o/pBMwEY1osKiNGCA40ER/PyoQC6arxZqOi3F65vp97cKN
         h+lMfbHribwS5JhD+aM32o5RCl7lTiUuS4dsKUM0nJ8J/V4y8xND8eWXhbfYz935LOuH
         Oygf+8ZTdrQUK4JsMzhoMVERDJnqu7csEnK5zT75ytSHbN7YI8FOvCBn/LZSz7DOvAwY
         6GvraSTztJHRercM9PV46hF8l53VyDol1fxk7eJUlraR/FfdKKf2/tpxctc9l/tfB7JP
         qwQhf7xoRiBqJLidHBzAtWUem0/wr1XEQeC0oFNFhYaFgbHqiOmNo1Baurzc1aS0pcu8
         9iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGojdeA20zzASlYpdW76UKnqe50ntC8qShndn6zJIz4=;
        b=Xa7hfKmB+UCCsCLnLORWMKJFtgg4jAXTCIlZLuMvQ29ksJ7O9ihF9I4vQjXtr3VgMK
         w3Dml4bUCXnSre6mvyXocVNzY1ew1I7kSNl5Tc3pYQIhYPJM4rf4LIeC+1a+hKdWmEDf
         /kr0fsuA4HR7aS2kh5HZ7sZBIyE8gC2HrNnw5bho5hl+TjjA5F9ZgAUHSk+kXmlrCt5y
         Ii9R9DFiDN6HZwnSEAQWvhwXFhzn+kBP+pUO9uNQ2Vea42/1DbKN4q4EfI5xOgilhpIa
         GZQ8VHAp9XBgvg2LgjEY4taXaslnIGzJqdXl6+Hd+CM0W4VTPgxgdQbCx7KSTrN79RRw
         Rx5g==
X-Gm-Message-State: AOAM5339SUVfo4AV3snEkyeT92DThBe6OgGo+uSHYwtBYSoA4vB97sWN
        C3/p7UppMHn9z5qcraP4VWPoWA==
X-Google-Smtp-Source: ABdhPJz3ic1j17HOrepfbmnlJXR37AVr6m5z0Ku7AfBnvKhYbNPxVtgPdcR7MnHR/P5XmARgVyLfHg==
X-Received: by 2002:a0c:c3c9:: with SMTP id p9mr5315412qvi.49.1611075159264;
        Tue, 19 Jan 2021 08:52:39 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id w91sm6552912qte.83.2021.01.19.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:52:38 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:52:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, dschatzberg@fb.com, surenb@google.com
Subject: Re: [PATCH v2 1/2] cgroup: fix psi monitor for root cgroup
Message-ID: <YAcOVZ9hceK3gwWT@cmpxchg.org>
References: <20210116173634.1615875-1-odin@uged.al>
 <20210116173634.1615875-2-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116173634.1615875-2-odin@uged.al>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 06:36:33PM +0100, Odin Ugedal wrote:
> Fix NULL pointer dereference when adding new psi monitor to the root
> cgroup. PSI files for root cgroup was introduced in df5ba5be742 by using
> system wide psi struct when reading, but file write/monitor was not
> properly fixed. Since the PSI config for the root cgroup isn't
> initialized, the current implementation tries to lock a NULL ptr,
> resulting in a crash.
> 
> Can be triggered by running this as root:
> $ tee /sys/fs/cgroup/cpu.pressure <<< "some 10000 1000000"
> 
> Signed-off-by: Odin Ugedal <odin@uged.al>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Fixes: df5ba5be7425 ("kernel/sched/psi.c: expose pressure metrics on root cgroup")
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Since this is a userspace-triggerable NULL ptr crash, we should
probably also

Cc: stable@vger.kernel.org # 5.2+
