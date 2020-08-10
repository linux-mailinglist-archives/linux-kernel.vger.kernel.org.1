Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F077240503
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHJLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 07:03:57 -0400
Received: from correo.us.es ([193.147.175.20]:49588 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgHJLDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:03:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5B8D6EB471
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:03:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4EB83DA78F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:03:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4453ADA78B; Mon, 10 Aug 2020 13:03:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E2B43DA801;
        Mon, 10 Aug 2020 13:03:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Aug 2020 13:03:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C348D4265A2F;
        Mon, 10 Aug 2020 13:03:51 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:03:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, lkp@lists.01.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH nf] netfilter: nft_compat: remove flush counter
 optimization
Message-ID: <20200810110351.GA1613@salvia>
References: <20200809063030.GA1538@shao2-debian>
 <20200809182801.9315-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809182801.9315-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 08:28:01PM +0200, Florian Westphal wrote:
> WARNING: CPU: 1 PID: 16059 at lib/refcount.c:31 refcount_warn_saturate+0xdf/0xf
> [..]
>  __nft_mt_tg_destroy+0x42/0x50 [nft_compat]
>  nft_target_destroy+0x63/0x80 [nft_compat]
>  nf_tables_expr_destroy+0x1b/0x30 [nf_tables]
>  nf_tables_rule_destroy+0x3a/0x70 [nf_tables]
>  nf_tables_exit_net+0x186/0x3d0 [nf_tables]
> 
> Happens when a compat expr is destoyed from abort path.
> There is no functional impact; after this work queue is flushed
> unconditionally if its pending.
> 
> This removes the waitcount optimization.  Test of repeated
> iptables-restore of a ~60k kubernetes ruleset doesn't indicate
> a slowdown.  In case the counter is needed after all for some workloads
> we can revert this and increment the refcount for the
> != NFT_PREPARE_TRANS case to avoid the increment/decrement imbalance.
> 
> While at it, also flush for match case, this was an oversight
> in the original patch.

Applied, thanks.
