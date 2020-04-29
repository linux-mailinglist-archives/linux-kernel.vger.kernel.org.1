Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594F1BE72D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2TSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 15:18:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588187934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAFqraNL8dJycHk2mGkCWlX958X1+RajYbOcHwPDmYM=;
        b=GiFik/M4bFd56I7lnJFYdQPamV2jN1E5+aICnaaJIUnQ+SdEGqvAVd8gi+dFcUVznZNfUk
        MhadJki64c3EgsI8W9RxVnZrUIKDfgPLP0gdgsJRrLv0gDgMON2iT4EY4y4+d5RIe5m00m
        7pICYr8R2e/xFVpVf6swMvGzZoEZduc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-o0pIw3qCOH6SZ39yTbIxlQ-1; Wed, 29 Apr 2020 15:18:50 -0400
X-MC-Unique: o0pIw3qCOH6SZ39yTbIxlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA5A45F;
        Wed, 29 Apr 2020 19:18:48 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3043810013BD;
        Wed, 29 Apr 2020 19:18:48 +0000 (UTC)
Date:   Wed, 29 Apr 2020 14:18:46 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200429191846.hcfc7t4zusdudtej@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428161044.caamvx67t2z4t6vd@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > ==> build/x86/0x2EA4CE4F_defconfig/log <==
> > kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled
> > kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: Add check_kcov_mode() to the uaccess safelist

check_kcov_mode() is called by write_comp_data() and
__sanitizer_cov_trace_pc(), which are already on the uaccess safe list.
Might as well add check_kcov_mode() to the party.

This fixes the following warnings:

  kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled
  kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0c732d586924..fec890547e04 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -516,6 +516,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write16",
 	/* KCOV */
 	"write_comp_data",
+	"check_kcov_mode",
 	"__sanitizer_cov_trace_pc",
 	"__sanitizer_cov_trace_const_cmp1",
 	"__sanitizer_cov_trace_const_cmp2",
-- 
2.21.1

