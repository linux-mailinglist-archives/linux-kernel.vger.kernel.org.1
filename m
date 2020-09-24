Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1886E27744C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgIXOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:50:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48184 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727859AbgIXOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:50:11 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08OEnxrL014845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 10:49:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 41AF642003C; Thu, 24 Sep 2020 10:49:59 -0400 (EDT)
Date:   Thu, 24 Sep 2020 10:49:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        linux-kernel@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH] ext4: Implement swap_activate aops using iomap
Message-ID: <20200924144959.GE482521@mit.edu>
References: <20200904091653.1014334-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904091653.1014334-1-riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:46:53PM +0530, Ritesh Harjani wrote:
> After moving ext4's bmap to iomap interface, swapon functionality
> on files created using fallocate (which creates unwritten extents) are
> failing. This is since iomap_bmap interface returns 0 for unwritten
> extents and thus generic_swapfile_activate considers this as holes
> and hence bail out with below kernel msg :-
> 
> [340.915835] swapon: swapfile has holes
> 
> To fix this we need to implement ->swap_activate aops in ext4
> which will use ext4_iomap_report_ops. Since we only need to return
> the list of extents so ext4_iomap_report_ops should be enough.
> 
> Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
> Fixes: ac58e4fb03f ("ext4: move ext4 bmap to use iomap infrastructure")
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks, applied.

					- Ted
