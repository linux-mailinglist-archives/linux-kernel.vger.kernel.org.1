Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6131ECAAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgFCHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 03:38:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44521 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgFCHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:38:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U-RVoRv_1591169866;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U-RVoRv_1591169866)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Jun 2020 15:37:47 +0800
Subject: Re: [PATCH] doc: zh_CN: use doc reference to resolve undefined label
 warning
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Harry Wei <harryxiyou@gmail.com>, Wang Wenhu <wenhu.wang@vivo.com>,
        Chucheng Luo <luochucheng@vivo.com>,
        linux-kernel@vger.kernel.org
References: <20200531183556.5751-1-lukas.bulwahn@gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <67729261-8deb-c1f4-979c-762786ab1954@linux.alibaba.com>
Date:   Wed, 3 Jun 2020 15:36:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200531183556.5751-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/6/1 ����2:35, Lukas Bulwahn д��:
> Documentation generation warns:
> 
>   Documentation/translations/zh_CN/filesystems/debugfs.rst:5:
>   WARNING: undefined label: debugfs_index

It's due to debugfs.txt changed to debugfs.rst.

> 
> Use doc reference for files rather than introducing a label to refer to.
> This resolves the warning above.

Anyway this fix is also fine for me.

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please pick this quick warning fix.
> 
> applies on your doc-next and next-20200529
> 
>  Documentation/translations/zh_CN/filesystems/debugfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> index f8a28793c277..822c4d42fdf9 100644
> --- a/Documentation/translations/zh_CN/filesystems/debugfs.rst
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -2,7 +2,7 @@
>  
>  .. include:: ../disclaimer-zh_CN.rst
>  
> -:Original: :ref:`Documentation/filesystems/debugfs.txt <debugfs_index>`
> +:Original: :doc:`../../../filesystems/debugfs`
>  
>  =======
>  Debugfs
> 
