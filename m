Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EDD1B7E96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgDXTJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:09:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42856 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgDXTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587755355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFFBEe1utqpGYAUFTLzFKc0LiqSB4f6/KeXu27tu+yY=;
        b=CUYxa2bEoHsvOWG/u/t61/2g3xpyAvgZbV9+l//GUBniiJgvNFQDzstPELU7sQzP7+6hqH
        LwZA8QPdtDAddL8Kgxb3xiuBPZmtBiMDGLNn4rEeuMoP1k9F6Yw/A34rwWq6jnyDen7nXP
        cseNzdurtA9kxiEHawS7h6YuC+dKWL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-0yGuAuCmMN2Y6AD-qTahsA-1; Fri, 24 Apr 2020 15:09:12 -0400
X-MC-Unique: 0yGuAuCmMN2Y6AD-qTahsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE26107ACF4;
        Fri, 24 Apr 2020 19:09:10 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A706960F8D;
        Fri, 24 Apr 2020 19:09:09 +0000 (UTC)
Date:   Fri, 24 Apr 2020 14:09:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz, arnd@arndb.de
Subject: Re: [PATCH 6/8] x86: Simplify retpoline declaration
Message-ID: <20200424190907.dywoslazrohhtago@treble>
References: <20200423125013.452964352@infradead.org>
 <20200423125042.958927629@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423125042.958927629@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:47:23PM +0200, Peter Zijlstra wrote:
> +#undef GEN
> +#define GEN(reg) EXPORT_THUNK(reg)
> +#include <asm/GEN-for-each-reg.h>
> +

Applying: x86: Simplify retpoline declaration
.git/rebase-apply/patch:112: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

-- 
Josh

