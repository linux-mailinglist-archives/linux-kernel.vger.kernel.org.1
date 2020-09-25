Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90305277FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIYFXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgIYFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:23:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601011409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeVZ/oNWYrQPapNzlO3BHP5CuXNC3u8y+M6g9AfJmiM=;
        b=ZJERDcnHhftLlphUCzbgfO2qhJUvV8S+2Cp2ZWViDOQ6KmrWSLCIV6UR4xXI5p6oM5JKam
        tcMNk3/Od035L4Bq7d2rchJyO7TEAbNzgrXtSEGuYDvR0k+QLWHffQO2WvIyiQwo90CBSf
        LIxzwKL9j9GySNxh61gbX1gk2u9h770=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-FW3B2X4bMgCBO7fufZsn8w-1; Fri, 25 Sep 2020 01:23:27 -0400
X-MC-Unique: FW3B2X4bMgCBO7fufZsn8w-1
Received: by mail-ot1-f70.google.com with SMTP id d10so450911otf.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 22:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeVZ/oNWYrQPapNzlO3BHP5CuXNC3u8y+M6g9AfJmiM=;
        b=pISehOsdbPYxkUrQnDbjIjZfQnwgI+vzLZ0C85nJ5Zwq3cf0i9y9NS7n/PO+02E6XJ
         m3ooZaIu1qaCxm1hSNEdr5BOqTuHEexdS3NZEnHla4AaCsbmcWBic07O5qZrID5GFIVt
         8HeFtw4r1DD0ttN086PKsI5oz70aQ/FM/+Z8nW+aVRlFlIVuWEtDbqe0yG/JO62fVML7
         KLVLmyxdsBRFKNzJ4q1bbh0FSAZ9Y3cvRscoRaLFO8hEWf10gaZ4aIgXuVOcG73kfZjO
         lMiGZ2apsXbpzbIsgoRrvVNqEsB2GbKhA2+sKcw0o4pJwM2kJUZvQ2amSMrzr+Pholu6
         Bq0g==
X-Gm-Message-State: AOAM532sg/QoRuD6ldLjU9mwprbu6X8+8Es7zFk6m3xpz88mlkdIHdTG
        jRWpXEAtkB429gUjFJrBaSRwbXjxREfhpjngWT4ERwe4u0poh+ZChm1OYG9cutmQdVJHL+kJMCB
        tNhZVYhdnmRXNoe6yHdjmeeZHwnw7/ksR4KUnaP2E
X-Received: by 2002:aca:dc8b:: with SMTP id t133mr618402oig.158.1601011406272;
        Thu, 24 Sep 2020 22:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy13wCPB9+BIoLDsXjH5tJgof8j8NkbNBYAKVJlMOIZ5hpPK5IcdaTrr3cklV3+pKnxu4dYBBpwixHjCsoVvl4=
X-Received: by 2002:aca:dc8b:: with SMTP id t133mr618387oig.158.1601011405935;
 Thu, 24 Sep 2020 22:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 25 Sep 2020 10:53:14 +0530
Message-ID: <CACi5LpN9sRz12EWJrWQOQPLbOPEboDikb7oG1tG=XZV+sOWLgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     RuiRui Yang <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ktkhai@virtuozzo.com, Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Thu, Sep 24, 2020 at 6:18 PM Alexander Egorenkov
<egorenar@linux.ibm.com> wrote:
>
> The offset of the field 'init_uts_ns.name' has changed
> since
>
> commit 9a56493f6942c0e2df1579986128721da96e00d8
> Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> Date:   Mon Aug 3 13:16:21 2020 +0300
>
>     uts: Use generic ns_common::count

A minor nitpick:
You can add the following line to your .gitconfig:
one = show -s --pretty='format:%h (\"%s\")'

running a command '$ git one <SHA-ID>' will then give you an
abbreviated form to be used while referring to existing git commits in
the log message. For e.g. in this case, the output would be something
like:

$ git one 9a56493f6942c0e2df1579986128721da96e00d8
9a56493f6942 ("uts: Use generic ns_common::count")

Then you can use '9a56493f6942 ("uts: Use generic ns_common::count")'
to refer to an existing upstream patch in the log message.

But I think this can be fixed while applying the patch (if there are
no further revisions required).

> Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain
>
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..173fdc261882 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>         VMCOREINFO_PAGESIZE(PAGE_SIZE);
>
>         VMCOREINFO_SYMBOL(init_uts_ns);
> +       VMCOREINFO_OFFSET(uts_namespace, name);
>         VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>         VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> --
> 2.26.2

Thanks for making the changes we discussed in the v1 review. Otherwise
the patch looks fine to me, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

