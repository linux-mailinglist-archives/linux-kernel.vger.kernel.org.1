Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE471A7E97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbgDNNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 09:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbgDNNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:41:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764172075E;
        Tue, 14 Apr 2020 13:41:23 +0000 (UTC)
Date:   Tue, 14 Apr 2020 09:41:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for
 all architectures
Message-ID: <20200414094121.73f5c82a@gandalf.local.home>
In-Reply-To: <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
        <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
        <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 08:39:23 +0100
Julien Thierry <jthierry@redhat.com> wrote:

> My concern with this it that most of the structures and code in arch.h 
> and check.c can/should be reused across architectures. So, when 
> providing support for a new architecutre, the first thing that will be 
> needed is to move those back under tools/objtool whithout disturbing the 
> arches that don't yet provide support for "check" subcommand.

Are all the enums and structs in arch.h non-arch specific?

Or would they need to be split?

> 
> So, if it is decided that recordmcount should be an objtool subcommand, 
> the code itself should probably stay under tools/objtool and then have 
> different compilation configurations for objtool depending on the 
> architecture (e.g. HAVE_OBJTOOL_CHECK, HAVE_OBJTOOL_ORC) or something of 
> the sort.

That could work.

-- Steve
