Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791AA251CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHYQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 12:01:21 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:55326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgHYQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:01:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 00B8A837F24F;
        Tue, 25 Aug 2020 16:01:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2565:2682:2685:2689:2693:2731:2828:2859:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4425:5007:7809:8829:9010:9025:10004:10044:10400:10848:11232:11657:11658:11914:12043:12291:12297:12555:12740:12760:12895:12986:13439:14096:14097:14181:14659:14721:21080:21450:21451:21627:21795:21939:30054:30060:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: jar75_46028082705d
X-Filterd-Recvd-Size: 3756
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 16:01:02 +0000 (UTC)
Message-ID: <ec1410782019a2e43399445206e673273fd12c31.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Aug 2020 09:01:01 -0700
In-Reply-To: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 17:41 +0200, Christian Brauner wrote:
> Namespace maintainership has never been formalized which has led to confusion
> when people need to determine where to send patches and who should take a look
> at them. Especially, since we have a dedicated list
> containers.lists.linuxfoundation.org already for a long time. In preparation of
> this patch I added the containers.lists.linuxfoundation.org mailing list to be
> archived on lore.
> 
> This will not just make it easier to catch and review patches specific to
> namespaces and containers but also for changes not specifically touching
> namespaces but which nevertheless will have impact on namespaces and
> containers.
> 
> Add an entry for Eric (who agreed to this) and me and add a first batch of
> files that are relevant. Currently, only a small set of files are added and
> only such namespaces that haven't gotten a separate maintainers entry (e.g.
> time namespaces). I expect this to grow more entries and/or regular expressions
> over time. For now these entries here are sufficient. I intend to route this
> patch upstream soon.
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  MAINTAINERS | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0068bceeb61..272211cdc327 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11892,6 +11892,26 @@ S:	Supported
>  W:	https://www.cspi.com/ethernet-products/support/downloads/
>  F:	drivers/net/ethernet/myricom/myri10ge/
>  
> +NAMESPACES AND CONTAINERS
> +M:     Christian Brauner <christian.brauner@ubuntu.com>
> +M:     Eric W. Biederman <ebiederm@xmission.com>
> +L:     containers.lists.linuxfoundation.org
> +S:     Supported
> +T:     https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
> +T:     https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/
> +F:     ipc/namespace.c
> +F:     kernel/nsproxy.c
> +F:     kernel/pid_namespace.c
> +F:     kernel/user_namespace.c
> +F:     kernel/utsname.c
> +F:     include/linux/nsproxy.h
> +F:     include/linux/ipc_namespace.h
> +F:     include/linux/ns_common.h
> +F:     include/linux/nsproxy.h
> +F:     include/linux/pid_namespace.h
> +F:     include/linux/user_namespace.h
> +F:     include/linux/utsname.h

Please sort the filename order alphabetically.

F:	include/linux/ipc_namespace.h
F:	include/linux/ns_common.h
F:	include/linux/nsproxy.h
F:	include/linux/nsproxy.h
F:	include/linux/pid_namespace.h
F:	include/linux/user_namespace.h
F:	include/linux/utsname.h
F:	ipc/namespace.c
F:	kernel/nsproxy.c
F:	kernel/pid_namespace.c
F:	kernel/user_namespace.c
F:	kernel/utsname.c


