Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA842E8D44
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhACQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhACQl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:41:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A33F3208BA;
        Sun,  3 Jan 2021 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609692078;
        bh=jRktZLLUj0Ze4wnY6qZSDDEVtFsB5z8wMpXGvD2rqFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Txw8wA2WP21UF17LTRvwyjJILOi2apkzWohHdRsb8GpTEGtYR7pFXghzGn8BPtiSp
         NQCi6/pyTzCcgPw5WVMmuHjYjCA2aQC1lzEuWY/nO9695AY6Sev0QU5G/6jLmK6shS
         cPLiS+8sebyFJnC86LMh4kt109WdJATmko/PuVX3mSNSG7P0JdZxmtCD1rWl8siqAR
         mRYyRxncBb7FsnLfZsmpie82ugNz1dKAPz/6W2Jm0IJ8Exw0VppEnCaNPX1VvGsPZR
         nBK5CXfVYL1nJwNZWZUih5aN4Tu8oh1Eg3+o58elr5VHNbWaMo1ZUf4jwOB6hiHvu3
         VxLR6LJNjhsGg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     ssantosh@kernel.org, Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH -next] drivers: memory: Use DEFINE_SPINLOCK() for spinlock
Date:   Sun,  3 Jan 2021 17:41:11 +0100
Message-Id: <160969206676.76761.10644111750475287906.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228135056.28511-1-zhengyongjun3@huawei.com>
References: <20201228135056.28511-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020 21:50:56 +0800, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Applied, thanks!

[1/1] drivers: memory: Use DEFINE_SPINLOCK() for spinlock
      commit: bd96a89ca3fe874c98fe057cccb087603d76e5d4

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
