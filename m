Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30602FD1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbhATNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:44:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:45153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389856AbhATN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149252;
        bh=ceTVrImy+Es10mPon21IC3Omv19YxsX/9oHQxEtGgFw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ixtkLUUeHLmQIAXp6mGO0HjHgkytEyVpJGEB/kplwJKKUvvLin0BpXyK56E3WbOuT
         qqPd1LR6mNzCrNK61WoXqzctZYiTORqYgoASVK8D19lgphf4kdZHzqXh9miSv9dxK5
         Uaj53BHkQUtm8pYcfMADk6vB1MySe9wi5jccNQDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mkpf3-1lk1fQ3rWp-00mHdY; Wed, 20 Jan 2021 14:27:32 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 0/7] Linux on Apple Silicon
Date:   Wed, 20 Jan 2021 14:27:10 +0100
Message-Id: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ys84d4BTU81Rm/QnLAC3amRyKhngCQyMKiWrDIO4eMhMsCepTGq
 1U2R+HirE1JDuWUUEVJ6uUHSSsktaqkcochRD41a5EX9hZTBQBOIbkQC4RUGUK9wXAl5YxL
 5MQ8kr2PHi5qh0ZIpQFyAG8Yl3KuvYikrnBdIeceG2YK2VtXFbWzwseHxDyMLCX8k24ZEEO
 Jg2MSioFhBL8iAb9EwFEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:US5sarO3DCo=:zLrEk3etvw+JNExFNcnqCC
 7ONWQR2mHQkbdrJ84Xsh0Yj7n83LBNMy2hKgSoyAsGq0wE89eJbVguDp4six2xJiYj0Z6MrvE
 ZtNCZDI3/bwy9MUT8/kypQLikr9LOQyudl7ziG+ROz1GMe7lOXr3YlP1Fd510xpNP6J4D1pas
 miMJaKI9y8dLUwGmSkUfAFYEEqLb/glvUZEVXJOCA0eiyIYGKmjwDNqsdWCIpkly9Dlg2cASv
 IdkYZka7jwQvqIF+0Mt9GqofcuWpwuES9h7O0iCByInsVboKk/Foc+mYCoajXwLLa4MG8vvMv
 ULWm+E5U7mA2igOvRJhg9LzOPb2lU++AxPObe6BRiW8iuCtpLIQVFhn3XbH1jqmG99r0O8d+6
 oglCpVRDPSYCwTKbbYMCa5JiTmml4YMpZMkwKtSAp0/0Ewn+5lSmTRp1SlC8oSsVM/XLNixYb
 M8UjWY/geMhRGAyaWJIB9S7dzyMfVES3ffXu0ilziH7uNatF7BeLl2W7glzimY2qBPuFYMZK/
 0bBgrEy8jPNIX787HR+/v8g8DGuzAw14OhobzmV4fy4l7JYyQIbsxS7CdD86cCxw+QxfqsyGu
 oToPLB7DfF9n3wPmQ12hx4K0+TooEUGnF3FII/nho//h9cpoMethyfCb3Pq/OLovGUocgL14k
 Svj43rlSsYgYtXQATkqwgwdLxvc0mbXRzMZZud55+7KR/n/dVrBwC3xjCDHPXsW2zeEu/Z6wD
 jAUgyWkrrebYo6R06AvOZ2DbMARJ7tYO34CEU8XRyc6/IiOUaMNswoENTkZG0tj1x7C+HeNnr
 oIYgttZoF5lGCoZpi/APVLaS/QqZoeHefuxIE+rpgkBVgFeVZlack02hH2r4MSfNMCLtey1OM
 CUxaLPBKrn+6n/K1Kt6VPEeWxpk3s0FOBY324BsBU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains the changes for a minimal
Linux on Apple Silicon boot, including SMP.

(sorry for the resubmission, I didn't attach the drivers
to the ones beforehand, and didn't submit it properly)

The changes:

- Support for FIQ interrupts in-kernel

This is required for the timer and IPIs on Apple SoCs.

- WFI hook

Apple processors do not keep register state across WFI.
As such, put a mechanism in cpu_ops to put a custom
sleep function instead.

- use nGnRnE instead of nGnRE on Apple processors

Device-nGnRE writes go to nowhere on Apple processors, as
such use MAIR to change those to Device-nGnRE writes.

- Apple AIC driver

Driver for the Apple AIC interrupt controller.

- Apple CPU start driver

On Apple Macs, RVBAR is locked by the bootloader.
And the hardware doesn't have EL3 to provide PSCI
as an option either. This also implements the workaround
for WFI on the hardware.

What is not present:

- Device tree, will be present in a future version of this
patchset

- More devices.

Thank you,

Mohamed Mediouni (1):
  arm64: mm: use nGnRnE instead of nGnRE on Apple processors

Stan Skowronek (6):
  arm64: kernel: FIQ support
  arm64: kernel: Add a WFI hook.
  irqchip/apple-aic: Add support for Apple AIC
  arm64/Kconfig: Add Apple Silicon SoC platform
  arm64: kernel: Apple CPU start driver
  irqchip/apple-aic: add SMP support to the Apple AIC driver.

 .../devicetree/bindings/arm/cpus.yaml         |   1 +
 .../interrupt-controller/apple,aic.yaml       |  49 +++
 MAINTAINERS                                   |   6 +
 arch/arm64/Kconfig.platforms                  |   7 +
 arch/arm64/include/asm/arch_gicv3.h           |   2 +-
 arch/arm64/include/asm/assembler.h            |   8 +-
 arch/arm64/include/asm/cpu_ops.h              |   2 +
 arch/arm64/include/asm/daifflags.h            |   4 +-
 arch/arm64/include/asm/irq.h                  |   4 +
 arch/arm64/include/asm/irqflags.h             |   6 +-
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/apple_cpustart.c            | 153 ++++++++
 arch/arm64/kernel/cpu_ops.c                   |   6 +
 arch/arm64/kernel/entry.S                     |  74 +++-
 arch/arm64/kernel/irq.c                       |  14 +
 arch/arm64/kernel/process.c                   |  13 +-
 arch/arm64/mm/proc.S                          |  26 ++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 364 ++++++++++++++++++
 20 files changed, 728 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller=
/apple,aic.yaml
 create mode 100644 arch/arm64/kernel/apple_cpustart.c
 create mode 100644 drivers/irqchip/irq-apple-aic.c

=2D-
2.29.2

