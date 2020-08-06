Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C153D23DBB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHFQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 12:29:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40183 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727933AbgHFQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:28:47 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 076Ex240009804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 10:59:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 858C1420263; Thu,  6 Aug 2020 10:59:02 -0400 (EDT)
Date:   Thu, 6 Aug 2020 10:59:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext4: delete the invalid BUGON in ext4_mb_load_buddy_gfp()
Message-ID: <20200806145902.GQ7657@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad68e8a2-5ec3-5beb-537f-f3e53f55367a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:54:14AM +0800, brookxu wrote:
> Delete the invalid BUGON in ext4_mb_load_buddy_gfp(), the previous
> code has already judged whether page is NULL.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Applied, but I had to manually apply your patch since it was mangled
by your mailer.

It looks like the problem may have been caused by your using gmail;
please take a look at the file Documentation/process/email-clients.rst for some hints.

							- Ted
