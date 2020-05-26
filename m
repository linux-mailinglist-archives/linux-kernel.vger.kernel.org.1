Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E621A6C13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbgDMSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 14:35:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26203 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727904AbgDMSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586802956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0tliWDeiVmQwDrsWSHtumkvzo85k+vRaxnPj1BBihg=;
        b=FL96mpKRFLMFEIECKnwjW2SEKPlLbuZ5Fd3oHfYcqTiUzIatneachN44CsT2vXdaBSbEHE
        iob+CCCJKPDUUIgzwZgrhxLWvBr3XKzrxz1yR5Dfv51hGTfDa5R/rLZOydFRzXRZTjRPxS
        IhD5epIyDtmAVZEn+CgHJH//DN6iyzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Hk4awqugNlyMDNTWU23dQA-1; Mon, 13 Apr 2020 14:35:54 -0400
X-MC-Unique: Hk4awqugNlyMDNTWU23dQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38BBB802560;
        Mon, 13 Apr 2020 18:35:53 +0000 (UTC)
Received: from mail (ovpn-112-243.rdu2.redhat.com [10.10.112.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE72F99DEE;
        Mon, 13 Apr 2020 18:35:49 +0000 (UTC)
Date:   Mon, 13 Apr 2020 14:35:49 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/userfaultfd: Disable userfaultfd-wp on x86_32
Message-ID: <20200413183549.GA758@redhat.com>
References: <20200413141608.109211-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413141608.109211-1-peterx@redhat.com>
User-Agent: Mutt/1.13.5 (2020-03-28)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:16:08AM -0400, Peter Xu wrote:
> Userfaultfd-wp is not yet working on 32bit hosts, but it's
> accidentally enabled previously.  Disable it.
> 
> Fixes: 5a281062af1d ("userfaultfd: wp: add WP pagetable tracking to x86")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks,
Andrea

