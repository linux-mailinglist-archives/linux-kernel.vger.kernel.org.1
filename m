Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07D268767
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgINIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:41:08 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:38705 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgINIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:41:07 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 04:41:06 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.134])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 68299614D66C;
        Mon, 14 Sep 2020 10:35:49 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Sep
 2020 10:35:47 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G00438ece552-2604-404d-8aff-070da96458dd,
                    33559CD024D4F69900824C14C2AC4808F9346AFD) smtp.auth=groug@kaod.org
Date:   Mon, 14 Sep 2020 10:35:46 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
CC:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>, <justin.he@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall
 bug
Message-ID: <20200914103546.0f775bcd@bahia.lan>
In-Reply-To: <20200914033754.29188-1-jianyong.wu@arm.com>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a4adab61-5db0-417d-bdd6-ca742aabf020
X-Ovh-Tracer-Id: 3126905517296294252
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeiiedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 11:37:50 +0800
Jianyong Wu <jianyong.wu@arm.com> wrote:

> open-unlink-f*syscall bug is a well-known bug in 9p, we try to fix the bug
> in this patch set.
> I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this patch
> set as the main frame of the solution. In patch 4/4, I fix the fid race issue
> exists in Greg's patch.
> 

IIRC some patches were needed on the QEMU side as well... I'm spending
less time on 9pfs in QEMU, so Cc'ing the new maintainer:

Christian Schoenebeck <qemu_oss@crudebyte.com>

> Eric Van Hensbergen (1):
>   fs/9p: fix create-unlink-getattr idiom
> 
> Greg Kurz (1):
>   fs/9p: search open fids first
> 
> Jianyong Wu (2):
>   fs/9p: track open fids
>   9p: fix race issue in fid contention.
> 
>  fs/9p/fid.c             | 72 +++++++++++++++++++++++++++++++++++------
>  fs/9p/fid.h             | 25 +++++++++++---
>  fs/9p/vfs_dentry.c      |  2 +-
>  fs/9p/vfs_dir.c         | 20 ++++++++++--
>  fs/9p/vfs_file.c        |  3 +-
>  fs/9p/vfs_inode.c       | 52 +++++++++++++++++++++--------
>  fs/9p/vfs_inode_dotl.c  | 44 ++++++++++++++++---------
>  fs/9p/vfs_super.c       |  7 ++--
>  fs/9p/xattr.c           | 18 ++++++++---
>  include/net/9p/client.h |  8 +++++
>  net/9p/client.c         |  7 +++-
>  11 files changed, 206 insertions(+), 52 deletions(-)
> 

