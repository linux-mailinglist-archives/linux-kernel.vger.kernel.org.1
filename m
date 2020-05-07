Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42F1C9743
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEGRQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgEGRQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5FC30E;
        Thu,  7 May 2020 10:16:11 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E833F305;
        Thu,  7 May 2020 10:16:10 -0700 (PDT)
Date:   Thu, 7 May 2020 18:16:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200507171607.GD3180@gaia>
References: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:22:37PM -0400, Qian Cai wrote:
> What do you think about adding some aux call traces for kmemleak in
> general? For example, if the tracking object is a task struct, it
> would save call traces for the first and last call of both
> get_task_struct() and put_task_struct(). Then, it could be expanded to
> track other refcount-based leaks in the future.

I don't mind adding additional tracking info if it helps with debugging.
But if it's for improving false positives, I'd prefer to look deeper
into figure out why the pointer reference graph tracking failed.

Thanks.

-- 
Catalin
