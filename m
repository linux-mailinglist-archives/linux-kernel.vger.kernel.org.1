Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277701A5292
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDKPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 11:03:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42355 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 11:03:30 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNHfI-0005ch-C2; Sat, 11 Apr 2020 15:03:24 +0000
Date:   Sat, 11 Apr 2020 17:03:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, maco@android.com,
        tkjos@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binderfs: Fix binderfs.c selftest compilation warning
Message-ID: <20200411150323.7kthapiuj4wstvtv@wittgenstein>
References: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 10:51:51PM +0800, Tang Bin wrote:
> Fix missing braces compilation warning in the ARM
> compiler environment:
>     drivers/android/binderfs.c: In function 'binderfs_fill_super':
>     drivers/android/binderfs.c:650:9: warning: missing braces around initializer [-Wmissing-braces]
>       struct binderfs_device device_info = { 0 };
>     drivers/android/binderfs.c:650:9: warning: (near initialization for ‘device_info.name’) [-Wmissing-braces]
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
