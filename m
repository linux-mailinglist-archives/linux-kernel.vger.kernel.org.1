Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1790F2E8E0A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhACUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbhACUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609704561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gY25kMTslD86b+if043D7soDi7GRGfoqhEdS0yfs5UY=;
        b=OIXGdwL4A/unMR1Kb9JGqbNWHI+ajKAeSEmh5P4T4IVTwnWSw+Re0DDHS9hmJljmKy9OOu
        BS9dVHLnGdh5/N5XItRQRdf00d3rsMoG7+5q+3x7vKlhepKV78iGKYVvO7PTyokxsDvyUo
        zxnQq/EOlncgG/E76oTfmdyIIxsDyg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-aD7cwlyLPyOlFwSi5199Rg-1; Sun, 03 Jan 2021 15:09:18 -0500
X-MC-Unique: aD7cwlyLPyOlFwSi5199Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3F010054FF;
        Sun,  3 Jan 2021 20:09:15 +0000 (UTC)
Received: from mail (ovpn-112-221.rdu2.redhat.com [10.10.112.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 393AC6F43C;
        Sun,  3 Jan 2021 20:09:15 +0000 (UTC)
Date:   Sun, 3 Jan 2021 15:09:14 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
Message-ID: <X/Ikalm2CLln2alz@redhat.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
 <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
 <20210103134753.GC832698@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103134753.GC832698@linux.ibm.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Sun, Jan 03, 2021 at 03:47:53PM +0200, Mike Rapoport wrote:
> Thanks for the logs, it seems that implicitly adding reserved regions to
> memblock.memory wasn't that bright idea :)

Would it be possible to somehow clean up the hack then?

The only difference between the clean solution and the hack is that
the hack intended to achieved the exact same, but without adding the
reserved regions to memblock.memory.

The comment on that problematic area says the reserved area cannot be
used for DMA because of some unexplained hw issue, and that doing so
prevents booting, but since the area got reserved, even with the clean
solution, it shouldn't have never been used for DMA?

So I can only imagine that the physical memory region is way more
problematic than just for DMA. It sounds like that anything that
touches it, including the CPU, will hang the system, not just DMA. It
sounds somewhat similar to the other e820 direct mapping issue on x86?

If you want to test the hack on the arm board to check if it boots you
can use the below commit:

https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=c3ea2633015104ce0df33dcddbc36f57de1392bc

Thanks,
Andrea

