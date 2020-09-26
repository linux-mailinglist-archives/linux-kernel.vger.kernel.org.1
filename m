Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A9527973A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgIZGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:23:08 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37108 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgIZGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:23:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UA5a0Qh_1601101379;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UA5a0Qh_1601101379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 26 Sep 2020 14:22:59 +0800
Subject: Re: [PATCH v5] doc: zh_CN: index files in arm64 subdirectory
To:     Bailu Lin <bailu.lin@vivo.com>
Cc:     catalin.marinas@arm.com, corbet@lwn.net, harryxiyou@gmail.com,
        kernel@vivo.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org
References: <20200925144223.40381-1-bailu.lin@vivo.com>
 <20200926022558.46232-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <50eb18ad-ee3c-951f-03a5-5971285435bf@linux.alibaba.com>
Date:   Sat, 26 Sep 2020 14:20:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200926022558.46232-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/9/26 上午10:25, Bailu Lin 写道:
> Add arm64 subdirectory into the table of Contents for zh_CN,
> then add other translations in arm64 conveniently.
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v5:
>  - Remove zh_CN/arm64/index.rst's inappropriate License claim.
> Changes in v4:
>  - Remove index.rst's inappropriate License claim.
> Changes in v3:
>  - Correct email encoding format.
> Changes in v2:
>  - Fix patch description.
> ---
>  Documentation/arm64/index.rst                    |  2 ++
>  Documentation/translations/zh_CN/arm64/index.rst | 14 ++++++++++++++
>  Documentation/translations/zh_CN/index.rst       |  1 +
>  3 files changed, 17 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/index.rst
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index d9665d83c53a..3ebe0fa31948 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -1,3 +1,5 @@
> +.. _arm64_index:
> +
>  ==================
>  ARM64 Architecture
>  ==================
> diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
> new file mode 100644
> index 000000000000..57545f19ab2d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arm64/index.rst
> @@ -0,0 +1,14 @@
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
