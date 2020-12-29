Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9656A2E70B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL2Mvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:51:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2Mvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:51:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kuEQD-0001GR-Gw; Tue, 29 Dec 2020 12:48:17 +0000
Date:   Tue, 29 Dec 2020 13:48:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Guril <alexander.guril02@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel: fork.c: Fix coding style: Do not use {} around
 single-line statements
Message-ID: <20201229124816.7q25gcur5pxfby2t@wittgenstein>
References: <20201226114021.2589-1-alexander.guril02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201226114021.2589-1-alexander.guril02@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 12:40:21PM +0100, Alexander Guril wrote:
> Fixed two coding style issues in kernel/fork.c
> Do not use {} around single-line statements.
> 
> Signed-off-by: Alexander Guril <alexander.guril02@gmail.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
I'll pick this up, thanks!
