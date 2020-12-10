Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0862D683F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393713AbgLJULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404607AbgLJULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607630996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWqbBNr4gWSCr8pvKo6/G8xp2xMusCiyp684h+DSVQc=;
        b=g2ND1IRxUoBMSrT6jQ5JShJW5a+cLoU4XULkrSVNA4tyvVsx96MqTgD6AuVcBCn66muy12
        P9WiDCUgCHIScP1GMq6L2YCbV/kAOpkCfwdw4VxCkBjFT3V/cIMzc+KrwZLeOrTTyPiLzr
        oqpaGdnXfDE+5jlrj4TEh5AuX8TcPR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-stD4G3nyORuHuKYGfQCVmw-1; Thu, 10 Dec 2020 15:09:54 -0500
X-MC-Unique: stD4G3nyORuHuKYGfQCVmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19CE3107ACE4;
        Thu, 10 Dec 2020 20:09:53 +0000 (UTC)
Received: from ovpn-66-25.rdu2.redhat.com (unknown [10.10.67.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7875D9CC;
        Thu, 10 Dec 2020 20:09:52 +0000 (UTC)
Message-ID: <6595b15eba54cf5efc2ea801ea91c41681f33c61.camel@redhat.com>
Subject: Re: [PATCH 4/6] locking/lockdep: Clean up check_redundant() a bit
From:   Qian Cai <qcai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Date:   Thu, 10 Dec 2020 15:09:51 -0500
In-Reply-To: <20201210144619.870033538@infradead.org>
References: <20201210144254.583402167@infradead.org>
         <20201210144619.870033538@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 15:42 +0100, Peter Zijlstra wrote:
[]
>  /*
> @@ -2706,6 +2666,55 @@ static inline int check_irq_usage(struct
>  }
>  #endif /* CONFIG_TRACE_IRQFLAGS */
>  
> +#ifdef CONFIG_LOCKDEP_SMALL
> +/*
> + * Check that the dependency graph starting at <src> can lead to
> + * <target> or not. If it can, <src> -> <target> dependency is already
> + * in the graph.
> + *
> + * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
> + * any error appears in the bfs search.

Correction -- or BFS_RNOMATCH if it does not.

