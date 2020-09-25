Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903522780CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgIYGkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:40:22 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43308 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgIYGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:40:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UA06yVo_1601016017;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UA06yVo_1601016017)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Sep 2020 14:40:18 +0800
Subject: Re: [PATCH v3] doc: zh_CN: index files in arm64 subdirectory
To:     Bailu Lin <bailu.lin@vivo.com>, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, harryxiyou@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200916130714.42438-1-bailu.lin@vivo.com>
 <20200918081126.20765-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <bdce1e87-e0de-bd4a-fcfc-73f406af8148@linux.alibaba.com>
Date:   Fri, 25 Sep 2020 14:38:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200918081126.20765-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/18 下午4:11, Bailu Lin 写道:
> Add arm64 subdirectory into the table of Contents for zh_CN,
> then add other translations in arm64 conveniently.
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v3:
>  - Correct email encoding format.
> Changes in v2:
>  - Fix patch description.
> ---
>  Documentation/arm64/index.rst                    |  4 ++++
>  Documentation/translations/zh_CN/arm64/index.rst | 16 ++++++++++++++++
>  Documentation/translations/zh_CN/index.rst       |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/index.rst
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index d9665d83c53a..907cda9c0f71 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -1,3 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +

As Jon and Will mentioned, a License claim should be removed...
 
> +.. _arm64_index:
> +
>  ==================
>  ARM64 Architecture
>  ==================
> diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
> new file mode 100644
> index 000000000000..c236b648740d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arm64/index.rst
> @@ -0,0 +1,16 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/arm64/index.rst <arm64_index>`
> +:Translator: Bailu Lin <bailu.lin@vivo.com>
> +
> +.. _cn_arm64_index:
> +
> +
> +==========
> +ARM64 架构
> +==========
> +
> +.. toctree::
> +    :maxdepth: 2
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 85643e46e308..be6f11176200 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -19,6 +19,7 @@
>     admin-guide/index
>     process/index
>     filesystems/index
> +   arm64/index
>  
>  目录和表格
>  ----------
> 
