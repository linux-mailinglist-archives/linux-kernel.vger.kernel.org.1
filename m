Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407A32CC252
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgLBQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbgLBQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:31:08 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511CEC061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:30:00 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 62so950171qva.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w4g3S+xlvIrCO+/FOV5OgRZ1thWmRnYhNOzF2Xs2/Eo=;
        b=d593bOeGHr1UExK12z4v5kr/85o2IKxmpnz32AaGX6Sh+5FEVrsugMFhbD/M/XQ3Kx
         DvsjiqkVfbvhZRQ6bbAftq0a7Xw0EdPkgOUTz+kHJjP3IAP+vbkZPL53z/IOzJzIJGCd
         zObndtxrY8ZMdbv8hXRvnMTG/UiUVgb3/ypdPhU+ksPFPlpqOMzKxq+UH/N4/yrN++Wt
         0nTDHpNNAFcP9a/ntlTaBZB0G5qhyL11No1riKk6dg5JtyCFw4rrvoXfLcQJPzOoGsow
         pFBxFvFo7hb0C/eN8d2xGwMPsu9ZYGaZM6++ARd9Po9qn25drvuAy/Hs3bQf43ozKp40
         JLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w4g3S+xlvIrCO+/FOV5OgRZ1thWmRnYhNOzF2Xs2/Eo=;
        b=Xg+uB+NsYyST658N3Qi9flwJZReOAvXlLs9Hg6TnuCLYyORhYXkQt6PWjHli+OVVxK
         8dc4V9vS7R1ILQPvNlelL49jhRsnN2bWKRwpXxlauPl37CmzFe/msBNN2iq2/4k84/0X
         w0ZZQgVof4arAhTn3lU+G01Vg8hoUuGU31hLAt5SQi4oz8Doc8Wm3tGKXeUGY4Ml1pDj
         q9h7Ykw2HRfF0qxpSTNve5rR1sqJR/9WUsjT0RGRhJ+W7gAKWCGMN3kvJz4kIK97eAe5
         yuJABAzjYHv3OiB9SCqki2hl+wZuBwHZF1scC0DfuU8V6fD3oapLQvgjlb+N08Y3NgpR
         eEeA==
X-Gm-Message-State: AOAM533eFjDmNpw2mQfPqYikKfIKRR9Ccpz+Tv1Xy4SRnLiedQSINq82
        wud4fIOOrFvZkpzNo/Xg6hH4BQ==
X-Google-Smtp-Source: ABdhPJwrq09bfNPIrJ1rBBIxaEY6e7dgZTuxYSKii2fZiyNDBHOMOn0rKKInR7tVkslrutd4L2h9dA==
X-Received: by 2002:a0c:abc8:: with SMTP id k8mr3597913qvb.14.1606926599556;
        Wed, 02 Dec 2020 08:29:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s130sm1398639qka.91.2020.12.02.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:29:58 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkV0w-0056jV-4Q; Wed, 02 Dec 2020 12:29:58 -0400
Date:   Wed, 2 Dec 2020 12:29:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is
 enabled
Message-ID: <20201202162958.GK5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201202052330.474592-2-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:23:25AM -0500, Pavel Tatashin wrote:
> There is no need to check_dax_vmas() and run through the npage loop of
> pinned pages if FS_DAX is not enabled.
>=20
> Add a stub check_dax_vmas() function for no-FS_DAX case.
>=20
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---=00
>  mm/gup.c | 7 +++++++
>  1 file changed, 7 insertions(+)

I have a patch to delete check_dax_vmas that is just waiting on me to
figure out how to test with dax. That makes all this ifdefery much
simpler

Jason
