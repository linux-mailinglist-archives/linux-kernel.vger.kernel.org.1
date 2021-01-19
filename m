Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D962FB7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbhASL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:26:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405357AbhASLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:14:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l1oxI-0007wR-NI; Tue, 19 Jan 2021 11:13:48 +0000
Date:   Tue, 19 Jan 2021 12:13:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro
Message-ID: <20210119111346.o3tzlx3vlepx7v6b@wittgenstein>
References: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:50:24AM +0800, Jinyang He wrote:
> Fixes: 	e1cc9d8d596e ("sh: switch to copy_thread_tls()")
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

weird that I missed to remove this during the conversion.

Thanks!
Christian
