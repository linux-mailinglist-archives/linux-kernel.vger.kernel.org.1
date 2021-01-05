Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3986B2EAB58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbhAENBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbhAENBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:01:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 556CD229F0;
        Tue,  5 Jan 2021 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609851639;
        bh=bk2fAAGdKAI4pOGSvmoeukZB7mglz/IgYfjQa6DN3lM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bs6qCn4GcLAFliJpnskoTtdAj8carDljINO/ooxalWZ5xEhmY2eSMp1wEr+xehlWV
         +QVq0NPz5LfWC/3vhH8UTMMCCkd0mfqZmHLqIzde/sRHFYB9j89405x5Skh44oruMX
         5M212QQvKejFd2sP4OAyQdGTAYOJE7rEALV+J/Wx2SmsC4zhR+yriRTjeQK8T0AZtI
         0DfEt0fPhFjFo7oI+shAYdWax6D1qIpSjdHUmMU3k/OM0xUMtaXrFrzpkMyFMEQY4K
         8qj6TWzZVlNSc6lZy8kIWye41WHmx3rgCqGHQ1r/1O+2GZwe9vFUhG5+Vt+4vaCICC
         onXlfvsQdO/kQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Baxter <jim_baxter@mentor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: select CONFIG_CRC32
In-Reply-To: <20210103214224.1996535-1-arnd@kernel.org>
References: <20210103214224.1996535-1-arnd@kernel.org>
Date:   Tue, 05 Jan 2021 15:00:35 +0200
Message-ID: <87pn2jczd8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Without crc32 support, this driver fails to link:
>
> arm-linux-gnueabi-ld: drivers/usb/gadget/function/f_eem.o: in function `eem_unwrap':
> f_eem.c:(.text+0x11cc): undefined reference to `crc32_le'
> arm-linux-gnueabi-ld: drivers/usb/gadget/function/f_ncm.o:f_ncm.c:(.text+0x1e40):
> more undefined references to `crc32_le' follow
>
> Fixes: 6d3865f9d41f ("usb: gadget: NCM: Add transmit multi-frame.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
