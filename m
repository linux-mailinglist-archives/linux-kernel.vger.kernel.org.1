Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96970279A24
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgIZOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 10:38:46 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49808 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgIZOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:38:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UA8Bci-_1601131093;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UA8Bci-_1601131093)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 26 Sep 2020 22:38:14 +0800
Subject: Re: [PATCH] Documentation: Chinese translation of
 Documentation/arm64/perf.rst
To:     Bailu Lin <bailu.lin@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200926102242.3652-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <747aff97-8b24-5ac2-e46a-fe34b398deb6@linux.alibaba.com>
Date:   Sat, 26 Sep 2020 22:35:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200926102242.3652-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why your patch repeatly has encoding issue which fails on 'git am'
Could you like to check the problem before send out?
Could you please fix your editor issue by Documentation/process/email-clients.rst
or send patch by git send-email.

And please don't waste other time on meaningless issue again!

Thanks
Alex

在 2020/9/26 下午6:22, Bailu Lin 写道:
> This is a Chinese translated version of Documentation/arm64/perf.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
>  Documentation/arm64/perf.rst                  |  2 +
>  .../translations/zh_CN/arm64/index.rst        |  1 +
>  .../translations/zh_CN/arm64/perf.rst         | 85 +++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/perf.rst
> 
> diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
> index 9c76a97baf28..b567f177d385 100644
> --- a/Documentation/arm64/perf.rst
> +++ b/Documentation/arm64/perf.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. _perf_index:
> +
>  =====================
>  Perf Event Attributes
>  =====================
> diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
> index e31a6090384d..f51fed166326 100644
> --- a/Documentation/translations/zh_CN/arm64/index.rst
> +++ b/Documentation/translations/zh_CN/arm64/index.rst
> @@ -15,3 +15,4 @@ ARM64 架构
>  
>      amu
>      hugetlbpage
> +    perf
> diff --git a/Documentation/translations/zh_CN/arm64/perf.rst b/Documentation/translations/zh_CN/arm64/perf.rst
> new file mode 100644
> index 000000000000..ffa0b8ec801d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arm64/perf.rst
> @@ -0,0 +1,85 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/arm64/perf.rst <perf_index>`
> +
> +Translator: Bailu Lin <bailu.lin@vivo.com>
> +
> +============
> +Perf 事件属性
> +============
> +
> +:作者: Andrew Murray <andrew.murray@arm.com>
> +:日期: 2019-03-06
> +
> +exclude_user
> +------------
> +
> +该属性不包括用户空间。
> +
> +用户空间始终在 EL0 上运行，因此该属性将排除 EL0。
> +
> +
> +exclude_kernel
> +--------------
> +
> +该属性不包括内核空间。
> +
> +打开VHE时内核运行在 EL2，不打开时运行在 EL1。客户端的内核总是运行
> +在 EL1。
> +
> +对于主机端，该属性不包括 EL1 和 VHE 上的 EL2。
> +
> +对于客户端，该属性不包括 EL1。请注意 EL2 从来不算是客户端。
> +
> +
> +exclude_hv
> +----------
> +
> +该属性不包括系统管理程序。
> +
> +对于 VHE 主机该属性将被忽略，因为我们认为主机端内核是系统管理程序。
> +
> +对于 non-VHE 的主机端该属性将排除 EL2，因为我们认为系统管理程序运
> +行在 EL2 的任何代码主要用于客户端和主机端的切换。
> +
> +对于客户端该属性无效。请注意 EL2 从来不算是客户端。
> +
> +
> +exclude_host / exclude_guest
> +----------------------------
> +
> +这些属性分别排除了 KVM 主机端和客户端。
> +
> +KVM 主机端可能运行在 EL0（用户空间），EL1（non-VHE 内核）和
> +EL2（VHE 内核 或 non-VHE 系统管理程序）。
> +
> +KVM 客户端可能运行在 EL0（用户空间）和 EL1（内核）。
> +
> +由于主机端和客户端之间重叠的异常级别，我们不能仅仅依靠 PMU 的硬件异
> +常过滤-因此我们必须启用/禁用对于客户端进入和退出的计数。这在 VHE 和
> +non-VHE 系统上表现不同。
> +
> +对于 non-VHE 系统，我们排除 EL2 的 exclude_host 属性 -  在进入和退
> +出客户端时，我们会根据 exclude_host 和 exclude_guest属性在适当的情
> +况下禁用/启用该事件。
> +
> +对于 VHE 系统，我们排除 EL1 的 exclude_guest 属性和 EL0，EL2的两者
> +的 exclude_host 属性。在进入和退出客户端时，我们会适当地根据包括/排
> +除 EL0 的 exclude_host 和 exclude_guest 属性修改事件。
> +
> +以上声明也适用于在 not-VHE 客户端使用这些属性时。但是请注意，EL2
> +从来不算客户端。
> +
> +
> +准确性
> +------
> +
> +在 non-VHE 主机端上，我们在 EL2 进入/退出主机端/客户端切换时启用/关闭
> +计数器 -但是在启用/禁用计数器和进入/退出客户端之间存在一段时间。对于
> +exclude_host 当统计客户端事件通过过滤 EL2，我们能够消除客户端进入/退出
> +边界上的计数主机端事件的计数。但是当使用 !exclude_hv 时，在客户端进入/
> +退出有一个小的暗窗口，无法捕获主机的事件。
> +
> +在VHE系统尚没有暗窗口。
> 
