Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933082EBA01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbhAFGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:31:26 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:39393 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbhAFGb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:31:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UKtVM.C_1609914638;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UKtVM.C_1609914638)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Jan 2021 14:30:39 +0800
Subject: Re: [PATCH] docs/zh_CN: add Chinese booting and index file
To:     siyanteng@loongson.cn, Harry Wei <harryxiyou@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210105091942.812515-1-siyanteng@loongson.cn>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4eed2bbe-1567-38cf-8471-bd8165c5da7f@linux.alibaba.com>
Date:   Wed, 6 Jan 2021 14:30:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210105091942.812515-1-siyanteng@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/1/5 下午5:19, siyanteng@loongson.cn 写道:
> From: Yanteng Si <siyanteng@loongson.cn>
> 
> This is the Chinese version of booting and index file
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../translations/zh_CN/mips/booting.rst       | 47 +++++++++++++++++++
>  .../translations/zh_CN/mips/index.rst         | 45 ++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mips/booting.rst
>  create mode 100644 Documentation/translations/zh_CN/mips/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/mips/booting.rst b/Documentation/translations/zh_CN/mips/booting.rst
> new file mode 100644
> index 000000000000..12e0aa76b485
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mips/booting.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Chinese translated version of Documentation/mips/booting.rst
> +
> +If you have any comment or update to the content, please contact the
> +original document maintainer directly.  However, if you have a problem
> +communicating in English you can also ask the Chinese maintainer for
> +help.  Contact the Chinese maintainer if this translation is outdated
> +or if there is a problem with the translation.
> +
> +Chinese maintainer: Yanteng Si <siyanteng@loongson.cn>
> +---------------------------------------------------------------------
> +Documentation/mips/booting.rst 的中文翻译
> +
> +如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
> +交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
> +译存在问题，请联系中文版维护者。
> +
> +中文版维护者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
> +中文版翻译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
> +中文版校译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>

Could you like to reuse disclaimer-zh_CN.rst, and the just keep the translator
is fine if all roles are youself.


> +
> +以下为正文
> +---------------------------------------------------------------------
> +
> +BMIPS设备树引导
> +------------------------
> +
> +  一些bootloaders只支持在内核镜像开始地址处的单一入口点。而其它
> +  bootloaders将跳转到ELF的开始地址处。两种方案都被支持的；因为

How about the following changes?

s/被支持/支持/
> +  CONFIG_BOOT_RAW=y and CONFIG_NO_EXCEPT_FILL=y, 所以第一条指令
> +  会立即跳转到kernel_entry()入口处执行。
> +
> +  与arch/arm情况(b)类似，dt感知的引导加载程序需要设置以下寄存器:
> +
> +         a0 : 0
> +
> +         a1 : 0xffffffff
> +
> +         a2 : RAM中指向设备树块的物理指针(在chapterII中定义)。
> +              设备树可以位于前512MB物理地址空间(0x00000000 -
> +              0x1fffffff)的任何位置，以64位边界对齐。
> +
> +  legacy bootloaders不会使用这样的约定，并且它们不传入DT块。

s/legacy/传统/

> +  在这种情况下，Linux将通过选中CONFIG_DT_*查找DTB。
> +
> +  这个约定只在32位系统中定义，因为目前没有任何64位的BMIPS实现。

s/这个/以上/

Thanks
Alex

> diff --git a/Documentation/translations/zh_CN/mips/index.rst b/Documentation/translations/zh_CN/mips/index.rst
> new file mode 100644
> index 000000000000..244b16b7ef51
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mips/index.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Chinese translated version of Documentation/mips/index.rst
> +
> +If you have any comment or update to the content, please contact the
> +original document maintainer directly.  However, if you have a problem
> +communicating in English you can also ask the Chinese maintainer for
> +help.  Contact the Chinese maintainer if this translation is outdated
> +or if there is a problem with the translation.
> +
> +Chinese maintainer: Yanteng Si <siyanteng@loongson.cn>
> +---------------------------------------------------------------------
> +Documentation/mips/index.rst 的中文翻译
> +
> +如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
> +交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
> +译存在问题，请联系中文版维护者。
> +
> +中文版维护者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
> +中文版翻译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
> +中文版校译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
> +
> +以下为正文
> +---------------------------------------------------------------------
> +
> +
> +===========================
> +MIPS特性文档
> +===========================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> +
> +   booting
> +   ingenic-tcu
> +
> +   features
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> 
