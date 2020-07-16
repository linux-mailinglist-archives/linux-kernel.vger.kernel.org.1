Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61E3222602
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGPOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:41:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:9934 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594910468; x=1626446468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=WgLPcJcDvmO1HDGFSrNi11B/JKsuuTcd7JuCpbbFOD4=;
  b=ZBZcMIoxn1ehU0McGc0pxROU3Rnr++XtPor3nnYwG0NkPre/1cC/r0nZ
   ixAtfy6VlzeaEcOZwNDCZ0x+rhGQYy9yCiPh3eNm28uPLlMCRw19KpkKD
   TCCzw10iwOFI2VDB7mWlA4UBsrbNjENMNLNSWgjoiS58YOVI+PgEto17O
   8=;
IronPort-SDR: 6qO2nfcsyzICMxCVboJ0sND17zZapiwfXyoLjaU9Xnhdos9EaoIQOE54ypXA0MicNvi30bZD2Q
 J7karhGWRKjw==
X-IronPort-AV: E=Sophos;i="5.75,359,1589241600"; 
   d="scan'208";a="59095810"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 16 Jul 2020 14:41:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 4912CA263D;
        Thu, 16 Jul 2020 14:41:05 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:41:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:41:01 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] linux/sched/mm.h: drop duplicated words in comments
Date:   Thu, 16 Jul 2020 16:40:42 +0200
Message-ID: <20200716144042.30926-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <927ea8d8-3f6c-9b65-4c2b-63ab4bd59ef1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D48UWB002.ant.amazon.com (10.43.163.125) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15T18:30:31-07:00 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop doubled words "to" and "that".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/sched/mm.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/sched/mm.h
> +++ linux-next-20200714/include/linux/sched/mm.h
> @@ -23,7 +23,7 @@ extern struct mm_struct *mm_alloc(void);
>   * will still exist later on and mmget_not_zero() has to be used before
>   * accessing it.
>   *
> - * This is a preferred way to to pin @mm for a longer/unbounded amount
> + * This is a preferred way to pin @mm for a longer/unbounded amount
>   * of time.
>   *
>   * Use mmdrop() to release the reference acquired by mmgrab().
> @@ -234,7 +234,7 @@ static inline unsigned int memalloc_noio
>   * @flags: Flags to restore.
>   *
>   * Ends the implicit GFP_NOIO scope started by memalloc_noio_save function.
> - * Always make sure that that the given flags is the return value from the
> + * Always make sure that the given flags is the return value from the
>   * pairing memalloc_noio_save call.
>   */
>  static inline void memalloc_noio_restore(unsigned int flags)
> @@ -265,7 +265,7 @@ static inline unsigned int memalloc_nofs
>   * @flags: Flags to restore.
>   *
>   * Ends the implicit GFP_NOFS scope started by memalloc_nofs_save function.
> - * Always make sure that that the given flags is the return value from the
> + * Always make sure that the given flags is the return value from the
>   * pairing memalloc_nofs_save call.
>   */
>  static inline void memalloc_nofs_restore(unsigned int flags)
> 
