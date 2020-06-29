Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6E20D0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgF2Sgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:36:54 -0400
Received: from gentwo.org ([3.19.106.255]:55684 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgF2Sgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:52 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 2B0E33FF4E; Mon, 29 Jun 2020 14:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 291103EA72;
        Mon, 29 Jun 2020 14:58:40 +0000 (UTC)
Date:   Mon, 29 Jun 2020 14:58:40 +0000 (UTC)
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
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
In-Reply-To: <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.22.394.2006291456550.27163@www.lameter.com>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com> <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Srikar Dronamraju wrote:

> Currently Linux kernel with CONFIG_NUMA on a system with multiple
> possible nodes, marks node 0 as online at boot.  However in practice,
> there are systems which have node 0 as memoryless and cpuless.

Maybe add something to explain why you are not simply mapping the
existing memory to NUMA node 0 which is after all just a numbering scheme
used by the kernel and can be used arbitrarily?

This could be seen more as a bug in the arch code during the setup of NUMA
nodes. The two nodes are created by the firmwware / bootstrap code after
all. Just do not do it?

