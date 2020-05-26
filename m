Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DB1A0E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgDGNfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 09:35:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728482AbgDGNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586266501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=weLtGLxAeonxQVsUB9CFhQsxbru7eAIWawxClgOm6Ds=;
        b=B5asYfJlxkBMGnU6yUUDLCmyvyFS/XdaCJHeb01SZUc8ZN/XaROlEAtCQQvATyAbfFmm4e
        6C6xsFyjN0TkckMUPNGq9fFNguDzWc0NWVfgDlUBhPSdQahj5pnAsQ8vx+6lNglBNFv3Tz
        DhCUr/4l5aZlQEAuambmOpF8lK5R6Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-oFAWhfcBNkKmopoVwtHOsg-1; Tue, 07 Apr 2020 09:34:58 -0400
X-MC-Unique: oFAWhfcBNkKmopoVwtHOsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C5185EE6A;
        Tue,  7 Apr 2020 13:34:57 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 507C65E000;
        Tue,  7 Apr 2020 13:34:56 +0000 (UTC)
Date:   Tue, 7 Apr 2020 08:34:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407133454.n55u5nx33ruj73gx@treble>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407132837.GA20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
> Josh, we should probably have objtool verify it doesn't emit ORC entries
> in alternative ranges.

Agreed, it might be as simple as checking for insn->alt_group in the
INSN_STACK check or in update_insn_state().

-- 
Josh

