Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99101269C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIODFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:05:13 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:45848 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIODFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:05:02 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 23:04:57 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 2F6ACB02089;
        Tue, 15 Sep 2020 10:58:31 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bailu Lin <bailu.lin@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, wangqing@vivo.com
Subject: [PATCH] Documentation: Chinese translation of Documentation/arm64/amu.rst
Date:   Mon, 14 Sep 2020 19:58:11 -0700
Message-Id: <20200915025822.29885-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGRpPSE9CGUseHUoYVkpNS0tKSENMSkpDTE5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09LQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6Eio*FD8oTxcjNi88Lwkh
        ExEaCypVSlVKTUtLSkhDTEpJSElMVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSUxZV1kIAVlBTk9LTTcG
X-HM-Tid: 0a748fb3126498b7kuuu2f6acb02089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Chinese translated version of Documentation/arm64/amu.rst

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
---
 .../translations/zh_CN/arm64/amu.rst          | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/Documentation/translations/zh_CN/arm64/amu.rst b/Documentation/translations/zh_CN/arm64/amu.rst
index 000000000000..b02d54b91292
--- /dev/null
+++ b/Documentation/translations/zh_CN/arm64/amu.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/arm64/amu.rst`
+
+---------------------------------------------------------------------
+
+==================================
+AArch64 Linux 中扩展的活动监控单元
+==================================
+
+作者: Ionela Voinescu <ionela.voinescu@arm.com>
+
+日期: 2019-09-10
+
+本文档简要描述了 AArch64 Linux 支持的活动监控单元的规范。
+
+
+架构总述
+--------
+
+活动监控是 ARMv8.4 CPU 架构引入的一个可选扩展特性。
+
+活动监控单元(在每个 CPU 中实现)为系统管理提供了性能计数器。既可以通
+过系统寄存器的方式访问计数器，同时也支持外部内存映射的方式访问计数器。
+
+AMUv1 架构实现了一个由4个固定的64位事件计数器组成的计数器组。
+
+  - CPU 周期计数器：同 CPU 的频率增长
+  - 常量计数器：同固定的系统时钟频率增长
+  - 淘汰指令计数器: 同每次架构指令执行增长
+  - 内存停顿周期计数器：计算由在时钟域内的最后一级缓存中未命中而引起
+    的指令调度停顿周期数
+
+当处于 WFI 或者 WFE 状态时，计数器不会增长。
+
+AMU 架构提供了一个高达16位的事件计数器空间，未来新的 AMU 版本中可能
+用它来实现新增的事件计数器。
+
+另外，AMUv1 实现了一个多达16个64位辅助事件计数器的计数器组。
+
+冷复位时所有的计数器会清零。
+
+
+基本支持
+--------
+
+内核可以安全地运行在支持 AMU 和不支持 AMU 的 CPU 组合中。
+因此，当配置 CONFIG_ARM64_AMU_EXTN 后我们无条件使能后续(副启动或热插拔)
+CPU 检测和使用这个特性。
+
+当在 CPU 上检测到该特性时，我们会标记为特性可用但是不能保证计数器的功能，
+仅表明有扩展属性。
+
+固件(代码运行在高异常级别，例如 arm-tf )需支持以下功能：
+
+ - 提供低异常级别(EL2 和 EL1)访问 AMU 寄存器的能力。
+ - 使能计数器。如果未使能，它的值应为 0。
+ - 在从电源关闭状态启动 CPU 前或后保存或者恢复计数器。
+
+当使用使能了该特性的内核启动但固件损坏时，访问计数器寄存器可能会遭遇
+panic 或者死锁。即使未发现这些症状，计数器寄存器返回的数据结果并不一
+定能反映真实情况。通常，计数器会返回 0，表明他们未被使能。
+
+如果固件没有提供适当的支持最好关闭 CONFIG_ARM64_AMU_EXTN。
+值得注意的是，出于安全原因，不要绕过 AMUSERRENR_EL0 设置而捕获从
+EL0(用户空间) 访问 EL1(内核空间)。 因此，固件应该确保访问 AMU寄存器
+不会困在 EL2或EL3。
+
+AMUv1 的固定计数器可以通过如下系统寄存器访问：
+
+ - SYS_AMEVCNTR0_CORE_EL0
+ - SYS_AMEVCNTR0_CONST_EL0
+ - SYS_AMEVCNTR0_INST_RET_EL0
+ - SYS_AMEVCNTR0_MEM_STALL_EL0
+
+特定辅助计数器可以通过 SYS_AMEVCNTR1_EL0(n) 访问，其中n介于0到15。
+
+详细信息定义在目录：arch/arm64/include/asm/sysreg.h。
+
+
+用户空间访问
+------------
+
+由于以下原因，当前禁止从用户空间访问 AMU 的寄存器：
+
+  - 安全因数：可能会暴露处于安全模式执行的代码信息。
+  - 意愿：AMU 是用于系统管理的。
+
+同样，该功能对用户空间不可见。
+
+
+虚拟化
+------
+
+由于以下原因，当前禁止从 KVM 客户端的用户空间(EL0)和内核空间(EL1)
+访问 AMU 的寄存器：
+
+  - 安全因数：可能会暴露给其他客户端或主机端执行的代码信息。
+
+任何试图访问 AMU 寄存器的行为都会触发一个注册在客户端的未定义异常。
-- 
2.20.1

