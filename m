Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C162FF815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAUWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbhAUWii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611268628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9F4FJm6CxPIzCDPXLeRl1F1UfXVZJLDgPR0BedATtNQ=;
        b=PJ05dneSll9m1U7TN3pW9qKEuvCktcMKjbvSHdIYfUay0RA3sGCW0fsvjt5lmpDQ5CObdj
        rIwg4oAkJDz9Ju5jEIZtxNj3lsnb3Rliq8UmZ2LI/KLiRuSqxipx/Q3amZapk9wYlizPZt
        gO99cpbC6Ny0G2WQOnMXBPz47/twr6E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-lxl9mlX4OYywnQCTXWdlcA-1; Thu, 21 Jan 2021 17:37:07 -0500
X-MC-Unique: lxl9mlX4OYywnQCTXWdlcA-1
Received: by mail-qt1-f200.google.com with SMTP id b8so2437495qtr.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9F4FJm6CxPIzCDPXLeRl1F1UfXVZJLDgPR0BedATtNQ=;
        b=XwkNmYR/dud5Vy7N3Erm2wtfZqLcERBLPfKljNWILx8n2pXi0Yqu1+H1zvlS7NitBE
         KL+Nahv0Ia76845pU6GufmIpPJphxcLdX3xhrHaDuU+mqdTTj+t8gam56cJ+ZVIZ5jTP
         wBtH3Hqs7zZc/kxJYPzYqgK18fwFZdiHYzrrdKxe/Z5u0pOZ5EZxBbzv+EhU3zuFszpt
         UNZQVmQmpI9JLBfHiIqFieLQHsvob0ZvbXfSuar9VQtpgE02yHlkBbsbRV3K9N9i/MGm
         srKo5ivXhILRZ11u+AmJM2Yi0C1A+3dQbIDR7/mBlnhhyhQfhWE+WHTdjCraKMLDkS8c
         Phzw==
X-Gm-Message-State: AOAM5339U61W98ONDodtlSfOdlnkDUUSxM4CSWI7mXou6Rgh/lSdm4IW
        WL+l/S4v8Zl0FRRbLQfgXqUK0WphQOjFaivsT/BGK7h8J/KlYlzMKDWVMubYRaagx5Mg09CY4ni
        V3hq2Ls4prTjJhPDIjfAjinUq
X-Received: by 2002:ac8:7a82:: with SMTP id x2mr1902818qtr.20.1611268626717;
        Thu, 21 Jan 2021 14:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzF3+w++uI/FnvKRDlQcHOvwzcsjyp5Q8slh4ec0gAIH6IQXOf+SKAUhSC7Vg50ypEzJuOuDQ==
X-Received: by 2002:ac8:7a82:: with SMTP id x2mr1902784qtr.20.1611268626438;
        Thu, 21 Jan 2021 14:37:06 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id 203sm4955384qkd.81.2021.01.21.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:37:05 -0800 (PST)
Date:   Thu, 21 Jan 2021 17:37:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling
Message-ID: <20210121223703.GH260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210121191241.GG260413@xz-x1>
 <CAJHvVch3iK_UcwpwL5p3LWQAZo_iyLMVxsMTf_GCAStqoQxmTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVch3iK_UcwpwL5p3LWQAZo_iyLMVxsMTf_GCAStqoQxmTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:13:50PM -0800, Axel Rasmussen wrote:
> When I wrote this, my thinking was that users of this feature would
> have two mappings, one of which is not UFFD registered at all. So, to
> replace the existing page contents, userspace would just write to the
> non-UFFD mapping (with memcpy() or whatever else, or we could get
> fancy and imagine using some RDMA technology to copy the page over the
> network from the live migration source directly in place). After
> performing the write, we just UFFDIO_CONTINUE.
> 
> I believe FALLOC_FL_PUNCH_HOLE / MADV_REMOVE doesn't work with
> hugetlbfs? Once shmem support is implemented, I would expect
> FALLOC_FL_PUNCH_HOLE + UFFDIO_COPY to work, but I wonder if such an
> operation would be more expensive than just copying using the other
> side of the shared mapping?

IIUC hugetlb supports that (hugetlbfs_punch_hole()).  But I agree with you on
what you said should be good enough.  Thanks,

-- 
Peter Xu

