Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10B2D5597
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgLJImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:42:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9488 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388003AbgLJImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:42:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cs6ng53qLzhpW3;
        Thu, 10 Dec 2020 16:40:55 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 16:41:26 +0800
Subject: Re: [f2fs-dev] [PATCH v3 1/3] f2fs-tools: Added #ifdef WITH_func
To:     Robin Hsu <robinh3123@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201208081555.652932-1-robinh3123@gmail.com>
 <20201208081555.652932-2-robinh3123@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <142ae8c7-bed7-2aec-35bb-afaf2a8ab59d@huawei.com>
Date:   Thu, 10 Dec 2020 16:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201208081555.652932-2-robinh3123@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/8 16:15, Robin Hsu wrote:
> From: Robin Hsu <robinhsu@google.com>
> 
> Add proprocessor defines (options) 'WITH_func',
> where func = DUMP, DEFRAG, RESIZE, or SLOAD
> 
> Signed-off-by: Robin Hsu <robinhsu@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
