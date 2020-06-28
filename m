Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB620C933
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgF1RSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 13:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgF1RSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:18:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8938CAE96;
        Sun, 28 Jun 2020 17:18:23 +0000 (UTC)
Date:   Sun, 28 Jun 2020 19:18:16 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/entry for 5.8
Message-ID: <20200628171816.GF18884@zn.tnic>
References: <20200628140523.GA18884@zn.tnic>
 <CAHk-=wiu9wquJ1LO53sA7=9ZCmQkRpu1-hZwwopeu8OVzt4qsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiu9wquJ1LO53sA7=9ZCmQkRpu1-hZwwopeu8OVzt4qsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 09:57:00AM -0700, Linus Torvalds wrote:
> Tssk. This has an unnecessary merge "to resolve conflicts". I'd much
> rather have seen the pull without that.

Yeah, reportedly because "Linus renamed probe_kernel_read() and [peterz]
removed a call". I guess they did that for linux-next's sake.

> Oh well. Pulled.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
