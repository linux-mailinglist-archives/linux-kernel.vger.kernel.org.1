Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E988F1E187C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 02:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEZAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEZAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:31:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15846C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:31:12 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p4so8709710qvr.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4nWWXi8qCXT9b5o9GmVwjoEsDaKwahe7vf3tGdNZwE=;
        b=ZuhdvUk7sfvXRz7F/zug9z1Ai7NHAh6QTWSHAlrthly+E40qyNby2MBcN3J5zTcaJq
         qhxLhCyDuPQM3S4wCNwm8DlOKBcLPdH/d7LCkdG4ByrcPomg2WSxYh+Iq2Si6UfKN25H
         DKYH1/QdsGxp1B31R6qCgVWOz7P/qPTBUi0IFz5TgFfRgFEu4FbFcopVrtY/NVZb77fe
         Dhb95g0gYo/IB3YQ87cD2gnpWvnr7UOSovzkjkWYpAeOBIxWvgmxhWm09C306C6sgJMK
         SBAHugwgLhgR8kDfvdjYQE8T6nQNboRCt/zi64uE+qXpWPW2B+FxnR93C2/IZmS1oF2Y
         0eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4nWWXi8qCXT9b5o9GmVwjoEsDaKwahe7vf3tGdNZwE=;
        b=Y7sGduKFyKYxO2WGEtg2eEvmWoDJS5klEXG8JOTxcqFwQijzL5A6YjLAUdXehyGLyi
         skgS0OoO0vl0wbBVEjsC/NSLWFHZOPAAgFF20EF6ankRCX39nnXn84RY8lGWZOxZtsMe
         ZCl0/ce6u3Uo2jIHw34c3+jtE6Jn1k2a0XLL7uARnzO79zu+i07qeuh3oXk+epm2ay5X
         c2fa86t/Gds/8m60U0zMtr4cEXR2ism1ZB3Ur3fcXCF/nrPOlwhjnzbG0adYSc+X1hbF
         qzHRsdARjUtgQ1aGiRXTqh82b6cF0IHLe8Q9sn8jGJUi9EIgAlYFKLTJvQLu70S1Aymq
         LCbg==
X-Gm-Message-State: AOAM532bb3oNXMA4O8s5qzyLjBGSjJ3O1guwuH9B9wOcURVdm4CVrujh
        izpl1VPYx+ar+ngTnQbE38wq8w==
X-Google-Smtp-Source: ABdhPJzxmy9Zc1nX8eync6kzxizMe3npjopcMH0OSdMUFzKfRkwzMRyC1VFYMIWlBlyT3HBB07pfaw==
X-Received: by 2002:a0c:fb0e:: with SMTP id c14mr3846688qvp.63.1590453071286;
        Mon, 25 May 2020 17:31:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v69sm11854642qkb.96.2020.05.25.17.31.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 17:31:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdNUs-0001vu-5D; Mon, 25 May 2020 21:31:10 -0300
Date:   Mon, 25 May 2020 21:31:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Message-ID: <20200526003110.GJ744@ziepe.ca>
References: <1589469084-15125-1-git-send-email-divya.indi@oracle.com>
 <1589469084-15125-2-git-send-email-divya.indi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589469084-15125-2-git-send-email-divya.indi@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:11:24AM -0700, Divya Indi wrote:
>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>  				     struct ib_sa_query *query)
>  {
> @@ -889,6 +904,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>  		list_del(&query->list);
>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +	} else {
> +		set_bit(IB_SA_NL_QUERY_SENT, (unsigned long *)&query->flags);
> +
> +		/*
> +		 * If response is received before this flag was set
> +		 * someone is waiting to process the response and release the
> +		 * query.
> +		 */
> +		wake_up(&wait_queue);
>  	}

As far as I can see the issue here is that the request is put into the
ib_nl_request_list before it is really ready to be in that list, eg
ib_nl_send_msg() has actually completed and ownership of the memory
has been transfered.

It appears to me the reason for this is simply because a spinlock is
used for the ib_nl_request_lock and it cannot be held across
ib_nl_send_msg().

Convert that lock to a mutex and move the list_add to after the
success of ib_nl_send_msg() and this bug should be fixed without
adding jaunty atomics or a wait queue.

This is a 'racy error unwind' bug class...

Jason
