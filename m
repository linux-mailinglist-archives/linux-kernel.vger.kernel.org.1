Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7212A2D95
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKBPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:04:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgKBPEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:04:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F9C8AC53;
        Mon,  2 Nov 2020 15:04:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D6DE01E12FB; Mon,  2 Nov 2020 16:04:39 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:04:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     1 <liuyingbiao1005@126.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, jack <jack@suse.com>
Subject: Re: fix fs/quota/dquot.c oops error
Message-ID: <20201102150439.GC23988@quack2.suse.cz>
References: <2a05b12f.5374.175881b20f4.Coremail.liuyingbiao1005@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a05b12f.5374.175881b20f4.Coremail.liuyingbiao1005@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-11-20 16:38:00, 1 wrote:
>    An oops error will appear if you follow the steps below:
>    1.gcc -o test test.c
>    2.sudo ./test
> 
> 
>    The error can be found in the dmesg file , in the function of
>    "dquot_add_space".  Because a pointer named "dquot" is illegal , so it
>    need to use functions to detect the pointer.  Through the test, it is
>    found that this function named "access_ok" meets the requirements.

Thanks for the patch but it is not correct.  A proper fix for this syzbot
reproducer is to add more sanity checking into quota code to verify quota
file headers are not corrupted. Because these corrupted headers cause bogus
return values from get_free_blk() and possibly other quota functions which
then confuse __dquot_initialize().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
