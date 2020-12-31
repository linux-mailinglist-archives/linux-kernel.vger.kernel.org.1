Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35922E8182
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLaRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 12:43:06 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52541 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgLaRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 12:43:05 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 741A7C0003;
        Thu, 31 Dec 2020 17:42:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match
Date:   Thu, 31 Dec 2020 18:42:23 +0100
Message-Id: <160943653614.132002.12499200411415721355.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222025931.3043480-1-natechancellor@gmail.com>
References: <20201222025931.3043480-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 19:59:31 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  ../drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute
>  declaration must precede definition [-Wignored-attributes]
>  static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>                      ^
>  ../include/linux/compiler_attributes.h:267:56: note: expanded from macro
>  '__maybe_unused'
>  #define __maybe_unused                  __attribute__((__unused__))
>                                                         ^
>  ../include/linux/mod_devicetable.h:262:8: note: previous definition is
>  here
>  struct of_device_id {
>         ^
> 1 warning generated.
> 
> [...]

Applied, thanks!

[1/1] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match
      commit: 291b5c9870fc546376d69cf792b7885cd0c9c1b3

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
