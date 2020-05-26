Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7C1D5818
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgEORhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:37:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:53476 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgEORhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:37:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 613B1736;
        Fri, 15 May 2020 17:37:17 +0000 (UTC)
Date:   Fri, 15 May 2020 11:37:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH] Documentation: update numastat explanation
Message-ID: <20200515113716.29853dc8@lwn.net>
In-Reply-To: <20200507120217.12313-1-vbabka@suse.cz>
References: <20200507120217.12313-1-vbabka@suse.cz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 May 2020 14:02:17 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> During recent patch discussion [1] it became apparent that the "other_node"
> definition in the numastat documentation has always been different from actual
> implementation. It was also noted that the stats can be innacurate on systems
> with memoryless nodes.
> 
> This patch corrects the other_node definition (with minor tweaks to two more
> definitions), adds a note about memoryless nodes and also two introductory
> paragraphs to the numastat documentation.
> 
> [1] https://lore.kernel.org/linux-mm/20200504070304.127361-1-sandipan@linux.ibm.com/T/#u
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/admin-guide/numastat.rst | 31 +++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)

Applied, thanks.

jon
