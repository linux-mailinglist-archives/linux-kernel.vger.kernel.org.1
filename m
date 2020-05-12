Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4A1CFABB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgELQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:31:30 -0400
Received: from gentwo.org ([3.19.106.255]:33778 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgELQb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:31:27 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id F169B3F3DB; Tue, 12 May 2020 16:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id F044B3EBBA;
        Tue, 12 May 2020 16:31:26 +0000 (UTC)
Date:   Tue, 12 May 2020 16:31:26 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
In-Reply-To: <20200512132937.19295-4-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.22.394.2005121627340.98180@www.lameter.com>
References: <20200512132937.19295-1-srikar@linux.vnet.ibm.com> <20200512132937.19295-4-srikar@linux.vnet.ibm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Srikar Dronamraju wrote:

> +#ifdef CONFIG_NUMA
> +	[N_ONLINE] = NODE_MASK_NONE,

Again. Same issue as before. If you do this then you do a global change
for all architectures. You need to put something in the early boot
sequence (in a non architecture specific way) that sets the first node
online by default.

You have fixed the issue in your earlier patches for the powerpc
archicture. What about the other architectures?

Or did I miss something?

