Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB59B269EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIOGgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:36:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56259 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgIOGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:36:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9.sHE3_1600151785;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9.sHE3_1600151785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 14:36:25 +0800
Subject: Re: [PATCH] Documentation: Chinese translation of
 Documentation/arm64/amu.rst
To:     Bailu Lin <bailu.lin@vivo.com>, Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, wangqing@vivo.com
References: <20200915025822.29885-1-bailu.lin@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7c584fe4-5b77-3345-79d3-a48735e36816@linux.alibaba.com>
Date:   Tue, 15 Sep 2020 14:34:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200915025822.29885-1-bailu.lin@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bailu,

I can not apply your patch even after manual set 'charset=UTF-8'
and vim can't figure out the chinese chars. Could you like to check and fix
it? 
Also it's better to run 'make htmldocs' and then put the output to website
to see if everything in your doc appear correctly on website.

Also we use '[PATCH v2]' in subject to show the 2nd version of same patch.
and reply it on the first version thread could avoid people overlook it.


Applying: Documentation: Chinese translation of Documentation/arm64/amu.rst
error: dev/null: does not exist in index
Patch failed at 0001 Documentation: Chinese translation of Documentation/arm64/amu.rst
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

�� 2020/9/15 ����10:58, Bailu Lin д��:
> This is a Chinese translated version of Documentation/arm64/amu.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
>  .../translations/zh_CN/arm64/amu.rst          | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/arm64/amu.rst b/Documentation/translations/zh_CN/arm64/amu.rst
> index 000000000000..b02d54b91292
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arm64/amu.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/arm64/amu.rst`
> +
> +---------------------------------------------------------------------

don't need above dashline. and add the 'Translator: xxx' here.
> +
> +==================================
> +AArch64 Linux ����չ�Ļ��ص�Ԫ
> +==================================

does the '=' number align with chars?

> +
> +����: Ionela Voinescu <ionela.voinescu@arm.com>
> +
> +����: 2019-09-10
> +
> +���ĵ���Ҫ������ AArch64 Linux ֧�ֵĻ��ص�Ԫ�Ĺ淶��
> +
> +
> +�ܹ�����
> +--------
> +
> +������ ARMv8.4 CPU �ܹ������һ����ѡ��չ���ԡ�
> +
> +���ص�Ԫ(��ÿ�� CPU ��ʵ��)Ϊϵͳ�����ṩ�����ܼ��������ȿ���ͨ
> +��ϵͳ�Ĵ����ķ�ʽ���ʼ�������ͬʱҲ֧���ⲿ�ڴ�ӳ��ķ�ʽ���ʼ�������
> +
> +AMUv1 �ܹ�ʵ����һ����4���̶���64λ�¼���������ɵļ������顣
> +
> +  - CPU ���ڼ�������ͬ CPU ��Ƶ������
> +  - ������������ͬ�̶���ϵͳʱ��Ƶ������
> +  - ��ָ̭�������: ͬÿ�μܹ�ָ��ִ������
> +  - �ڴ�ͣ�����ڼ���������������ʱ�����ڵ����һ��������δ���ж�����
> +    ��ָ�����ͣ��������
> +
> +������ WFI ���� WFE ״̬ʱ������������������
> +
> +AMU �ܹ��ṩ��һ���ߴ�16λ���¼��������ռ䣬δ���µ� AMU �汾�п���
> +������ʵ���������¼���������
> +
> +���⣬AMUv1 ʵ����һ�����16��64λ�����¼��������ļ������顣
> +
> +�临λʱ���еļ����������㡣
> +
> +
> +����֧��
> +--------
> +
> +�ں˿��԰�ȫ��������֧�� AMU �Ͳ�֧�� AMU �� CPU ����С�
> +��ˣ������� CONFIG_ARM64_AMU_EXTN ������������ʹ�ܺ���(���������Ȳ��)

'secondary cpu' better to translate as '�ڶ���cpu'

Thanks
Alex
> +CPU ����ʹ��������ԡ�
> +
> +���� CPU �ϼ�⵽������ʱ�����ǻ���Ϊ���Կ��õ��ǲ��ܱ�֤�������Ĺ��ܣ�
> +����������չ���ԡ�
> +
> +�̼�(���������ڸ��쳣�������� arm-tf )��֧�����¹��ܣ�
> +
> + - �ṩ���쳣����(EL2 �� EL1)���� AMU �Ĵ�����������
> + - ʹ�ܼ����������δʹ�ܣ�����ֵӦΪ 0��
> + - �ڴӵ�Դ�ر�״̬���� CPU ǰ��󱣴���߻ָ���������
> +
> +��ʹ��ʹ���˸����Ե��ں��������̼���ʱ�����ʼ������Ĵ������ܻ�����
> +panic ������������ʹδ������Щ֢״���������Ĵ������ص����ݽ������һ
> +���ܷ�ӳ��ʵ�����ͨ�����������᷵�� 0����������δ��ʹ�ܡ�
> +
> +����̼�û���ṩ�ʵ���֧����ùر� CONFIG_ARM64_AMU_EXTN��
> +ֵ��ע����ǣ����ڰ�ȫԭ�򣬲�Ҫ�ƹ� AMUSERRENR_EL0 ���ö������
> +EL0(�û��ռ�) ���� EL1(�ں˿ռ�)�� ��ˣ��̼�Ӧ��ȷ������ AMU�Ĵ���
> +�������� EL2��EL3��
> +
> +AMUv1 �Ĺ̶�����������ͨ������ϵͳ�Ĵ������ʣ�
> +
> + - SYS_AMEVCNTR0_CORE_EL0
> + - SYS_AMEVCNTR0_CONST_EL0
> + - SYS_AMEVCNTR0_INST_RET_EL0
> + - SYS_AMEVCNTR0_MEM_STALL_EL0
> +
> +�ض���������������ͨ�� SYS_AMEVCNTR1_EL0(n) ���ʣ�����n����0��15��
> +
> +��ϸ��Ϣ������Ŀ¼��arch/arm64/include/asm/sysreg.h��
> +
> +
> +�û��ռ����
> +------------
> +
> +��������ԭ�򣬵�ǰ��ֹ���û��ռ���� AMU �ļĴ�����
> +
> +  - ��ȫ���������ܻᱩ¶���ڰ�ȫģʽִ�еĴ�����Ϣ��
> +  - ��Ը��AMU ������ϵͳ����ġ�
> +
> +ͬ�����ù��ܶ��û��ռ䲻�ɼ���
> +
> +
> +���⻯
> +------
> +
> +��������ԭ�򣬵�ǰ��ֹ�� KVM �ͻ��˵��û��ռ�(EL0)���ں˿ռ�(EL1)
> +���� AMU �ļĴ�����
> +
> +  - ��ȫ���������ܻᱩ¶�������ͻ��˻�������ִ�еĴ�����Ϣ��
> +
> +�κ���ͼ���� AMU �Ĵ�������Ϊ���ᴥ��һ��ע���ڿͻ��˵�δ�����쳣��
> 
