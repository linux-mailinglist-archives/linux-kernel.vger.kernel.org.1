Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7471FFFAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 03:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgFSBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 21:31:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbgFSBb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:31:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 62E488DA3105F60DEED1;
        Fri, 19 Jun 2020 09:31:27 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 09:31:23 +0800
Subject: Re: [PATCH] f2fs-tools: set cold flag for non-dir node
To:     <zhaowuyun@wingtech.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592484487-12072-1-git-send-email-zhaowuyun@wingtech.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4a2d19c4-1ede-0172-fe50-c8464ee341df@huawei.com>
Date:   Fri, 19 Jun 2020 09:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1592484487-12072-1-git-send-email-zhaowuyun@wingtech.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/18 20:48, zhaowuyun@wingtech.com wrote:
> From: Wuyun Zhao <zhaowuyun@wingtech.com>

Thanks for the patch. :)

Please add commit message here.

> 
> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
> ---
>  fsck/dir.c  |  1 +
>  fsck/node.c |  1 +
>  fsck/node.h | 11 +++++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 5f4f75e..dc03c98 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -522,6 +522,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
>  	node_blk->footer.nid = cpu_to_le32(de->ino);
>  	node_blk->footer.flag = 0;
>  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> +	set_cold_node(node_blk, S_ISDIR(mode));
>  
>  	if (S_ISDIR(mode)) {
>  		make_empty_dir(sbi, node_blk);
> diff --git a/fsck/node.c b/fsck/node.c
> index 229a99c..1d291ca 100644
> --- a/fsck/node.c
> +++ b/fsck/node.c
> @@ -79,6 +79,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>  	node_blk->footer.ino = f2fs_inode->footer.ino;
>  	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
>  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> +	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));

How about wrapping these node footer fields assignment into a function? then
we can reuse this in other places.

void set_node_footer(nid, ino, ofs, ver, is_dir)
{
	node_blk->footer.nid = cpu_to_le32(nid);
	node_blk->footer.ino = f2fs_inode->footer.ino;
	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
}

>  
>  	type = CURSEG_COLD_NODE;
>  	if (IS_DNODE(node_blk)) {
> diff --git a/fsck/node.h b/fsck/node.h
> index 6bce1fb..99139b1 100644
> --- a/fsck/node.h
> +++ b/fsck/node.h
> @@ -161,6 +161,17 @@ static inline int is_node(struct f2fs_node *node_blk, int type)
>  	return le32_to_cpu(node_blk->footer.flag) & (1 << type);
>  }

Beside this, I think we need to use set_node_footer() in:
- f2fs_write_root_inode
- f2fs_write_qf_inode
- f2fs_write_lpf_inode

as well to fix mkfs bugs.

Thanks,

>  
> +static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
> +{
> +	unsigned int flag = le32_to_cpu(rn->footer.flag);
> +
> +	if (is_dir)
> +		flag &= ~(0x1 << COLD_BIT_SHIFT);
> +	else
> +		flag |= (0x1 << COLD_BIT_SHIFT);
> +	rn->footer.flag = cpu_to_le32(flag);
> +}
> +
>  #define is_fsync_dnode(node_blk)	is_node(node_blk, FSYNC_BIT_SHIFT)
>  #define is_dent_dnode(node_blk)		is_node(node_blk, DENT_BIT_SHIFT)
>  
> 
