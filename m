Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A814278121
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgIYHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:07:26 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48267 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgIYHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:07:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UA0ImaR_1601017642;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UA0ImaR_1601017642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Sep 2020 15:07:22 +0800
Subject: Re: [PATCH V3] doc: zh_CN: add translatation for btrfs
To:     Wang Qing <wangqing@vivo.com>, Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1601016619-19352-1-git-send-email-wangqing@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0a5df537-9f74-f877-7775-df920097a819@linux.alibaba.com>
Date:   Fri, 25 Sep 2020 15:05:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1601016619-19352-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this file looks fine.

but we still need a link in index.rst to show page in web.

在 2020/9/25 下午2:49, Wang Qing 写道:
> Translate Documentation/filesystems/btrfs.rst into Chinese.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  .../translations/zh_CN/filesystems/btrfs.rst       | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/btrfs.rst
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/btrfs.rst b/Documentation/translations/zh_CN/filesystems/btrfs.rst
> new file mode 100644
> index 0000000..8b8cca2
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/btrfs.rst
> @@ -0,0 +1,37 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/ext3.rst <ext3_index>`
> +
> +translated by 王擎 Wang Qing<wangqing@vivo.com>
> +
> +=====
> +BTRFS
> +=====
> +
> +Btrfs是一个写时复制更新的文件系统，它注重容错、修复和易于管理。
> +Btrfs由多家公司联合开发，并获得GPL许可，免费开放给所有人。
> +
> +Btrfs的主要功能包括：
> +
> +    *扩展大小的文件存储（文件最大支持2^64）
> +    *填充方式使小文件更节省空间
> +    *索引目录的方式更节省空间
> +    *动态的索引节点分配方式
> +    *可写快照的特性
> +    *支持子卷（独立的内部根文件系统）
> +    *对象级别的镜像克隆
> +    *基于数据和元数据的校验和（支持多种算法）
> +    *支持压缩
> +    *內建多种磁盘阵列算法，支持多种设备
> +    *支持离线的文件系统检查
> +    *高效的增量备份和文件系统镜像
> +    *在线文件系统碎片整理
> +
> +更多有关信息，请参阅Wiki
> +
> +  https://btrfs.wiki.kernel.org
> +
> +维护信息包含管理任务、常见问题、用例、挂载选项、变更日志、
> +特性、手册、源码仓、联系人等。
> 
