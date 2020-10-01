Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B497928052B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbgJAR24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:28:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A11C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:28:56 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so6260357qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cTvaI1eVY2OnmFQ3ki6lTkVmY7EWHdYKiZzBjOwmf/A=;
        b=Ifiyw27kae41qtg0PObv6iwLOlFsSlh/I22uTxIBiFePtUZG77QvMVXvSLXSu46b7k
         Xk9QAwByiv2cwG33zWYbXdCXqIsxMyXSd04HJXKyvY44jEphpO8BcF5aWwRTrmj4B9lk
         kN9K9q5hYC08A9xBQmrKULBykNAl1njgO1Hl5pJdhtGU25e0RPFnhkzBU23nTGFC23ZC
         jk8YIVzMS28GVFcnSA7r6q8cSk/Jv+Z612HHu+ARlwnhjWCjGXymFNjb1omMdEyREAi/
         TXtpfXi/4d8L6z6Ea9P+CSSCrxe3oa7R5rn8Tp5kw8/ZGX4ePKad8lLnLFNPw8oTsmWe
         eFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cTvaI1eVY2OnmFQ3ki6lTkVmY7EWHdYKiZzBjOwmf/A=;
        b=SlLUvdIdn2+mbNR0AIGYYZ1ji20DyCLQX3Z2zkG2VeLwKn6Va474tvsca9+1EU0kyV
         W2rjSGqrovlEtphhNF1oRjeimr//fYL0cgS6jyF8VS5n4I9tk9ORsNUjFcRH6h651ecj
         H7AWFEUBx7zRFrPb4J5ZXvQHS6SAzhxTiq9zn0rXKIjTJrGqV0+/hcih+zUWUoq/xnjb
         OS12X8G7cmiBWiXcneLhiVb2fMv8WXbtXj/XAR/HJgs8+fIn8UE1xTkf0ndusbZZ+O4O
         Q4Ls6MU7y/XOvsFbuzB8ehYDtZLik9LzAV3najM4DYu0Rq/ekK7r+uLGL3SK8Qj3V72R
         svSA==
X-Gm-Message-State: AOAM531tQw1Z/urTOiNUJqdwRWK073SPAXwaQdOtCkILz7fnWiOmgeC3
        eN4qTKqFQbg1bf7tgugNB3hZlA==
X-Google-Smtp-Source: ABdhPJxOL87QOYC8fbmvcToVHw7h3RdDxNazf3n7Us2F4dA657WGsRkzwapgpDTbyaOcfYeMlZm7kg==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr8885502qkk.101.1601573335441;
        Thu, 01 Oct 2020 10:28:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id 90sm3871205qtb.6.2020.10.01.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:28:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 13:27:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201001172713.GA500308@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
 <20201001170036.GA29848@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001170036.GA29848@blackbook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 07:00:36PM +0200, Michal Koutný wrote:
> Hi.
> 
> On Wed, Sep 30, 2020 at 05:27:10PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > @@ -369,8 +371,12 @@ enum page_memcg_data_flags {
> >   */
> >  static inline struct mem_cgroup *page_memcg(struct page *page)
> >  {
> > +	unsigned long memcg_data = page->memcg_data;
> > +
> >  	VM_BUG_ON_PAGE(PageSlab(page), page);
> > -	return (struct mem_cgroup *)page->memcg_data;
> > +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +
> > +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> >  }
> Shouldn't this change go also into page_memcg_rcu()? (I don't think the
> current single user (workingset_activation() would pass a non-slab
> kernel page but for consistency sake.)

+1

> Alternatively, I'm thinking why (in its single use) is there
> page_memcg_rcu() a separate function to page_memcg() (cross memcg page
> migration?).

It goes back to commit 55779ec759ccc3c12b917b3712a7716e1140c652.

The activation code is the only path where page migration is not
excluded. Because unlike with page state statistics, we don't really
mind a race when counting an activation event.

I do think there is a bug, though: mem_cgroup_move_account() should
use WRITE_ONCE() on page->mem_cgroup.
