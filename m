Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947342F77CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbhAOLke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:40:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbhAOLke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:40:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE253ACB0;
        Fri, 15 Jan 2021 11:39:52 +0000 (UTC)
Date:   Fri, 15 Jan 2021 12:39:52 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
In-Reply-To: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2101151239330.4375@pobox.suse.cz>
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Josh Poimboeuf wrote:

> This is basically a revert of commit 644592d32837 ("objtool: Fail the
> kernel build on fatal errors").
> 
> That change turned out to be more trouble than it's worth.  Failing the
> build is an extreme measure which sometimes gets too much attention and
> blocks CI build testing.
> 
> These fatal-type warnings aren't yet as rare as we'd hope, due to the
> ever-increasing matrix of supported toolchains/plugins and their
> fast-changing nature as of late.
> 
> Also, there are more people (and bots) looking for objtool warnings than
> ever before, so such warnings not likely to be ignored for long.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
