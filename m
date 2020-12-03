Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2432CD1E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgLCI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:57:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8935 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgLCI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:57:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CmqSX3j9wzhl8h;
        Thu,  3 Dec 2020 16:56:12 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 3 Dec 2020
 16:56:27 +0800
Subject: Re: [PATCH] f2fs: introduce a new per-sb directory in sysfs
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20201127090118.84235-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
Date:   Thu, 3 Dec 2020 16:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201127090118.84235-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Can you comment on this patch?

On 2020/11/27 17:01, Chao Yu wrote:
> Add a new directory 'stat' in path of /sys/fs/f2fs/<devname>/, later
> we can add new readonly stat sysfs file into this directory, it will
> make <devname> directory less mess.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/f2fs.h  |  5 +++-
>   fs/f2fs/sysfs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0d38f2135016..a20059dece46 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1510,9 +1510,12 @@ struct f2fs_sb_info {
>   	unsigned int node_io_flag;
>   
>   	/* For sysfs suppport */
> -	struct kobject s_kobj;
> +	struct kobject s_kobj;			/* /sys/fs/f2fs/<devname> */
>   	struct completion s_kobj_unregister;
>   
> +	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
> +	struct completion s_stat_kobj_unregister;
> +
>   	/* For shrinker support */
>   	struct list_head s_list;
>   	int s_ndevs;				/* number of devices */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index ec77ccfea923..8c63a6e61dfd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -708,6 +708,11 @@ static struct attribute *f2fs_feat_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(f2fs_feat);
>   
> +static struct attribute *f2fs_stat_attrs[] = {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(f2fs_stat);
> +
>   static const struct sysfs_ops f2fs_attr_ops = {
>   	.show	= f2fs_attr_show,
>   	.store	= f2fs_attr_store,
> @@ -736,6 +741,44 @@ static struct kobject f2fs_feat = {
>   	.kset	= &f2fs_kset,
>   };
>   
> +static ssize_t f2fs_stat_attr_show(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> +								s_stat_kobj);
> +	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
> +
> +	return a->show ? a->show(a, sbi, buf) : 0;
> +}
> +
> +static ssize_t f2fs_stat_attr_store(struct kobject *kobj, struct attribute *attr,
> +						const char *buf, size_t len)
> +{
> +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> +								s_stat_kobj);
> +	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
> +
> +	return a->store ? a->store(a, sbi, buf, len) : 0;
> +}
> +
> +static void f2fs_stat_kobj_release(struct kobject *kobj)
> +{
> +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> +								s_stat_kobj);
> +	complete(&sbi->s_stat_kobj_unregister);
> +}
> +
> +static const struct sysfs_ops f2fs_stat_attr_ops = {
> +	.show	= f2fs_stat_attr_show,
> +	.store	= f2fs_stat_attr_store,
> +};
> +
> +static struct kobj_type f2fs_stat_ktype = {
> +	.default_groups = f2fs_stat_groups,
> +	.sysfs_ops	= &f2fs_stat_attr_ops,
> +	.release	= f2fs_stat_kobj_release,
> +};
> +
>   static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
>   						void *offset)
>   {
> @@ -942,11 +985,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>   	init_completion(&sbi->s_kobj_unregister);
>   	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
>   				"%s", sb->s_id);
> -	if (err) {
> -		kobject_put(&sbi->s_kobj);
> -		wait_for_completion(&sbi->s_kobj_unregister);
> -		return err;
> -	}
> +	if (err)
> +		goto put_sb_kobj;
> +
> +	sbi->s_stat_kobj.kset = &f2fs_kset;
> +	init_completion(&sbi->s_stat_kobj_unregister);
> +	err = kobject_init_and_add(&sbi->s_stat_kobj, &f2fs_stat_ktype,
> +						&sbi->s_kobj, "stat");
> +	if (err)
> +		goto put_stat_kobj;
>   
>   	if (f2fs_proc_root)
>   		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
> @@ -962,6 +1009,13 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>   				victim_bits_seq_show, sb);
>   	}
>   	return 0;
> +put_stat_kobj:
> +	kobject_put(&sbi->s_stat_kobj);
> +	wait_for_completion(&sbi->s_stat_kobj_unregister);
> +put_sb_kobj:
> +	kobject_put(&sbi->s_kobj);
> +	wait_for_completion(&sbi->s_kobj_unregister);
> +	return err;
>   }
>   
>   void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
> @@ -973,6 +1027,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>   		remove_proc_entry("victim_bits", sbi->s_proc);
>   		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>   	}
> +
> +	kobject_del(&sbi->s_stat_kobj);
> +	kobject_put(&sbi->s_stat_kobj);
> +	wait_for_completion(&sbi->s_stat_kobj_unregister);
> +
>   	kobject_del(&sbi->s_kobj);
>   	kobject_put(&sbi->s_kobj);
>   	wait_for_completion(&sbi->s_kobj_unregister);
> 
