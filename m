Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296121D615
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 14:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgGMMib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 08:38:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57176 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:38:31 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1juxj1-0001AD-UL; Mon, 13 Jul 2020 06:38:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1juxj0-0000e9-Sw; Mon, 13 Jul 2020 06:38:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com
References: <20200704205619.11172-1-richard@nod.at>
Date:   Mon, 13 Jul 2020 07:35:39 -0500
In-Reply-To: <20200704205619.11172-1-richard@nod.at> (Richard Weinberger's
        message of "Sat, 4 Jul 2020 22:56:19 +0200")
Message-ID: <87sgdvbnj8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1juxj0-0000e9-Sw;;;mid=<87sgdvbnj8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pMLZQ3OtSquT9B9ftcoTj28hZic45tqk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Richard Weinberger <richard@nod.at>
X-Spam-Relay-Country: 
X-Spam-Timing: total 670 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.14 (0.2%),
         extract_message_metadata: 13 (2.0%), get_uri_detail_list: 2.6 (0.4%),
        tests_pri_-1000: 5.0 (0.7%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 81 (12.2%), check_bayes:
        80 (11.9%), b_tokenize: 10 (1.4%), b_tok_get_all: 9 (1.3%),
        b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 55 (8.2%), b_finish: 0.94
        (0.1%), tests_pri_0: 358 (53.4%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 169 (25.2%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 192 (28.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] [RFC] kernfs: Allow vm_ops->close() if VMA is never split
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Weinberger <richard@nod.at> writes:

> 10 years ago commit a6849fa1f7d7 ("sysfs: Fail bin file mmap if vma close is implemented.")
> removed support for vm_ops->close() for mmap on sysfs.
> As far I understand the reason is that due to the wrapping in kernfs
> every VMA split operation needs to be tracked to call vm_ops->close()
> for all fragments. This is not feasible with reasonable effort.
>
> Since commit 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct")
> we can get notified as soon a VMA is split, this can help to relax the restriction.
> So I propose to allow having a custom close under the condition that a
> VMA cannot get split.

The existence of split may help but your patch does not address the
problem.

The difficult to handle case is not split.  Simply wrapping
vma->vm_ops->open and vma->vm_ops->close is enough to handle split.  The
challenge is when the kernel revokes acess to a kernfs file.  Revokes
happen when the module supporting a kernfs file is removed, or when a
piece of hardware is removed.

The code path for that revocation looks like:
	kernfs_remove or kernfs_remove_self
		__kernfs_remove
			kernfs_drain
        			kernfs_drain_open_files
                			unmap_mapping_range


The fundamental problem is that at the time of unmap_mapping_range the
code if it is to implement vma->vm_ops->close properly needs to call
close on all of the vmas.  The code can not wait longer as after
kernfs_remove returns the kernfs code makes the guarantee that the code
implementing vma->vm_ops->close has been removed from the kernel.

The technical challenge is how to implement walking the list of vmas and
call the vma->vops->close method on all of them at revoke time.  Last
I looked taking the locks that are necessary to do that is not safe to
do when holding the locks that are held in the kernfs_remove path.

A lot has changed in kernfs and the mm subsystem since I examined it,
so it might be worth looking at this again.

So in short the problem is that the code does not exist to call close
when the kernfs file is revoked.  Your patch below does not implement
that code.

Eric

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/kernfs/file.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 06b342d8462b..82b09e72acff 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -347,6 +347,38 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
>  	kernfs_put_active(of->kn);
>  }
>  
> +static void kernfs_vma_close(struct vm_area_struct *vma)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kernfs_open_file *of = kernfs_of(file);
> +
> +	if (!of->vm_ops)
> +		return;
> +
> +	if (!kernfs_get_active(of->kn))
> +		return;
> +
> +	if (of->vm_ops->close)
> +		of->vm_ops->close(vma);
> +
> +	kernfs_put_active(of->kn);
> +}
> +
> +static int kernfs_vma_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kernfs_open_file *of = kernfs_of(file);
> +
> +	/*
> +	 * We cannot keep track of split operations,
> +	 * so refuse splitting a VMA if someone uses close.
> +	 */
> +	if (of->vm_ops && of->vm_ops->close)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
>  {
>  	struct file *file = vmf->vma->vm_file;
> @@ -457,6 +489,8 @@ static struct mempolicy *kernfs_vma_get_policy(struct vm_area_struct *vma,
>  
>  static const struct vm_operations_struct kernfs_vm_ops = {
>  	.open		= kernfs_vma_open,
> +	.close		= kernfs_vma_close,
> +	.split		= kernfs_vma_split,
>  	.fault		= kernfs_vma_fault,
>  	.page_mkwrite	= kernfs_vma_page_mkwrite,
>  	.access		= kernfs_vma_access,
> @@ -505,14 +539,6 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (of->mmapped && of->vm_ops != vma->vm_ops)
>  		goto out_put;
>  
> -	/*
> -	 * It is not possible to successfully wrap close.
> -	 * So error if someone is trying to use close.
> -	 */
> -	rc = -EINVAL;
> -	if (vma->vm_ops && vma->vm_ops->close)
> -		goto out_put;
> -
>  	rc = 0;
>  	of->mmapped = true;
>  	of->vm_ops = vma->vm_ops;
