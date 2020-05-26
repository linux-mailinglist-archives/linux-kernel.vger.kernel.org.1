Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6421A70B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 03:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403886AbgDNB4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 21:56:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42026 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgDNB40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:56:26 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03E1uGjY031358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 21:56:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C2CF42013D; Mon, 13 Apr 2020 21:56:16 -0400 (EDT)
Date:   Mon, 13 Apr 2020 21:56:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: remove set but not used variable 'es' in
 ext4_jbd2.c
Message-ID: <20200414015616.GC90651@mit.edu>
References: <20200402034759.29957-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402034759.29957-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:47:59AM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> fs/ext4/ext4_jbd2.c:341:30: warning: variable 'es' set but not used [-Wunused-but-set-variable]
>      struct ext4_super_block *es;
>                               ^~
> 
> Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thanks.

					- Ted
