Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B69277706
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgIXQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:41:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:59178 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgIXQlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:41:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D89277D;
        Thu, 24 Sep 2020 16:41:43 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:41:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bailu Lin <bailu.lin@vivo.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, harryxiyou@gmail.com,
        alex.shi@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v2] Documentation: Chinese translation of
 Documentation/arm64/amu.rst
Message-ID: <20200924104141.7abc7271@lwn.net>
In-Reply-To: <20200918092136.23190-1-bailu.lin@vivo.com>
References: <20200915025822.29885-1-bailu.lin@vivo.com>
        <20200918092136.23190-1-bailu.lin@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 02:21:36 -0700
Bailu Lin <bailu.lin@vivo.com> wrote:

> This is a Chinese translated version of Documentation/arm64/amu.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v2:
>  - Add index to arm64 directoy.
>  - Fix a document format error.
>  - Correct email encoding format.
> ---
>  Documentation/arm64/amu.rst                   |   4 +
>  .../translations/zh_CN/arm64/amu.rst          | 102 ++++++++++++++++++
>  .../translations/zh_CN/arm64/index.rst        |   2 +
>  3 files changed, 108 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/amu.rst
> 
> diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
> index 452ec8b115c2..a97d1e18876d 100644
> --- a/Documentation/arm64/amu.rst
> +++ b/Documentation/arm64/amu.rst
> @@ -1,3 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _amu_index:
> +

So that's not a translation, it's an unrelated change that doesn't belong
in this patch.  Asserting a license always needs to be done carefully, and
it needs to be called out as such.

Thanks,

jon
