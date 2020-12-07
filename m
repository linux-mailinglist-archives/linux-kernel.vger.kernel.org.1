Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325702D145C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLGPFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:05:14 -0500
Subject: Re: [PATCH 1/2] f2fs: convert to F2FS_*_INO macro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607353474;
        bh=+m4VjiTjGFNz/muvZcdSPiu21+zcpdowj4/SxbH6yow=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=CTWxiZRRSGXZ8oY4RJbseR5Ci6mHqzSqqjTYcvm0e8o9z0ogrrfkxS55oBR+MXFik
         VvECt4yfIRr8d3hMftu+DRG6NC8gqvJEc5MkOaMtMz4cKBgME8P2El1HAuKnG3JZyZ
         u+uw3n4UQwyPGZHLKajuY4+nDWdS0v4KHouAfONeLyPhOUzjPcoFk2ayReEbdzibJs
         vUkDzwSi1qe4iv4BKoKatN/Edh1NEh3OuEO/Qs9rkv82ksQKhJbYofvjKdwPYPeRdZ
         B6CiBj/qAQvK8DOeqWcfGVSHK7jkunhSgQQPIT4NlyR5DM7eV7NiwqusdFIsFtevsG
         CG341T8tOPrAQ==
To:     liush <liush@allwinnertech.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
References: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b78048de-f69a-79fd-1512-cf55321dbb3a@kernel.org>
Date:   Mon, 7 Dec 2020 23:04:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/7 18:59, liush wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> Use F2FS_ROOT_INO, F2FS_NODE_INO and F2FS_META_INO macro
> for better code readability.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Shaohua Liu <liush@allwinnertech.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
