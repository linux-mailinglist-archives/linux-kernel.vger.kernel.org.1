Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4124F1B33A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 19:52:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725850AbgDUXwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587513158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7qRnFwMY1veO8968/GmG7PEXtDC2w7mYSghI/mbNIs=;
        b=KGrFsSwmvugibb3B/w4PYVxP+Jw/s960W7hb0RwWFBtayeUlecMKbSJI6PeSOHRcl69sIj
        QrS3w2DqbsXbS8rlu2Zt71x4zNg+TQeE3nQcWkmP1/gKMStcG9NzQkWAb+Wv5kLPZRJXYu
        pjS/KHQHIF9p8H0uH98jEBEVaaTWKZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-fikglMOdOUW3iOE1C4CK7Q-1; Tue, 21 Apr 2020 19:52:36 -0400
X-MC-Unique: fikglMOdOUW3iOE1C4CK7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DFE0107ACC7;
        Tue, 21 Apr 2020 23:52:35 +0000 (UTC)
Received: from treble (ovpn-114-228.rdu2.redhat.com [10.10.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB0719C70;
        Tue, 21 Apr 2020 23:52:33 +0000 (UTC)
Date:   Tue, 21 Apr 2020 18:52:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] objtool: add support for >64k sections
Message-ID: <20200421235231.citpfigkpahztorj@treble>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421220843.188260-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421220843.188260-1-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:08:41PM -0700, Sami Tolvanen wrote:
> This series fixes objtool for binaries with >64k sections, and
> includes optimizations to reduce the runtime for a binary with
> ~130k sections from >15 minutes to ~4 seconds.
> 
> Changes in v2:
>  - Dropped the insn_hash optimization as Peter has a nearly
>    similar change queued already.
>  - Instead of storing the last instruction for each section,
>    use find_insn to locate it.
> 
> 
> Sami Tolvanen (2):
>   objtool: use gelf_getsymshndx to handle >64k sections
>   objtool: optimize add_dead_ends for split sections
> 
>  tools/objtool/check.c | 36 +++++++++++++++++-------------------
>  tools/objtool/elf.c   | 24 +++++++++++++++++-------
>  2 files changed, 34 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 18bf34080c4c3beb6699181986cc97dd712498fe

Looks good to me, thanks.  I'll add them to the queue for testing, along
with that other patch.

-- 
Josh

