Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8A292157
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgJSDGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:06:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbgJSDGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:06:09 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 065D65D84146CC2E6BB0;
        Mon, 19 Oct 2020 11:06:07 +0800 (CST)
Received: from [10.174.176.185] (10.174.176.185) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 11:05:59 +0800
Subject: Re: [PATCH RFC 0/5] ubifs: Prevent memory oob accessing while dumping
 node
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <liu.song11@zte.com.cn>, <yi.zhang@huawei.com>
References: <20200616071146.2607061-1-chengzhihao1@huawei.com>
Message-ID: <f22055d4-47c8-d83d-f650-6fd82ce54a29@huawei.com>
Date:   Mon, 19 Oct 2020 11:05:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200616071146.2607061-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2020/6/16 15:11, Zhihao Cheng Ð´µÀ:
> We use function ubifs_dump_node() to dump bad node caused by some
> reasons (Such as bit flipping caused by hardware error, writing bypass
> ubifs or unknown bugs in ubifs). The node content can not be trusted
> anymore, so we should prevent memory out-of-bounds accessing while
> dumping node in following situations:
> 
> 1. bad node_len: Dumping data according to 'ch->len' which may exceed
>     the size of memory allocated for node.
> 2. bad node content: Some kinds of node can record additional data, eg.
>     index node and orphan node, make sure the size of additional data
>     not beyond the node length.
> 3. node_type changes: Read data according to type A, but expected type
>     B, before that, node is allocated according to type B's size. Length
>     of type A node is greater than type B node.
> 
> Commit acc5af3efa303d5f3 ("ubifs: Fix out-of-bounds memory access caused
> by abnormal value of node_len") handles situation 1 for data node only,
> it would be better if we can solve problems in above situations for all
> kinds of nodes.
> 
> Patch 1 adds a new parameter 'node_len'(size of memory which is allocated
> for the node) in function ubifs_dump_node(), safe dumping length of the
> node should be: minimum(ch->len, c->ranges[node_type].max_len, node_len).
> Besides, c->ranges[node_type].min_len can not greater than safe dumping
> length, which may caused by node_type changes(situation 3).
> 
> Patch 2 reverts commit acc5af3efa303d5f ("ubifs: Fix out-of-bounds memory
> access caused by abnormal value of node_len") to prepare for patch 3.
> 
> Patch 3 replaces modified function ubifs_dump_node() in all node dumping
> places except for ubifs_dump_sleb().
> 
> Patch 4 removes unused function ubifs_dump_sleb(),
> 
> Patch 5 allows ubifs_dump_node() to dump all branches of the index node.
> 
> Some tests after patchset applied:
> https://bugzilla.kernel.org/show_bug.cgi?id=208203
> 
> Zhihao Cheng (5):
>    ubifs: Limit dumping length by size of memory which is allocated for
>      the node
>    Revert "ubifs: Fix out-of-bounds memory access caused by abnormal
>      value of node_len"
>    ubifs: Pass node length in all node dumping callers
>    ubifs: ubifs_dump_sleb: Remove unused function
>    ubifs: ubifs_dump_node: Dump all branches of the index node
> 
>   fs/ubifs/commit.c   |   4 +-
>   fs/ubifs/debug.c    | 111 ++++++++++++++++++++++++++------------------
>   fs/ubifs/debug.h    |   5 +-
>   fs/ubifs/file.c     |   2 +-
>   fs/ubifs/io.c       |  37 +++++----------
>   fs/ubifs/journal.c  |   3 +-
>   fs/ubifs/master.c   |   4 +-
>   fs/ubifs/orphan.c   |   6 ++-
>   fs/ubifs/recovery.c |   6 +--
>   fs/ubifs/replay.c   |   4 +-
>   fs/ubifs/sb.c       |   2 +-
>   fs/ubifs/scan.c     |   4 +-
>   fs/ubifs/super.c    |   2 +-
>   fs/ubifs/tnc.c      |   8 ++--
>   fs/ubifs/tnc_misc.c |   4 +-
>   fs/ubifs/ubifs.h    |   4 +-
>   16 files changed, 108 insertions(+), 98 deletions(-)
> 
ping, although it is not a serious problem for ubifs, but dumping extra 
memory by formating specified ubifs img may cause security problem.
