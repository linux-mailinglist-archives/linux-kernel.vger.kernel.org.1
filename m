Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C52E96EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhADOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhADOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:12:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF871C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a4nIuOPB7NGZ8PdC9/3vOs28zwMGea0v4ptxyiU4XUk=; b=JvBOTXsKEet40RlLCqk0Dc8kgX
        ozYvYdLqZof0hpKyyrYcTRocsOd+Y2Lzs8l2xMrrErXIybL7aVUu1C7RmJQEO37SBDyYbFULcf3yp
        aj7PGM1hnAzOx16RtPw47PAp01p5i+03GnvxPc15afuuAu1HcrspRVBLyuMrWpvOamrKCoDSCsUea
        TYz7qXg1E9gJo06MaKwCdVuayJP8z3AZMnlQdhmYLg/hdBzddGm+FrhSkRn2BJYxTQMkdKym8PonT
        fOj+9vFrulHq8RF3uN7deLHBxiRNE/9fJEK0YlbpQb5ONhBgqg0LF7roNm6x4itMwGa3UDOdsHnbl
        e7AvWcDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwQYV-000ARY-9e; Mon, 04 Jan 2021 14:10:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 053F8306E0D;
        Mon,  4 Jan 2021 15:09:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C30E8201B21B4; Mon,  4 Jan 2021 15:09:52 +0100 (CET)
Date:   Mon, 4 Jan 2021 15:09:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in alternatives
Message-ID: <20210104140952.GQ3021@hirez.programming.kicks-ass.net>
References: <cover.1608700338.git.jpoimboe@redhat.com>
 <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:18:10PM -0600, Josh Poimboeuf wrote:

> For example, this scenario is allowed:
> 
>           Alt1                    Alt2                    Alt3
> 
>    0x00   CALL *pv_ops.save_fl    CALL xen_save_fl        PUSHF
>    0x01                                                   POP %RAX
>    0x02                                                   NOP
>    ...
>    0x05                           NOP
>    ...
>    0x07   <insn>
> 

> This scenario is NOT allowed:
> 
>           Alt1                    Alt2
> 
>    0x00   CALL *pv_ops.save_fl    PUSHF
>    0x01                           NOP6
>    ...
>    0x07   NOP                     POP %RAX
> 

> The problem here is that offset-0x7, which is an instruction boundary in
> both possible instruction patch streams, has two conflicting stack
> layouts.

There's another fun scenario:

  0x00	CALL *pv_ops.save_fl		PUSHF
  0x01					NOP2
  ..
  0x03					NOP5
  ..
  0x07	NOP2
  0x08					POP %RAX
  0x09	<insn>

No conflicting boundary at 0x07, but still buggered.

Let me go read the actual patch to see if this is handled.
