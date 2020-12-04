Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666412CF3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgLDSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbgLDSYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:24:22 -0500
Date:   Fri, 4 Dec 2020 10:23:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607106221;
        bh=frGCvVorSjGhUb+CZl2+o3Cot8SUsEXDTN1OlWl1EbQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsjJ3mvp9gloogt304bTevJHpT/RfKJMsafOaPkZoK1zw7noVonG+B1aL2e24rfxR
         bg2jR9Vx9deMPl5Jn2y2f92hOP3biDihijQcU9x3uQl3LvnY17Qh98zDxckPiMQSrt
         vKrS/aAuVwFKSNHWgKIn2KQzz0voU7t/ga3n6L8T6TISDVG4mnmXoKpzvbMU91CfRS
         l75b2q4WqezSxkRMfxdBcobyy3ATkGwyXOM7g8FyRNaFbCmNPk/sJodj9Z60LqzQcn
         dMrwPs1ESjs83xgCa3Z0Q3WAX1coOqBn0McjYGAeZs3A3RTYwNZeaOd1TxmWLPm1Ls
         YpHjLEt98zS6w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: introduce a new per-sb directory in sysfs
Message-ID: <X8p+rK6wQsXdcG33@google.com>
References: <20201127090118.84235-1-yuchao0@huawei.com>
 <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Chao Yu wrote:
> Jaegeuk,
> 
> Can you comment on this patch?

Waiting for use-case? :)

> 
> On 2020/11/27 17:01, Chao Yu wrote:
> > Add a new directory 'stat' in path of /sys/fs/f2fs/<devname>/, later
> > we can add new readonly stat sysfs file into this directory, it will
> > make <devname> directory less mess.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >   fs/f2fs/f2fs.h  |  5 +++-
> >   fs/f2fs/sysfs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++----
> >   2 files changed, 68 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 0d38f2135016..a20059dece46 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1510,9 +1510,12 @@ struct f2fs_sb_info {
> >   	unsigned int node_io_flag;
> >   	/* For sysfs suppport */
> > -	struct kobject s_kobj;
> > +	struct kobject s_kobj;			/* /sys/fs/f2fs/<devname> */
> >   	struct completion s_kobj_unregister;
> > +	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
> > +	struct completion s_stat_kobj_unregister;
> > +
> >   	/* For shrinker support */
> >   	struct list_head s_list;
> >   	int s_ndevs;				/* number of devices */
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index ec77ccfea923..8c63a6e61dfd 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -708,6 +708,11 @@ static struct attribute *f2fs_feat_attrs[] = {
> >   };
> >   ATTRIBUTE_GROUPS(f2fs_feat);
> > +static struct attribute *f2fs_stat_attrs[] = {
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(f2fs_stat);
> > +
> >   static const struct sysfs_ops f2fs_attr_ops = {
> >   	.show	= f2fs_attr_show,
> >   	.store	= f2fs_attr_store,
> > @@ -736,6 +741,44 @@ static struct kobject f2fs_feat = {
> >   	.kset	= &f2fs_kset,
> >   };
> > +static ssize_t f2fs_stat_attr_show(struct kobject *kobj,
> > +				struct attribute *attr, char *buf)
> > +{
> > +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> > +								s_stat_kobj);
> > +	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
> > +
> > +	return a->show ? a->show(a, sbi, buf) : 0;
> > +}
> > +
> > +static ssize_t f2fs_stat_attr_store(struct kobject *kobj, struct attribute *attr,
> > +						const char *buf, size_t len)
> > +{
> > +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> > +								s_stat_kobj);
> > +	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
> > +
> > +	return a->store ? a->store(a, sbi, buf, len) : 0;
> > +}
> > +
> > +static void f2fs_stat_kobj_release(struct kobject *kobj)
> > +{
> > +	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
> > +								s_stat_kobj);
> > +	complete(&sbi->s_stat_kobj_unregister);
> > +}
> > +
> > +static const struct sysfs_ops f2fs_stat_attr_ops = {
> > +	.show	= f2fs_stat_attr_show,
> > +	.store	= f2fs_stat_attr_store,
> > +};
> > +
> > +static struct kobj_type f2fs_stat_ktype = {
> > +	.default_groups = f2fs_stat_groups,
> > +	.sysfs_ops	= &f2fs_stat_attr_ops,
> > +	.release	= f2fs_stat_kobj_release,
> > +};
> > +
> >   static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
> >   						void *offset)
> >   {
> > @@ -942,11 +985,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >   	init_completion(&sbi->s_kobj_unregister);
> >   	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
> >   				"%s", sb->s_id);
> > -	if (err) {
> > -		kobject_put(&sbi->s_kobj);
> > -		wait_for_completion(&sbi->s_kobj_unregister);
> > -		return err;
> > -	}
> > +	if (err)
> > +		goto put_sb_kobj;
> > +
> > +	sbi->s_stat_kobj.kset = &f2fs_kset;
> > +	init_completion(&sbi->s_stat_kobj_unregister);
> > +	err = kobject_init_and_add(&sbi->s_stat_kobj, &f2fs_stat_ktype,
> > +						&sbi->s_kobj, "stat");
> > +	if (err)
> > +		goto put_stat_kobj;
> >   	if (f2fs_proc_root)
> >   		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
> > @@ -962,6 +1009,13 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >   				victim_bits_seq_show, sb);
> >   	}
> >   	return 0;
> > +put_stat_kobj:
> > +	kobject_put(&sbi->s_stat_kobj);
> > +	wait_for_completion(&sbi->s_stat_kobj_unregister);
> > +put_sb_kobj:
> > +	kobject_put(&sbi->s_kobj);
> > +	wait_for_completion(&sbi->s_kobj_unregister);
> > +	return err;
> >   }
> >   void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
> > @@ -973,6 +1027,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
> >   		remove_proc_entry("victim_bits", sbi->s_proc);
> >   		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
> >   	}
> > +
> > +	kobject_del(&sbi->s_stat_kobj);
> > +	kobject_put(&sbi->s_stat_kobj);
> > +	wait_for_completion(&sbi->s_stat_kobj_unregister);
> > +
> >   	kobject_del(&sbi->s_kobj);
> >   	kobject_put(&sbi->s_kobj);
> >   	wait_for_completion(&sbi->s_kobj_unregister);
> > 
