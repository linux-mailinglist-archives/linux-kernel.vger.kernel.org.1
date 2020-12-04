Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A52CF59C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgLDUX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:23:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607113320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBwgpEeW4xc6+9FNssSrVJyClVzSD80HYv6Uay1hDi0=;
        b=BUfYQ4rnCoPBoeRjyz6lrtgdjXfBjYAiMrpdFMFTxLK6j/3hkUl4U3pMV3CcPtVmz2ZXJ2
        89PDR+8xzYQLsuzX5j3qLteyIue7/vPEzCsWuIduiS0RQBCJ5GqRLtpO8HP2LM0Fic/niG
        BbOalFqyZVlr6ASJvn4x/mwHjerKfd0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-P8Pm-yowM3-Mdvj1JyLNnw-1; Fri, 04 Dec 2020 15:21:58 -0500
X-MC-Unique: P8Pm-yowM3-Mdvj1JyLNnw-1
Received: by mail-qv1-f69.google.com with SMTP id y8so5717878qvu.22
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBwgpEeW4xc6+9FNssSrVJyClVzSD80HYv6Uay1hDi0=;
        b=tdKhol1yilJHRByybS5Bmrf7RSaEx0gvHk2dwQkRFwL8fRwg1IyZP/vQNA0pU4KAVe
         Du1glXRfngz6AVtEtqzeSJq3aSR5ZExguRpOUwXxcVhKcmAU6t0/45RQbgVK0fzzZCEl
         WsD/0rV/YLfL0N2CrxQI4ML5UUNRU35bK6Lsa2WyfIHPyYTRmsB1D2lQQ2SecbxdTz8A
         9UZEH9GG7GvaqTwa50GjFEIk9gvb7cJCfoT29ggktqG7UBaU5o5NQFW5jWkeeoYKdfh/
         Lgb4t1trSWxXfLQcSef1Xlw5cGOyVfFGdWdrsMdypbwEyNNuY50f5R0AD6z+hf3POGkN
         nYLQ==
X-Gm-Message-State: AOAM531MswrcGstmUBcDij93Ie4v7R1T2ld8iT87wGwZ+rloZaDSaYMT
        HtYc4loFKSnQ7/70QF0dGvpwCZmUg8popmdE76qtABezdohb6u7vCx2wiF67g0z7yYDfZQxNRYM
        42CW/WBV6AEKlxVi2CUuR1GB4
X-Received: by 2002:a05:622a:14e:: with SMTP id v14mr11003042qtw.298.1607113317891;
        Fri, 04 Dec 2020 12:21:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuxHkVg57WO0rHdCyHJUi2+myd+Mny0FbYJ+FsqUJi5N6i1k+NGwIQBGkMG+vGh195cohE0w==
X-Received: by 2002:a05:622a:14e:: with SMTP id v14mr11003010qtw.298.1607113317649;
        Fri, 04 Dec 2020 12:21:57 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id o4sm5836753qta.26.2020.12.04.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:21:56 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:21:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201204202155.GQ108496@xz-x1>
References: <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
 <X8m2qv9h7+e79UjJ@redhat.com>
 <X8p8KNJXD3aK9TkF@redhat.com>
 <20201204192329.GP108496@xz-x1>
 <X8qP7QEQTKrhZo57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qP7QEQTKrhZo57@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:37:17PM -0500, Andrea Arcangeli wrote:
> If we use _UFFD_SWP_UFFD_WP it looks much cleaner to keep it in the
> pte, not in the swp entry, since then you can use the already existing
> methods that only can take in input the pte_t (not the swp_entry_t).

Ah, I see now.  Yes it looks nicer if we don't even need swp_entry_t knowledge
to recognize the special pte.  So I'll try all these ideas and update.  Thanks,

-- 
Peter Xu

