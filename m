Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8B2FF407
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbhAUTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbhAUTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611256367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPl8jorAsGAxXf0P/mQDZPfRGxFOXLofHdgCnNwVIcc=;
        b=dgeqA9M5i2ibO6RCyA/McyKZ4pzjjZ3b8G0v1y8EEpoq5vOGv2lQOrqr2wf2pZ3IfK9WUg
        gkEwrBnRE38IRTMBX17FBAR3Iz0rFP1VbwxwfaUTCkiIs/2XOvoblnhS5jCIpBxleyc86c
        91D61cxUk1ORIriZFotjAYV2FQfT2X8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-MkFjjvg-P7ycwcburL11mg-1; Thu, 21 Jan 2021 14:12:45 -0500
X-MC-Unique: MkFjjvg-P7ycwcburL11mg-1
Received: by mail-qt1-f200.google.com with SMTP id w3so2107170qti.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OPl8jorAsGAxXf0P/mQDZPfRGxFOXLofHdgCnNwVIcc=;
        b=tZckoJncsQf5z/6orINjONqG1NckfC+xWNzKVLvgHWLyso4VzunucmpAZxloIsEQQu
         1dGpmeObvZkC/9d/vb21Os9WvIJ4HT30+PceaCxfhv44K6dMOYNGe8J/s0q7db/kQ7tA
         jh3Ehxipi3IbzUkSmbHl1p8S5La7w5bKbnCwtp/M4lDicjagjkdYmHxfVWnluYxcXjFP
         NI96O7gphu4PrMIXUG7xoeDHEsKqJYEu1mkYl48YV3jl2x1ep+3bBTgCtL/dhMyIx3H1
         2HhHxl2y2SAwlui1hEarUnD+QcI9Cp83ZrbmKUMWw0+XwexwJY8wMTXjFpgu41+O3nz4
         /NdA==
X-Gm-Message-State: AOAM530zmYr/GBqp6o/aSI2wz/mrZ7zvUT6ex6K8Jm8zH7t/rL5qlkWc
        FkCFQ9kx5s2vUUVt9thxyVI1Ti/woyvnbBucCVrInxWV/OoSOBU0UrGsktejB4inIvqEpCMeVKH
        wZ+n+E5Z4+88hd+8/l8EMa3Bm
X-Received: by 2002:a05:620a:1370:: with SMTP id d16mr1350883qkl.26.1611256365113;
        Thu, 21 Jan 2021 11:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjih88mfXgX9Vd3gMH5PELft+ec29CkvSN6ax9zZG54+dCmmfWryq5S5QgIKBD44NV5o5pUw==
X-Received: by 2002:a05:620a:1370:: with SMTP id d16mr1350868qkl.26.1611256364928;
        Thu, 21 Jan 2021 11:12:44 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id b78sm4408055qkg.29.2021.01.21.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:12:44 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:12:41 -0500
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
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling
Message-ID: <20210121191241.GG260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:04:42AM -0800, Axel Rasmussen wrote:
> UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
> modifications, the existing codepath assumes a new page needs to be allocated.
> This is okay, since userspace must have a second non-UFFD-registered mapping
> anyway, thus there isn't much reason to want to use these in any case (just
> memcpy or memset or similar).
> 
> - If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.

When minor fault the dst VM will report to src with the address.  The src could
checkup whether dst contains the latest data on that (pmd) page and either:

  - it's latest, then tells dst, dst does UFFDIO_CONTINUE

  - it's not latest, then tells dst (probably along with the page data?  if
    hugetlbfs doesn't support double map, we'd need to batch all the dirty
    small pages in one shot), dst does whatever to replace the page

Then, I'm thinking what would be the way to replace an old page.. is that one
FALLOC_FL_PUNCH_HOLE plus one UFFDIO_COPY at last?

Thanks,

-- 
Peter Xu

