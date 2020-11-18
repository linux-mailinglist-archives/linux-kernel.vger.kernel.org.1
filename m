Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3042B7B38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKRKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:25:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52994 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgKRKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:25:26 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfKeL-0004ww-9h; Wed, 18 Nov 2020 10:25:17 +0000
Date:   Wed, 18 Nov 2020 11:25:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hui Su <sh_def@163.com>
Cc:     tglx@linutronix.de, serge@hallyn.com, avagin@openvz.org,
        0x7f454c46@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] namespace: make timens_on_fork() return nothing
Message-ID: <20201118102516.qhsoapn5hhrc3naq@wittgenstein>
References: <20201117161750.GA45121@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117161750.GA45121@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:17:50AM +0800, Hui Su wrote:
> timens_on_fork() always return 0, and maybe not
> need to judge the return value in copy_namespaces().
> 
> So make timens_on_fork() return nothing and do not
> judge its return val in copy_namespaces().
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=time_namespace

on top of the other timens patches I've queued up already.

Thanks!
Christian
