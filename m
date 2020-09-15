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

在 2020/9/15 上午10:58, Bailu Lin 写道:
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
> +AArch64 Linux 中扩展的活动监控单元
> +==================================

does the '=' number align with chars?

> +
> +作者: Ionela Voinescu <ionela.voinescu@arm.com>
> +
> +日期: 2019-09-10
> +
> +本文档简要描述了 AArch64 Linux 支持的活动监控单元的规范。
> +
> +
> +架构总述
> +--------
> +
> +活动监控是 ARMv8.4 CPU 架构引入的一个可选扩展特性。
> +
> +活动监控单元(在每个 CPU 中实现)为系统管理提供了性能计数器。既可以通
> +过系统寄存器的方式访问计数器，同时也支持外部内存映射的方式访问计数器。
> +
> +AMUv1 架构实现了一个由4个固定的64位事件计数器组成的计数器组。
> +
> +  - CPU 周期计数器：同 CPU 的频率增长
> +  - 常量计数器：同固定的系统时钟频率增长
> +  - 淘汰指令计数器: 同每次架构指令执行增长
> +  - 内存停顿周期计数器：计算由在时钟域内的最后一级缓存中未命中而引起
> +    的指令调度停顿周期数
> +
> +当处于 WFI 或者 WFE 状态时，计数器不会增长。
> +
> +AMU 架构提供了一个高达16位的事件计数器空间，未来新的 AMU 版本中可能
> +用它来实现新增的事件计数器。
> +
> +另外，AMUv1 实现了一个多达16个64位辅助事件计数器的计数器组。
> +
> +冷复位时所有的计数器会清零。
> +
> +
> +基本支持
> +--------
> +
> +内核可以安全地运行在支持 AMU 和不支持 AMU 的 CPU 组合中。
> +因此，当配置 CONFIG_ARM64_AMU_EXTN 后我们无条件使能后续(副启动或热插拔)

'secondary cpu' better to translate as '第二个cpu'

Thanks
Alex
> +CPU 检测和使用这个特性。
> +
> +当在 CPU 上检测到该特性时，我们会标记为特性可用但是不能保证计数器的功能，
> +仅表明有扩展属性。
> +
> +固件(代码运行在高异常级别，例如 arm-tf )需支持以下功能：
> +
> + - 提供低异常级别(EL2 和 EL1)访问 AMU 寄存器的能力。
> + - 使能计数器。如果未使能，它的值应为 0。
> + - 在从电源关闭状态启动 CPU 前或后保存或者恢复计数器。
> +
> +当使用使能了该特性的内核启动但固件损坏时，访问计数器寄存器可能会遭遇
> +panic 或者死锁。即使未发现这些症状，计数器寄存器返回的数据结果并不一
> +定能反映真实情况。通常，计数器会返回 0，表明他们未被使能。
> +
> +如果固件没有提供适当的支持最好关闭 CONFIG_ARM64_AMU_EXTN。
> +值得注意的是，出于安全原因，不要绕过 AMUSERRENR_EL0 设置而捕获从
> +EL0(用户空间) 访问 EL1(内核空间)。 因此，固件应该确保访问 AMU寄存器
> +不会困在 EL2或EL3。
> +
> +AMUv1 的固定计数器可以通过如下系统寄存器访问：
> +
> + - SYS_AMEVCNTR0_CORE_EL0
> + - SYS_AMEVCNTR0_CONST_EL0
> + - SYS_AMEVCNTR0_INST_RET_EL0
> + - SYS_AMEVCNTR0_MEM_STALL_EL0
> +
> +特定辅助计数器可以通过 SYS_AMEVCNTR1_EL0(n) 访问，其中n介于0到15。
> +
> +详细信息定义在目录：arch/arm64/include/asm/sysreg.h。
> +
> +
> +用户空间访问
> +------------
> +
> +由于以下原因，当前禁止从用户空间访问 AMU 的寄存器：
> +
> +  - 安全因数：可能会暴露处于安全模式执行的代码信息。
> +  - 意愿：AMU 是用于系统管理的。
> +
> +同样，该功能对用户空间不可见。
> +
> +
> +虚拟化
> +------
> +
> +由于以下原因，当前禁止从 KVM 客户端的用户空间(EL0)和内核空间(EL1)
> +访问 AMU 的寄存器：
> +
> +  - 安全因数：可能会暴露给其他客户端或主机端执行的代码信息。
> +
> +任何试图访问 AMU 寄存器的行为都会触发一个注册在客户端的未定义异常。
> 
