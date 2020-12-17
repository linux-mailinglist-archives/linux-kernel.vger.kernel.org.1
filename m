Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31662DD518
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgLQQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQQWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:22:19 -0500
Date:   Thu, 17 Dec 2020 08:21:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608222097;
        bh=jHzr6+tFBokdFu7JP5WAB8C/6k8tn3iaqv0lsRidiVk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2HkOJpaOnSEp5spSBpK/58O+G3TfTuM0aGLIctJYTXH5AIfz1ejut0RmALO4PwCi
         4d6rCbjtYUde8f1K9rW4YyZ6TR07Qkyy5swR1IrDZFCM0OWoYzrT3eCm627GuiSnOU
         69nFtebron2g2J1G38ysi6nbxjoTSblLl+najA90Wa+Y6838MXSfJU7Z7rE18LVEtO
         kppkTgn1PxQwjzBHm6h4QS9+f//ns5xp9AbWVbqaXHHv633B9Iz2e7lNRZSoiwCFcx
         0HBKMnyzPAtqHB4b7/NO+KwcDdZjlxi2bv1u5pHyDP4o5R7ANBiopFCvehdAhXlczO
         BidevYwAb41qA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Robin Hsu <robinh3123@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: Re: [PATCH] f2fs-tools: man page fix for sload compression
Message-ID: <X9uFkOp0znVuqs/B@google.com>
References: <20201217161509.866105-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217161509.866105-1-robinh3123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied into the original patch. Thanks~

On 12/18, Robin Hsu wrote:
> From: Robin Hsu <robinhsu@google.com>
> 
> Fix man page for sload.f2fs compression support
> 
> Signed-off-by: Robin Hsu <robinhsu@google.com>
> ---
>  man/sload.f2fs.8 | 94 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 84 insertions(+), 10 deletions(-)
> 
> diff --git a/man/sload.f2fs.8 b/man/sload.f2fs.8
> index d07330c..c165b35 100644
> --- a/man/sload.f2fs.8
> +++ b/man/sload.f2fs.8
> @@ -7,22 +7,48 @@ sload.f2fs \- load directories and files into the device directly
>  .B sload.f2fs
>  [
>  .B \-f
> -.I source directory path
> +.I source-directory-path
>  ]
>  [
>  .B \-t
> -.I mount point
> +.I mount-point
>  ]
>  [
>  .B \-d
>  .I debugging-level
>  ]
> +[
> +.B \-c
> +[
> +.B \-L
> +.I log-of-blocks-per-cluster
> +]
> +[
> +.B \-a
> +.I compression-algorithm
> +]
> +[
> +.B \-x
> +.I file-extension-to-exclude-from-compression
> +|
> +.B \-i
> +.I file-extension-to-include-for-compression
> +]
> +[
> +.B \-m
> +.I minimum-compressed-blocks-per-cluster
> +]
> +[
> +.B \-r
> +]
> +]
>  .I device
>  .SH DESCRIPTION
>  .B sload.f2fs
> -is used to load directories and files into a disk partition.
> -\fIdevice\fP is the special file corresponding to the device (e.g.
> -\fI/dev/sdXX\fP).
> +is used to load directories and files into a disk partition, or an F2FS
> +image (file).
> +\fIdevice\fP could a special file corresponding to the device (e.g.
> +\fI/dev/sdXX\fP), or an F2FS image file.
>  
>  .PP
>  The exit code returned by
> @@ -30,24 +56,72 @@ The exit code returned by
>  is 0 on success and -1 on failure.
>  .SH OPTIONS
>  .TP
> -.BI \-f " source directory path"
> +.BI \-f " source-directory-path"
>  Specify the source directory path to be loaded.
>  .TP
> -.BI \-t " mount point path"
> +.BI \-t " mount-point-path"
>  Specify the mount point path in the partition to load.
>  .TP
>  .BI \-d " debug-level"
>  Specify the level of debugging options.
>  The default number is 0, which shows basic debugging messages.
>  .TP
> +.BI \-c
> +Enable a cluster-based file compression.
> +The file would be chopped into clusters, and each cluster is compressed
> +independently.
> +.TP
> +.BI \-L " log-of-blocks-per-cluster
> +Specify cluster size in power of two blocks.
> +The minimum value is 2 (4 blocks, default).
> +The maximum value is 8 (256 blocks).
> +Note that a block contains 4096 bytes.
> +This option must be used with option \fB\-c\fR.
> +.TP
> +.BI \-a " compression-algorithm"
> +Choose the algorithm for compression. Available options are:
> +lzo, lz4 (default).
> +This option must be used with option \fB\-c\fR.
> +.TP
> +.BI \-i " file-extension-to-include-for-compression"
> +Specify a file extension to include for the compression.
> +To specify multiple file extensions, use multiple option \fB\-i\fR's.
> +Files having one of the listed extensions will be compressed.
> +This option must be used with option \fB\-c\fR.
> +.TP
> +.BI \-x " file-extension-to-exclude-from-compression"
> +Specify a file extension to exclude from compression.
> +To specify multiple file extensions, use multiple option \fB\-x\fR's.
> +Files having one of the listed extensions won't be compressed.
> +This option must be used with option \fB\-c\fR.
> +.TP
> +.BI \-m " minimum-compressed-blocks-per-cluster"
> +Specify a minimum block count saved (by compression) per cluster.
> +The minimum value is 1 (default).
> +Maximum value is the cluster size in blocks minus 1.
> +If compression of a cluster fails to save at least the minimum compressed
> +block count given by the option, the cluster will not be compressed.
> +This option must be used with option \fB\-c\fR.
> +.TP
> +.BI \-r
> +Specify read-only flag for the compressed files.
> +It allows filesystem to release compressed space to the users, since, without
> +this option, filesystem should keep the space for future file updates.
> +This option must be used with option \fB\-c\fR.
> +
> +.SH NOTES
> +If neither \fB\-i\fR nor \fB\-x\fR is used, all files will be compressed.
> +Obviously, option \fB\-i\fR and \fB-x\fR can not be used together.
> +
>  .SH AUTHOR
>  This version of
>  .B sload.f2fs
> -has been written by Hou Pengyang <houpengyang@huawei.com>,
> -Liu Shuoran <liushuoran@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
> +has been contributed by Hou Pengyang <houpengyang@huawei.com>,
> +Liu Shuoran <liushuoran@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
> +Robin Hsu <robinhsu@google.com>
>  .SH AVAILABILITY
>  .B sload.f2fs
> -is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
> +is available from <git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git>.
>  .SH SEE ALSO
>  .BR mkfs.f2fs(8),
>  .BR fsck.f2fs(8),
> -- 
> 2.29.2.684.gfbc64c5ab5-goog
