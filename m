Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02CB251D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHYQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 12:29:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52554 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:29:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kAbpU-00Gzn9-A8; Tue, 25 Aug 2020 10:29:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kAbpT-0004tt-E9; Tue, 25 Aug 2020 10:29:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
Date:   Tue, 25 Aug 2020 11:26:07 -0500
In-Reply-To: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Tue, 25 Aug 2020 17:41:48 +0200")
Message-ID: <87zh6in140.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kAbpT-0004tt-E9;;;mid=<87zh6in140.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180adhO/AqgzbD7D7p+bWPfotXaxtE0H5I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 536 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.7%), b_tie_ro: 2.6 (0.5%), parse: 0.74
        (0.1%), extract_message_metadata: 24 (4.4%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 34 (6.3%), tests_pri_-950: 0.97 (0.2%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 103 (19.3%), check_bayes:
        102 (19.1%), b_tokenize: 8 (1.5%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 79 (14.7%), b_finish: 0.64
        (0.1%), tests_pri_0: 359 (67.1%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 4.5 (0.8%), poll_dns_idle: 0.16 (0.0%), tests_pri_10:
        1.67 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A) If we are going to have this discussion in public we really should
   include the containers list.

B) The challenge is that most of the namespace work has become part of
   it's upstream subsystem so we really need to list the containers
   list and ourselves as reviewers, more than maintainers who run
   a tree for the code.

C) You have overstated what I have agreed to here.
   I have have previously said that I agree that having a MAINTAINERS
   entry so people who are unfamiliar with the situation with namespaces
   can find us.  Given that most of the changes going forward are likely
   to be maintenance changes.

   I also said we need to talk about how we plan to maintain the code
   here.

   It feels like you are pushing this hard, and I am not certain why you
   are pushing and rushing this.  With my maintainer hat on my big
   concern is we catch the issues that will introduce security issue.
   Recently I have seen a report that there is an issue on Ubuntu
   kernels where anyone can read /etc/shadow.  The problem is that
   Ubuntu has not been cautions and has not taken the time to figure out
   how to enable things for unprivileged users safely, and have just
   enabled the code to be used by unprivileged users because it is
   useful.

   In combination with you pushing hard and not taking the time to
   complete this conversation in private with me, this MAINTAINERS entry
   makes me uneasy as it feels like you may be looking for a way to push
   the code into the mainline kernel like has been pushed into the
   Ubuntu kernel.  I may be completely wrong I just don't know what to
   make of your not finishing our conversation in private, and forcing
   my hand by posting this patch publicly.

The files you have listed are reasonable for a maintainers entry as they
have no other maintainers.

I know I have been less active after the birth of my young son, and I
know the practical rule is that the person who does the work is the
maintainer.  At the same time I am not convinced you are actually going
to do the work to make new code maintainable and not a problem for other
kernel developers.

A big part the job over the years has been to make the namespace ideas
proposed sane, and to keep the burden from other maintainers of naive
and terrible code.  Pushing this change before we finished our private
conversation makes me very nervous on that front.

Eric

Christian Brauner <christian.brauner@ubuntu.com> writes:

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
> +
>  NAND FLASH SUBSYSTEM
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  R:	Richard Weinberger <richard@nod.at>
>
> base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
