Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9029E5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgJ2IHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:07:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42069 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgJ2IHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:07:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UDWlh5N_1603951038;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDWlh5N_1603951038)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 13:57:18 +0800
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
References: <20201028134831.79592-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <85fe8e8a-96f2-cd6a-a107-ebbfc50a46bf@linux.alibaba.com>
Date:   Thu, 29 Oct 2020 13:55:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028134831.79592-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/10/28 下午9:48, Bailu Lin 写道:
> This is a Chinese translated version of
>  Documentation/arm64/perf.rst
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
> index 000000000000..be8269dd5d9a
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
> +=============
> +Perf 事件属性
> +=============
> +
> +:作者: Andrew Murray <andrew.murray@arm.com>
> +:日期: 2019-03-06
> +
> +exclude_user
> +------------
> +
> +该属性排除用户空间。
> +
> +用户空间始终运行在 EL0，因此该属性将排除 EL0。
> +
> +
> +exclude_kernel
> +--------------
> +
> +该属性排除内核空间。
> +
> +打开 VHE 时内核运行在 EL2，不打开 VHE 时内核运行在 EL1。客户端

guest kernel could be better translated as '客户内核' ? 
'客户端' is easy to confuse with aonther word 'client'
So shall we better to use 客户， or 客户机 for 'guest/guest machine'

And 'host' here means 宿主/宿主机 better than 主机。 

Also couple wiki tranlates hypervisor as 虚拟机监视器

> +内核总是运行在 EL1。
> +
> +对于主机端，该属性排除 EL1 和 VHE 上的 EL2。
> +
> +对于客户端，该属性排除 EL1。请注意客户端从来不会运行在 EL2。
> +
> +
> +exclude_hv
> +----------
> +
> +该属性排除虚拟机监控器。
> +
> +对于 VHE 主机端该属性将被忽略，因为此时主机端内核是虚拟机监控器。

s/此时/我们认为/

> +
> +对于 non-VHE 主机端该属性将排除 EL2，因为虚拟机监控器运行在 EL2
> +的任何代码主要用于客户端和主机端的切换。
> +
> +对于客户端该属性无效。请注意客户端从来不会运行在 EL2。
> +
> +
> +exclude_host / exclude_guest
> +----------------------------
> +
> +这些属性分别排除了 KVM 主机端和客户端。
> +
> +KVM 主机端可能运行在 EL0（用户空间），EL1（non-VHE 内核）和
> +EL2（VHE 内核 或 non-VHE 虚拟机监控器）。
> +
> +KVM 客户端可能运行在 EL0（用户空间）和 EL1（内核）。
> +
> +由于主机端和客户端之间重叠的异常级别，我们不能仅仅依靠 PMU 的硬件异
> +常过滤机制-因此我们必须启用/禁用对于客户端进入和退出的计数。而这在
> +VHE 和 non-VHE 系统上表现不同。
> +
> +对于 non-VHE 系统的 exclude_host 属性排除 EL2 -  在进入和退出客户
> +端时，我们会根据 exclude_host 和 exclude_guest 属性在适当的情况下
> +禁用/启用该事件。
> +
> +对于 VHE 系统的 exclude_guest 属性排除 EL1，而对其中的 exclude_host
> +属性同时排除 EL0，EL2。在进入和退出客户端时，我们会适当地根据
> +exclude_host 和 exclude_guest 属性包括/排除 EL0。
> +
> +以上声明也适用于在 not-VHE 客户端使用这些属性时，但是请注意客户端从
> +来不会运行在 EL2。
> +
> +
> +准确性
> +------
> +
> +在 non-VHE 主机端上，我们在 EL2 进入/退出主机端/客户端的切换时启用/
> +关闭计数器 -但是在启用/禁用计数器和进入/退出客户端之间存在一段延时。
> +对于 exclude_host， 我们可以通过过滤 EL2 消除在客户端进入/退出边界
> +上用于计数客户端事件的主机端事件计数器。但是当使用 !exclude_hv 时，
> +在客户端进入/退出有一个小的暗窗口无法捕获到主机端的事件。
> +
> +在VHE系统尚没有暗窗口。
> 

暗窗口 maynot the best, but I have no better on blackout window..

Thanks
Alex
