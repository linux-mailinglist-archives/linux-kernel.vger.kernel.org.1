Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF642CD99F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgLCOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgLCOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:53:44 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29BFC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:53:03 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id b73so2341553edf.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PGZhDtw8lohZwEfuRTY+lg9Mj6nVPB6wAXikIPVOUI=;
        b=c/xx4kKp4++jFqqsnF8yOvaL9Qy/Ps7yAiktFkQR4XomxCPBiTVEjldWMvQmxdxzER
         utMzWzDYYMjNgq+m+1791hcB2dwfGgad8NHO4QNXbINlpQfLE//HeI3Bmw89P6fNpv2P
         cJlQlRdx9KN+6MQR43RDwg1KpMysDeDwZSORZtNRqFCilS09bqiIWSqm8knL4u63wAWR
         kJUy0vtqdHuF/0MHDZBWaW+7wwYz8AZYQR+TLYkXeeXw9Ysk7Yc1q1AYe8nlBh8MHUUr
         7Y0kkMHX7ZaR2uqUwCn7NK670A/yFq48e4N8eIsRd8EVw6YrtfQe2nZQ/YEuEcAonEjd
         xBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PGZhDtw8lohZwEfuRTY+lg9Mj6nVPB6wAXikIPVOUI=;
        b=FF1HAKVorKiJuHXhUiqLuV4tyaPhq/BhdlfxGPfFReG5BzNZJOPNYyxIXso5beHj0l
         z1OW/MwcktkqdZpruHouC3n8TnSRO2HllVQkafzgvGKIAsx3eHGocOB8JkfofR4dKBNf
         nqSUXhlyrJ6vQ4VgN9rc370sz5QWxrMPNCR0+DHYtMIadKWg4fLUSmrAc9FwwmNTs9bh
         MquHwNaOddTmXAenHZo/XjFVuTf13KGJBafhnjMdG0itkGnCBksM7GSY4CzCdjyYzpZW
         agt232SR63uobSJuKUs2e2slynaCuwbPpBJCI9IzQJDDpzkI8sQPtmcp+00u/rv/tFAd
         FOuA==
X-Gm-Message-State: AOAM531o1h9zdxFfOudJwTQ9jOQompYAWBfUEdK9BgiTc3EyfHD6BdGu
        80u5WOx5/spD85JIckt4XaCgwMBlMtvAVGaJAqaeaA==
X-Google-Smtp-Source: ABdhPJy0K7YxiY1fCZhdqfPz0KeqPxAMjwYKMGD/vmAlqr9UKHHjzXaohk4Pl6Cgj5ZcxymyIfdeH1uLxqUGg8lRSV4=
X-Received: by 2002:a50:d757:: with SMTP id i23mr3210383edj.116.1607007182510;
 Thu, 03 Dec 2020 06:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-2-pasha.tatashin@soleen.com> <be8546cc-bad3-d47e-dae7-0daca69c699c@nvidia.com>
In-Reply-To: <be8546cc-bad3-d47e-dae7-0daca69c699c@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 09:52:26 -0500
Message-ID: <CA+CK2bBhPLpfXPoQn76_0s4KJoL=tVYe+ifPUQeu1NHLKHctng@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks obviously correct, and the follow-up simplication is very nice.
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you,
Pasha
