Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CE2D21F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgLHETN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:19:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgLHETN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:19:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 326C2AC9A;
        Tue,  8 Dec 2020 04:18:32 +0000 (UTC)
Date:   Mon, 7 Dec 2020 19:53:14 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 3/5] locking/rwsem: Enable reader optimistic lock stealing
Message-ID: <20201208035314.rwz72kgn5apr2whm@linux-p48b>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-4-longman@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Waiman Long wrote:

>If the optimistic spinning queue is empty and the rwsem does not have
>the handoff or write-lock bits set, it is actually not necessary to
>call rwsem_optimistic_spin() to spin on it. Instead, it can steal the
>lock directly as its reader bias is in the count already.  If it is
>the first reader in this state, it will try to wake up other readers
>in the wait queue.
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
