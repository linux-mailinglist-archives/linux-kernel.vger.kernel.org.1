Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5F2D1467
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLGPHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgLGPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:07:07 -0500
Subject: Re: [PATCH 2/2] f2fs: don't check PAGE_SIZE again in
 sanity_check_raw_super()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607353586;
        bh=UknzbuqDK9Fr9lU5a/hvPbN5gZqB4HgBYDMvW5xk22o=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=RdeVVeFZ+1EebKQ1sop+/hBrxDOp+MY5WY5bTSTdqhkWNqC26tjopTYHot3Ixq+Gy
         eHrF+NdoYGKzYzY38gWBXZMdq/Xxg6F5CWIx0UjCoZf2FB63/OyiJrZeb4XlPjD/AE
         xo66czp1Y9Cx//p6M8Yq5vr4rhq1dHncn9trFzQGRtEEnQnQTZzvWTdun3MyJHdoMX
         m901JKk07azeW3SP9DV7UuhFw/DHW3qBLsBEWwCj/Vy1RiIrKo6DRkq98AB9eLoAF1
         yqgCXM/z8yDP4WHh947/nu67TpVrZhDZIPM62wUBDbdLV8ZnfqOToa/M6KM/k0Qkq3
         Gm4uYIzLFp00A==
To:     liush <liush@allwinnertech.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
References: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
 <1607338774-8541-2-git-send-email-liush@allwinnertech.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b576e982-3d7f-4fd2-bc70-e7986847a549@kernel.org>
Date:   Mon, 7 Dec 2020 23:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607338774-8541-2-git-send-email-liush@allwinnertech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/7 18:59, liush wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> Many flash devices read and write a single IO based on a multiple
> of 4KB, and we support only 4KB page cache size now.
> 
> Since we already check page size in init_f2fs_fs(), so remove page
> size check in sanity_check_raw_super().
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Shaohua Liu <liush@allwinnertech.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
