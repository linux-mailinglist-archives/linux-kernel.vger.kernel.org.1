Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71B8304DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbhAZXZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:25:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbhAZGAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:00:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3920AF52;
        Tue, 26 Jan 2021 05:59:55 +0000 (UTC)
Date:   Mon, 25 Jan 2021 21:59:49 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 5/7] rbtree, uprobes: Use rbtree helpers
Message-ID: <20210126055949.wriil3xj7wx5peed@offworld>
References: <20210125150953.679129361@infradead.org>
 <20210125151314.888570583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210125151314.888570583@infradead.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Peter Zijlstra wrote:

>Reduce rbtree boilerplate by using the new helpers.

This reminds me of:

https://lore.kernel.org/lkml/20200207180305.11092-6-dave@stgolabs.net/

Would a walk optimization (list+rbtree) serve here? Not sure how big
the uprobes_trees gets.

Thanks,
Davidlohr
