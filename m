Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5E2F6BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbhANUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbhANUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610654654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDR14ZiQqTrxv/DbP+NPRDh8rnGuiz+pSmsIiv38XS0=;
        b=dyb9J1dkG8Np7YkPXHZ7rEkKSAJgp5h4S7QToQeGidaYI1TQ8pVZrpT+SNnMNgiwelh5mf
        x+kfFFdPQcjWXhthf3URuxdtUYjsJNDVMvY02Ev0oPD8KO9JuoqUPNEzTxxq40L+14kIU3
        U6rWZYZ7inFbWfCslP/h2oOKMEhdFFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-LHANGFXOOSWbxozGdAEloA-1; Thu, 14 Jan 2021 15:04:10 -0500
X-MC-Unique: LHANGFXOOSWbxozGdAEloA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53BAC107ACFB;
        Thu, 14 Jan 2021 20:04:08 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7785D9EF;
        Thu, 14 Jan 2021 20:04:06 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:04:01 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 01/21] objtool: Fix seg fault in BT_FUNC() with fake jump
Message-ID: <20210114200401.bzxtvmpxrhr4ioy4@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <c6bd154e55739c332c21ca4a91a66787cc3e104c.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6bd154e55739c332c21ca4a91a66787cc3e104c.1610652862.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 01:39:57PM -0600, Josh Poimboeuf wrote:
> Objtool appends a temporary fake jump at the end of alternative
> replacement instructions.  If the replacement code is empty -- resulting
> in patched nops -- the fake jump doesn't have a section.  When running
> objtool with '--backtrace', the fake jump's missing section can cause
> BT_FUNC() to trigger a seg fault when the NULL insn->sec is passed to
> offstr().
> 
> Fix it by ensuring fake jumps always have a section.
> 
> Fixes: 7697eee3ddd7 ("objtool: Add --backtrace support")
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

This patch will probably end up getting dropped because fake jumps are
going away \o/

-- 
Josh

