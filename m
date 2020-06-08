Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F11F1159
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 04:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgFHCSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 22:18:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbgFHCSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:18:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 294EECEAF07F3AFA58A2;
        Mon,  8 Jun 2020 10:18:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:18:43 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: attach IO flags to the missing cases
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
 <20200604235023.1954-2-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0a50ee8a-b83d-ff10-ce40-264c8208af9c@huawei.com>
Date:   Mon, 8 Jun 2020 10:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200604235023.1954-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/5 7:50, Jaegeuk Kim wrote:
> This adds more IOs to attach flags.
> 
> Fixes: d58f2f658159 ("f2fs: add node_io_flag for bio flags likewise data_io_flag")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
