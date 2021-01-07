Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB72ED0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbhAGNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:23:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:55904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbhAGNXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:23:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79E18B716;
        Thu,  7 Jan 2021 13:22:28 +0000 (UTC)
Date:   Thu, 7 Jan 2021 14:22:27 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in
 alternatives
In-Reply-To: <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2101071417440.31250@pobox.suse.cz>
References: <cover.1608700338.git.jpoimboe@redhat.com> <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020, Josh Poimboeuf wrote:

> BTW, another benefit of these changes is that, thanks to some related
> cleanups (new fake nops and alt_group struct) objtool can finally be rid
> of fake jumps, which were a constant source of headaches.

\o/

You may also want to remove/edit the comment right before 
handle_group_alt() now that fake jumps are gone.

Anyway, I walked through the patch (set) and I think it should work fine 
(but I am not confident enough to give it Reviewed-by. My head spins :)). 
I even like the change.

Also, 1/3 is a benefit on its own, so if nothing else, it could go in.

Regards
Miroslav
