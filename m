Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21A19D2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbgDCJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 05:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgDCJAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:00:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FAA1B001;
        Fri,  3 Apr 2020 09:00:17 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:00:17 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 0/5] objtool fixes
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2004031059540.25955@pobox.suse.cz>
References: <cover.1585761021.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Josh Poimboeuf wrote:

> Some objtool fixes related to CONFIG_UBSAN_TRAP, Clang assembler, and
> more...
> 
> Josh Poimboeuf (5):
>   objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
>   objtool: Support Clang non-section symbols in ORC dump
>   objtool: Support Clang non-section symbols in ORC generation
>   objtool: Fix switch table detection in .text.unlikely
>   objtool: Make BP scratch register warning more robust
> 
>  tools/objtool/check.c    | 26 ++++++++++++++++--------
>  tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
>  tools/objtool/orc_gen.c  | 33 +++++++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 32 deletions(-)

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
