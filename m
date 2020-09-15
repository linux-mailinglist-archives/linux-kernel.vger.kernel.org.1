Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B53826B77E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIPAYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgIOOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600179553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3aUX7mu7tx6gj7x1oFhz0vW3IscnXgty1qPqJGepZ4=;
        b=g3ys2ycLPN16rSWrkmHvDOK7w5072vXPd9YWgjHjbGdQa52McJ8nWDXCdWoqTcEz/L/h58
        mz8nMaLFdj3nQZW68VxUGoO9UsaAjbRorzOlfzXEOaYq4UT2LJPhwnajZ1AVX8o+/AtJRZ
        hjXIlNvYJxcUHYwXkBUfwY9cScvn988=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-YGq3duzSPTOF0IWEcsmPZA-1; Tue, 15 Sep 2020 10:17:06 -0400
X-MC-Unique: YGq3duzSPTOF0IWEcsmPZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75D381F026;
        Tue, 15 Sep 2020 14:17:04 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E252960FC2;
        Tue, 15 Sep 2020 14:17:03 +0000 (UTC)
Date:   Tue, 15 Sep 2020 09:17:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Wielaard <mark@klomp.org>
Cc:     peterz@infradead.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: Static call dependency on libelf version?
Message-ID: <20200915141701.j5fnir63trpwqbfp@treble>
References: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
 <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
 <d02d57308d9e8febd569c3fd3757dbcc87b1c4a1.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d02d57308d9e8febd569c3fd3757dbcc87b1c4a1.camel@klomp.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:24:17PM +0200, Mark Wielaard wrote:
> But all this is for ancient versions of elfutils libelf. So it is hard
> to say and my memory might be failing. If someone can confirm 0.158
> (which is 6 years old) works fine I would pick that as minimum version,
> otherwise simply go with 0.168 which is 4 years old and should be on
> most systems by now.

I just discovered elf_version(), I assume that would allow us to check
and enforce the libelf version?

-- 
Josh

