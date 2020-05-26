Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19D1A0770
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgDGGj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 02:39:57 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34233 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgDGGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:39:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TusvTcJ_1586241590;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TusvTcJ_1586241590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Apr 2020 14:39:50 +0800
Subject: Re: [PATCH v5] Translate debugfs.txt into Chinese and link it to the
 index.
To:     Chucheng Luo <luochucheng@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200328122315.4245-1-luochucheng@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <83019620-ed71-7efb-7ccd-6bbb52f9ee3f@linux.alibaba.com>
Date:   Tue, 7 Apr 2020 14:39:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328122315.4245-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chucheng,

Sorry for a bit late.
This patch is still have some place to improve.


�� 2020/3/28 ����8:23, Chucheng Luo д��:
> Translate Documentation/filesystems/debugfs.txt into Chinese.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> ---
> Changelog:
> v5:
>  - include disclaimer-zh_CN.rst
>  - fix space missing between debugfs.txt and its reference
>  - remove redundant '=' in caption
>  - no 'introduction' in original file, remove it
>  - keep each line less than 80 chars>  - change 'attention' to 'Note' in second last line
> ---
>  .../zh_CN/filesystems/debugfs.rst             | 258 ++++++++++++++++++
>  .../translations/zh_CN/filesystems/index.rst  |  21 ++
>  Documentation/translations/zh_CN/index.rst    |   2 +
>  3 files changed, 281 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/debugfs.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> new file mode 100644
> index 000000000000..c33d3c797b4a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -0,0 +1,258 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/debugfs.txt <debugfs_index>`
> +
> +=======
> +Debugfs
> +=======
> +
> +����
> +::
> +
> +	���İ�ά���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ淭���ߣ� �޳��� Chucheng Luo <luochucheng@vivo.com>
> +	���İ�У����:  �޳��� Chucheng Luo <luochucheng@vivo.com>
> +
> +
> +
> +��Ȩ����2020 �޳��� <luochucheng@vivo.com>
> +
> +
> +Debugfs���ں˿�����Ա���û��ռ��ȡ��Ϣ�ļ򵥷�����
> +��/proc��ͬ��procֻ�ṩ������Ϣ��
> +Ҳ����sysfs,�����ϸ�ġ�ÿ���ļ�һ��ֵ���Ĺ���
> +debugfs����û�й���,������Ա�����������������
> +��Ҫ���κ���Ϣ��debugfs�ļ�ϵͳҲ���������ȶ���ABI�ӿڡ�
> +�������Ͻ���debugfs�����ļ���ʱ��û���κ�Լ����
> +����[1]ʵ���������������ô�򵥡�
> +��ʹ��debugfs�ӿڣ�Ҳ��ø�����Ҫ�������,
> +���������ֽӿڲ��䡣

This is one section, except no more 80 chars, we'd better
to keep them as one section too. So fulfill each lines, and 
don't close too ealry until 80 chars.

And this requriment is also apply to following sections.

> +
> +

...

> +ע�ͣ�
> +[1] http://lwn.net/Articles/309298/
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> new file mode 100644
> index 000000000000..3a7f5233767d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +Linux �ں��е��ļ�ϵͳ
> +===============================

The '=' char is also too long to surpass contents. please change
them too. (as well as the '-' in following lines)
As to a same style issue. please check whole patch, not only
the comment line.


Btw, before sent out your patch, would you change the 
'charset=y' to 'charset=UTF-8'?

Thanks
Alex

> +
> +�����������ָ����ĳһ�콫���ṩ����Linux �����ļ�ϵͳ(VFS)����ι�����
> +������Ϣ���Լ�VFS���µĵ��ļ�ϵͳ��ĿǰΪֹ�������ṩ��������Ϣ��
> +
> +
> +
> +
> +�ļ�ϵͳ
> +===========> +
> +�����ļ�ϵͳʵ�ֵ��ĵ�.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   debugfs
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index d3165535ec9e..770f886d081c 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -1,3 +1,4 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  .. raw:: latex
>  
>  	\renewcommand\thesection*
> @@ -14,6 +15,7 @@
>     :maxdepth: 2
>  
>     process/index
> +   filesystems/index
>  
>  Ŀ¼�ͱ��
>  ----------
> 
