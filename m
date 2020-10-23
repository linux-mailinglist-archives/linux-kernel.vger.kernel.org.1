Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AB29786F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756399AbgJWUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756388AbgJWUuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:50:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5AB2087D;
        Fri, 23 Oct 2020 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603486255;
        bh=91kW8VhINOrqyNiRlLThFlBmHAOIJT0T4/3KEH8+ZhY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2kJ7qWKUJl9WawhEosoILdFs1W+lIHiUlaMW1cXguIaiIG/yl5Fmkk4IxWW+G5wmk
         U6T38Cwoyo9CGnDv3oJqSHvi50NbWm7OnUtW5LZHMSGvHtrlHT4oCG4P4OT9V9e/Ow
         ulhJfqA6f6ha2wgG4+GWoaNat+iQo0r3vXTlwLjs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B39B53520D11; Fri, 23 Oct 2020 13:50:54 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:50:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Eric Dumazet <edumazet@google.com>, NeilBrown <neilb@suse.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 46/56] list: fix a typo at the kernel-doc markup
Message-ID: <20201023205054.GP3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <5c710f3b33c4572b5065a4f1e085c5d09dc04c7d.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c710f3b33c4572b5065a4f1e085c5d09dc04c7d.1603469755.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:33PM +0200, Mauro Carvalho Chehab wrote:
> hlist_add_behing -> hlist_add_behind
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index a18c87b63376..f72a7a778722 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -901,7 +901,7 @@ static inline void hlist_add_before(struct hlist_node *n,
>  }
>  
>  /**
> - * hlist_add_behing - add a new entry after the one specified
> + * hlist_add_behind - add a new entry after the one specified
>   * @n: new entry to be added
>   * @prev: hlist node to add it after, which must be non-NULL
>   */
> -- 
> 2.26.2
> 
