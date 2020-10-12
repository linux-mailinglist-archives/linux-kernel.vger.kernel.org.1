Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17E28BBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgJLPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:22:44 -0400
Received: from gentwo.org ([3.19.106.255]:51300 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgJLPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:22:43 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id B7F1C3F19D; Mon, 12 Oct 2020 15:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id B590E3EC24;
        Mon, 12 Oct 2020 15:22:42 +0000 (UTC)
Date:   Mon, 12 Oct 2020 15:22:42 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Xianting Tian <tian.xianting@h3c.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH] mm: Make allocator take care of memoryless numa node
In-Reply-To: <20201012082739.15661-1-tian.xianting@h3c.com>
Message-ID: <alpine.DEB.2.22.394.2010121520440.154031@www.lameter.com>
References: <20201012082739.15661-1-tian.xianting@h3c.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020, Xianting Tian wrote:

> In architecture like powerpc, we can have cpus without any local memory
> attached to it. In such cases the node does not have real memory.
>
> In many places of current kernel code, it doesn't judge whether the node is
> memoryless numa node before calling allocator interface.

That is intentional. SLUB relies on the page allocator to pick a node.

> This patch is to use local_memory_node(), which is guaranteed to have
> memory, in allocator interface. local_memory_node() is a noop in other
> architectures that don't support memoryless nodes.

The patch would destroy the support for memory policies in the
SLUB allocator and likely in the other ones as well.

