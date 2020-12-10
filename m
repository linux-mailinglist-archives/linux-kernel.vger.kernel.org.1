Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5C2D5598
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgLJIng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:43:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9576 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgLJIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:43:36 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cs6q849KSzM356;
        Thu, 10 Dec 2020 16:42:12 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 16:42:51 +0800
Subject: Re: [f2fs-dev] [PATCH v3 2/3] f2fs-tools:sload.f2fs compression
 support
To:     Robin Hsu <robinh3123@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201208081555.652932-1-robinh3123@gmail.com>
 <20201208081555.652932-3-robinh3123@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <785e9f0a-c3d6-9cc5-f17a-a3cc58a43a0f@huawei.com>
Date:   Thu, 10 Dec 2020 16:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201208081555.652932-3-robinh3123@gmail.com>
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
> Add F2FS compression support for sload
> * Support file extension filter, either default-accept or default-deny
>    policy
> * Support choice of compression algorithm, LZO (version 2) or LZ4
>    (default)
> * Support custom log of cluster size
> * Support minimum number of compressed blocks per cluster (default 1).
>    A cluster will not be compressed if the number can not be met.
> * suuport -r (read-only) option

Could you please update manual as well?

> +
> +	/* sldc: sload compression support */

Personally, I don't like the naming method of adding "sldc_" prefix... :(

> +	bool sldc_en;
> +	bool sldc_use_allow_list;  /* default false to use the deny list */
> +	struct compress_ctx sldc_cc;
> +	u8 sldc_ca; /* compress algorithm: 0 = LZO, 1 = LZ4 */
> +	compress_ops *sldc_compr;
> +	enum filter_policy sldc_policy;
> +	/* max_cppc can used to specify minimum compression rate */
> +	unsigned int sldc_min_cbpc; /* min compressed pages per cluster */
> +	bool sldc_got_opt;
> +	bool sldc_immutable;
> +	struct ext_tbl_op *sldc_ef; /* extension filter */

The variables name like sldc_en, sldc_ca, min_cbpc, sldc_ef makes developers
hard to understand w/o comments, and also there is no comments for several
variable like sldc_en, sldc_cc...

Could you please improve the naming like f2fs-tools style?

Thanks,
