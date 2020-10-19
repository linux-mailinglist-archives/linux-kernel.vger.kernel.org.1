Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4488292492
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgJSJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:26:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgJSJ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:26:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3605CACD8;
        Mon, 19 Oct 2020 09:26:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8C1C51E1340; Mon, 19 Oct 2020 11:26:06 +0200 (CEST)
Date:   Mon, 19 Oct 2020 11:26:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH] fs/quota: update quota state flags scheme with project
 quota flags
Message-ID: <20201019092606.GB30825@quack2.suse.cz>
References: <1602989814-28922-1-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602989814-28922-1-git-send-email-dotdot@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 18-10-20 05:56:54, Roman Anufriev wrote:
> Current quota state flags scheme doesn't include project quota and thus
> shows all flags after DQUOT_USAGE_ENABLED wrong. Fix this and also add
> DQUOT_NOLIST_DIRTY to the scheme.
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  include/linux/quota.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index 27aab84..18ebd39 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -448,17 +448,18 @@ struct quota_format_type {
>  };
>  
>  /**
> - * Quota state flags - they actually come in two flavors - for users and groups.
> + * Quota state flags - they come in three flavors - for users, groups and projects.
>   *
>   * Actual typed flags layout:
> - *				USRQUOTA	GRPQUOTA
> - *  DQUOT_USAGE_ENABLED		0x0001		0x0002
> - *  DQUOT_LIMITS_ENABLED	0x0004		0x0008
> - *  DQUOT_SUSPENDED		0x0010		0x0020
> + *				USRQUOTA	GRPQUOTA	PRJQUOTA
> + *  DQUOT_USAGE_ENABLED		0x0001		0x0002		0x0004
> + *  DQUOT_LIMITS_ENABLED	0x0008		0x0010		0x0020
> + *  DQUOT_SUSPENDED		0x0040		0x0080		0x0100
>   *
>   * Following bits are used for non-typed flags:
> - *  DQUOT_QUOTA_SYS_FILE	0x0040
> - *  DQUOT_NEGATIVE_USAGE	0x0080
> + *  DQUOT_QUOTA_SYS_FILE	0x0200
> + *  DQUOT_NEGATIVE_USAGE	0x0400
> + *  DQUOT_NOLIST_DIRTY		0x0800
>   */
>  enum {
>  	_DQUOT_USAGE_ENABLED = 0,		/* Track disk usage for users */
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
