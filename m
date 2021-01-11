Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37382F1170
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbhAKLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:25:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39996 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbhAKLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:25:02 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kyvJ6-00043Q-6l; Mon, 11 Jan 2021 11:24:20 +0000
Date:   Mon, 11 Jan 2021 12:24:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     yanfei.xu@windriver.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: remove comments about old _do_fork() helper
Message-ID: <20210111112416.5k5gtrtcme2ljxew@wittgenstein>
References: <20210111104807.18022-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111104807.18022-1-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:48:07PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> The old _do_fork() helper has been removed in favor of kernel_clone().
> Here correct some comments which still contain _do_fork()
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks, applied.
