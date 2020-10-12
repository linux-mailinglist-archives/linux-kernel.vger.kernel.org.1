Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC88328BB09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgJLOqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388646AbgJLOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:46:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EEF20776;
        Mon, 12 Oct 2020 14:46:15 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:46:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace
 events
Message-ID: <20201012104614.25ea97bc@gandalf.local.home>
In-Reply-To: <43b10ad23a80ee5ae9f10b6d47d7944b6b14a25d.camel@kernel.org>
References: <20201009220524.485102-1-axelrasmussen@google.com>
        <20201009220524.485102-2-axelrasmussen@google.com>
        <20201012101527.6df53dda@gandalf.local.home>
        <43b10ad23a80ee5ae9f10b6d47d7944b6b14a25d.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 09:26:13 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> Looks ok to me.
> 
> Acked-by: Tom Zanussi <zanussi@kernel.org>

Great!

I'll pull this patch into my tree. It doesn't look like patch 2/2 is
dependent on this and these two can go through different trees.

Is everyone OK if I take this patch through my tree?

-- Steve
