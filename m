Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3033227B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgGUJRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 05:17:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgGUJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595323049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vdcb3GpaeXFOSfLkJZmSHSJJPdtDgx51ddaWwtlFe/o=;
        b=f+qYbDDvS+Rjqw28g89UuI7NGCXPdY/wo/JyRFjqSoC+aRvFKP1OYHjQ1o//bWrTywQ05r
        voWggHZoVhSNQ71XzNTugOlhcJgWg+rt09tuM+HQULpRJLoCHZ4yuUUN9ijSU5+v4Iq2gs
        8wrPPOxqTaXUF+HPa7kMA0LO4LPXFuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-jGgrkyG6MEK7hCSMYKmD_Q-1; Tue, 21 Jul 2020 05:17:25 -0400
X-MC-Unique: jGgrkyG6MEK7hCSMYKmD_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C79100CCC2;
        Tue, 21 Jul 2020 09:17:24 +0000 (UTC)
Received: from localhost (ovpn-12-170.pek2.redhat.com [10.72.12.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92ABE7621A;
        Tue, 21 Jul 2020 09:17:23 +0000 (UTC)
Date:   Tue, 21 Jul 2020 17:17:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/5] mm/hugetlb.c: Fix typo of glb_reserve
Message-ID: <20200721091720.GM32539@MiWiFi-R3L-srv>
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-2-bhe@redhat.com>
 <0834fb69-7cc0-8c0f-d5aa-8ed6ffe9a2e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0834fb69-7cc0-8c0f-d5aa-8ed6ffe9a2e2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/20 at 03:32pm, Mike Kravetz wrote:
> On 7/19/20 11:26 PM, Baoquan He wrote:
> > The local variable is for global reservation of region.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/hugetlb.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f24acb3af741..191a585bb315 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3649,7 +3649,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> >  	struct resv_map *resv = vma_resv_map(vma);
> >  	struct hugepage_subpool *spool = subpool_vma(vma);
> >  	unsigned long reserve, start, end;
> > -	long gbl_reserve;
> > +	long glb_reserve;
> 
> I see both 'gbl' and 'glb' being used for global in variable names.  grep will
> actually return more hits for gbl than glb.  Unless there is consensus that
> 'glb' should be used for global, I would prefer not to make this change.

Ah, I thought it's typo, so it's just another kind of abbreviation. Then
I am fine to drop this patch.

Thanks a lot for careful reviewing on this patchset.

Thanks
Baoquan

