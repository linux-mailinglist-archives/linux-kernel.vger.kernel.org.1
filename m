Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13104269485
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgINSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:11:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3FC06174A;
        Mon, 14 Sep 2020 11:11:03 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9C1CA2D7;
        Mon, 14 Sep 2020 18:10:54 +0000 (UTC)
Date:   Mon, 14 Sep 2020 12:10:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: zh_CN: add translatation for ext3.rst
Message-ID: <20200914121053.1a0e1efc@lwn.net>
In-Reply-To: <1600085362-2157-1-git-send-email-wangqing@vivo.com>
References: <1600085362-2157-1-git-send-email-wangqing@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 20:08:32 +0800
Wang Qing <wangqing@vivo.com> wrote:

> Translate Documentation/filesystems/ext3.rst into Chinese.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  .../translations/zh_CN/filesystems/ext3.rst        | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks for your patch, I appreciate work on adding translations to the
kernel docs.  That said...
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/ext3.rst b/Documentation/translations/zh_CN/filesystems/ext3.rst
> index 0000000..38ac08b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/ext3.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/ext3.rst <ext3_index>`
> +
> +译者
> +::
> +
> +	中文版维护者： 王擎 Wang Qing <wangqing@vivo.com>
> +	中文版翻译者： 王擎 Wang Qing <wangqing@vivo.com>
> +	中文版校译者： 王擎 Wang Qing <wangqing@vivo.com>
> +
> +- Copyright (C) 2020 Vivo Communication Technology Co. Ltd.

Putting your name into the document four times seems ... excessive, and
asserting copyright seems downright wrong.  Can all of this please be
replaced with a simple "translated by" line, please?

> +===============
> +Ext3 文件系统
> +===============
> +
> +Ext3最初于1999年9月发布。由Stephen Tweedie撰写，由Peter Braam，Andreas Dilger，
> +Andrew Morton，Alexander Viro，Ted Ts'o和Stephen Tweedie移植到2.2内核。
> +
> +Ext3在ext2文件系统基础上增强日记功能。该文件系统是ext4文件系统的子集，因此请
> +使用ext4驱动访问ext3文件系统。

Thanks,

jon
