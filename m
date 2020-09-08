Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7801F26202C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbgIHUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgIHPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:16:19 -0400
Received: from [192.168.0.108] (unknown [117.89.211.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD480224D2;
        Tue,  8 Sep 2020 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599576967;
        bh=9IraBddHKBi8D39cZOi4SSf6qZh84ONmGT1YEQT8fAE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=KJ9alqSCRqr7fLiIFOLAqEQDlWFKjk6op0NHZuDAs5HzemGEsJwR7b3PMbTC7f21S
         ISKLnoQpyICXf6iOUJuSrTHhxyw0XLE1cpkoMXqxB3Zr1b8RGOCKs73XYICEspIDcM
         1R/zpGMLK0cHu5PCukycx2jhOmpoqbvUN1eYGcIA=
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: change i_compr_blocks of inode to
 atomic value
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200908024411.2692388-1-daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7b3d9b1f-2394-6163-ada5-63e9a053475d@kernel.org>
Date:   Tue, 8 Sep 2020 22:55:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200908024411.2692388-1-daeho43@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-9-8 10:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> writepages() can be concurrently invoked for the same file by different
> threads such as a thread fsyncing the file and a kworker kernel thread.
> So, changing i_compr_blocks without protection is racy and we need to
> protect it by changing it with atomic type value. Plus, we don't need
> a 64bit value for i_compr_blocks, so just we will use a atomic value,
> not atomic64.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
