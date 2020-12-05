Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF02CF896
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgLEBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLEBZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:25:21 -0500
Subject: Re: [PATCH v5] f2fs: compress: add compress_inode to cache compressed
 blocks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607131480;
        bh=AtPUHOpHifjIG0tNWMDfawxqAFqBz8TWWYRbtrNwnXE=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=Ma9x1jBF6INcT4TZ4ExEq+/fG9vmLT6PPb0sA05nrpru5V6px/ONF9RfEdHOA0PoY
         vtmgjIDZLDuB8FT0yXYOr9HJsC6xfXY3CNpVLCloeGn1C2oTTC8CmD7GdrVfDx095w
         h3qW9EmWyixpNU7QfPw5pfP2CrLFLiVBk4Rm7Sq6KBIGiOXEJ8th3HWup5RVNYZEdZ
         rjoLm7D3uBpq3pbSAcEPZp4/vf/B/Zggbpg6LaInNhOSfgNc6561Kvr+sBkjY9POq9
         QrqrK/gS8CDuyk7CaTIuY2k3o7kPRBkypo1CpgX4OAQsM3Ybzzhswtwyw2WhCfjw5E
         MIR79Llhp5IqQ==
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
References: <20201202145018.6505-1-chao@kernel.org>
 <X8qJKC/lKRfh/+8s@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a6fa096d-7cf3-8b39-4a40-6ba1e4613634@kernel.org>
Date:   Sat, 5 Dec 2020 09:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X8qJKC/lKRfh/+8s@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/5 3:08, Jaegeuk Kim wrote:
> Chao, could you please rebase this patch?

Sure.

> 
> Thanks,
