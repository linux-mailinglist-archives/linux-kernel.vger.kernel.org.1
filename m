Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA442D7FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394559AbgLKUZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394479AbgLKUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:24:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985FC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:23:56 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j26so7293849qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ELqdRXlB+MjwvvNKBuEm7rQwzLSIQMH5YM/Dpnj0Am0=;
        b=BxCjNUzeRilpLNFa++B1NsYrYbCN9twqCH3qY3QELZYysTlTjgXGfyhr447n9wmYfO
         5aaPIRP7vqa3uynlTB2ZW9HaNgMq/linzUslEIxqMf8IhIwA7rXgncZ7ENiyoJu2c1w0
         K8Q+HjqPk4VjfOvFV0RfQcgntEggt9NeEYdn9EH96zhyjMygI3vlV+9PWsTyIHCWJj4j
         n4I+4Rq6P4/92l064bPU7e+VARtuNHVCE8dt8Biwr3NZtrCka9wwZ5EhrzePVhMqSbg9
         CtvRX98LxYchtQNkYXxces3ryzg325UrqmKpOz+2+N+/RQ1uuB9YcH/b6WRZYqSYcCFI
         dx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELqdRXlB+MjwvvNKBuEm7rQwzLSIQMH5YM/Dpnj0Am0=;
        b=WXQcI7kMUWihLA/Q02tCe09LadqMLFknYBxOJ9/2+gBBWybWP4jwhBMrz1DEeWrHwY
         uSrUabW3oCGnTJJz+iA8EbpaXKdJTRsQj1/45bB/MNJ4yb/E2PKg5U0VLh2+QoASSX8O
         25GCDx0ACVUWJq3DLR7R1wjlv8obP9KDEZe0vHHErK0y7797+erOfx2894EqvwnnWFJA
         rwWWjipq4yfPEBv43vtDsMfSTw/rAZZ9anMeLIZqsqGgFZEcGyMlO3+On4Zix/NxSGbx
         1kOmhazlmetMVMaxMdFuSQ2adk8893vrcNOyrkowaaRNaf6dhEwnjvVq1jQpd2yx8sYT
         pWeg==
X-Gm-Message-State: AOAM532qDG7FPQEIoynxHvX+BqDCcScMPzjA7YMLnlf7Qf4GNNZX6rdW
        xwFDjUodh9JUEjPbW8HdupBclw==
X-Google-Smtp-Source: ABdhPJy9rue36Wb0wJHhBUETw/119DrBaQGbguszUb9eoNfHAzOrBGwR8fu58hiomMY5ZuNPWOmxWw==
X-Received: by 2002:ac8:3ac5:: with SMTP id x63mr17550095qte.376.1607718235945;
        Fri, 11 Dec 2020 12:23:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 187sm8409820qki.38.2020.12.11.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:23:55 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knoxG-009L1i-FW; Fri, 11 Dec 2020 16:23:54 -0400
Date:   Fri, 11 Dec 2020 16:23:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201211202354.GA2225686@ziepe.ca>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202140.396852-6-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
> @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  				}
>  
>  				if (!isolate_lru_page(head)) {
> -					list_add_tail(&head->lru, &cma_page_list);
> +					list_add_tail(&head->lru, &movable_page_list);
>  					mod_node_page_state(page_pgdat(head),
>  							    NR_ISOLATED_ANON +
>  							    page_is_file_lru(head),
> @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  		i += step;
>  	}
>  
> -	if (!list_empty(&cma_page_list)) {
> +	if (!list_empty(&movable_page_list)) {

You didn't answer my earlier question, is it OK that ZONE_MOVABLE
pages leak out here if ioslate_lru_page() fails but the
moval_page_list is empty? 

I think the answer is no, right?

Jason
