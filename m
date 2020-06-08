Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79A1F1121
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFHBo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 21:44:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34393 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgFHBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:44:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U-rhyTp_1591580664;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0U-rhyTp_1591580664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Jun 2020 09:44:25 +0800
Subject: Re: [PATCH v2] fs: ocfs2: fix spelling mistake and grammar
To:     Keyur Patel <iamkeyur96@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20200607212115.99278-1-iamkeyur96@gmail.com>
 <20200607220716.101243-1-iamkeyur96@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <6b909e4c-3f33-2795-6045-991b09ced525@linux.alibaba.com>
Date:   Mon, 8 Jun 2020 09:44:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607220716.101243-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/8 06:07, Keyur Patel wrote:
> ./ocfs2/mmap.c:65: bebongs ==> belongs
> 
This should be updated with your new change.

Thanks,
Joseph

> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> ---
>  fs/ocfs2/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
> index 3a44e461828a..39a77e903fdf 100644
> --- a/fs/ocfs2/mmap.c
> +++ b/fs/ocfs2/mmap.c
> @@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
>  	last_index = (size - 1) >> PAGE_SHIFT;
>  
>  	/*
> -	 * There are cases that lead to the page no longer bebongs to the
> +	 * There are cases that lead to the page no longer belonging to the
>  	 * mapping.
>  	 * 1) pagecache truncates locally due to memory pressure.
>  	 * 2) pagecache truncates when another is taking EX lock against 
> 
