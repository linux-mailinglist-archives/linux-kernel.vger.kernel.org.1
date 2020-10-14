Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107B28D79F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbgJNAnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:43:16 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47469 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727837AbgJNAnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:43:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UByP5eq_1602636191;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UByP5eq_1602636191)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Oct 2020 08:43:11 +0800
Subject: Re: [PATCH v2] Documentation: Chinese translation of
 Documentation/arm64/hugetlbpage.rst
To:     Bailu Lin <bailu.lin@vivo.com>, catalin.marinas@arm.com,
        corbet@lwn.net, harryxiyou@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org
Cc:     kernel@vivo.com
References: <20200926101902.3460-1-bailu.lin@vivo.com>
 <20201013123655.40631-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ab3df28a-cde4-67d1-d0a3-abaa5ada58a1@linux.alibaba.com>
Date:   Wed, 14 Oct 2020 08:42:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013123655.40631-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/10/13 下午8:36, Bailu Lin 写道:
> This is a Chinese translated version of
>  Documentation/arm64/hugetlbpage.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v2:
>  - Fix Sphinx 2.4.4's waring by increasing underline' size.
> ---
>  Documentation/arm64/hugetlbpage.rst           |  2 +
>  .../translations/zh_CN/arm64/hugetlbpage.rst  | 45 +++++++++++++++++++
>  .../translations/zh_CN/arm64/index.rst        |  1 +
>  3 files changed, 48 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/hugetlbpage.rst
> 
> diff --git a/Documentation/arm64/hugetlbpage.rst b/Documentation/arm64/hugetlbpage.rst
> index b44f939e5210..a110124c11e3 100644
> --- a/Documentation/arm64/hugetlbpage.rst
> +++ b/Documentation/arm64/hugetlbpage.rst
> @@ -1,3 +1,5 @@
> +.. _hugetlbpage_index:
> +
>  ====================
>  HugeTLBpage on ARM64
>  ====================
> diff --git a/Documentation/translations/zh_CN/arm64/hugetlbpage.rst b/Documentation/translations/zh_CN/arm64/hugetlbpage.rst
> new file mode 100644
> index 000000000000..dfc88195deb2
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arm64/hugetlbpage.rst
> @@ -0,0 +1,45 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/arm64/hugetlbpage.rst <hugetlbpage_index>`
> +
> +Translator: Bailu Lin <bailu.lin@vivo.com>
> +
> +=====================
> +ARM64中的 HugeTLBpage
> +=====================
> +
> +大页依靠有效利用 TLBs 来提高地址翻译的性能。这取决于以下
> +两点 -
> +
> +  - 大页的大小
> +  - TLBs 支持的条目大小
> +
> +ARM64 接口支持2种大页方式。
> +
> +1) pud/pmd 级别的块映射
> +-----------------------
> +
> +这是常规大页，他们的 pmd 或 pud 页面表条目指向一个内存块。
> +不管 TLB 中支持的条目大小如何，块映射可以减少翻译大页地址
> +所需遍历的页表深度。
> +
> +2) 使用连续位
> +-------------
> +
> +架构中转换页表条目(D4.5.3, ARM DDI 0487C.a)中提供一个连续
> +位告诉 MMU 这个条目是一个连续条目集的一员，它可以被缓存在单
> +个 TLB 条目中。
> +
> +在 Linux 中连续位用来增加 pmd 和 pte(最后一级)级别映射的大
> +小。受支持的连续页表条目数量因页面大小和页表级别而异。
> +
> +
> +支持以下大页大小配置 -

Is this better to s/大小/尺寸/ ？

for other part.

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

> +
> +  ====== ========   ====    ========    ===
> +  -      CONT PTE    PMD    CONT PMD    PUD
> +  ====== ========   ====    ========    ===
> +  4K:         64K     2M         32M     1G
> +  16K:         2M    32M          1G
> +  64K:         2M   512M         16G
> +  ====== ========   ====    ========    ===
> diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
> index 646ed1f7aea3..e31a6090384d 100644
> --- a/Documentation/translations/zh_CN/arm64/index.rst
> +++ b/Documentation/translations/zh_CN/arm64/index.rst
> @@ -14,3 +14,4 @@ ARM64 架构
>      :maxdepth: 2
>  
>      amu
> +    hugetlbpage
> 
