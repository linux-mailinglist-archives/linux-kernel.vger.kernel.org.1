Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8225B28BA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgJLOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgJLOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:11:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80370C0613D0;
        Mon, 12 Oct 2020 07:11:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p15so17285028wmi.4;
        Mon, 12 Oct 2020 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h5ZzfIQX6aukJHSw7vumw8xxwzN9YjqBKxEPTr4voAE=;
        b=nSqQGv4d++sbaaU/Uqp66MRg+uQGgvk/MSvA5vlGFCbMSMt0OStJjRchzQCer45lu1
         sD6cu6MorP8epgzgtim32sk/T6s60L1gH5V2n9lxP+wX7QriElKQUVayo2kJquXNU/kn
         AWlooPwo3XmGJcMCQ2AKYjgOnVmtVoVY+LRdx5kBbWtJI98HOJe1oTGkwnPjIGZfpOVl
         uA27gFQrBTWmbnf73lVnPqpjIl4vvoJ3TUfCN3yo+8JBhRAk1E97bbounECU0hdhaNNh
         d53cag1c6ewz4a9OON82EovWd1mlQ3CAhT1tXhbtCeNUpZx2UqBnW/njoONiHeaWS24t
         ODMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h5ZzfIQX6aukJHSw7vumw8xxwzN9YjqBKxEPTr4voAE=;
        b=jC6jXPTy5GpJx3vQu8OifF4A9qDZLTz3flnt/5sQrTfIz5zxcLVdiDYGgLmGCsQfuF
         z9DxLNwF5xeQ2ecAZpVQPcabARbDW3PgjuxK+PyPNp2HXhRSa/VjRpJW+FWwhYbi9H/v
         XIk5tpZufq8p+b8cf2es1SP+VgPl7Vkh1rinjnkI+z7pz3Jyk62cvr4L762u0q0KDWn8
         fY5+Xtu1HQ4Y0K+QWcliC3P0AOm974fwKKBxtVqpHOgxf6zyRek9hb85O+ZCNuAuLKBw
         WhK3bthtRRAbBPmj9oUSj9mde5Rnnd4EHCYcgKn6b5oBbl2OVYo+fAqDAwymrH3i2BVn
         duHA==
X-Gm-Message-State: AOAM530wKafrnllctCdotdmkX0j1CaHcT0ArP+bNTL3vpzog8ljIQq5n
        Bqi8TvbT8t1MLHh5m7QtJWPCE9WitfqtXN8o
X-Google-Smtp-Source: ABdhPJz4cQE56p19WC7uOYDWwXi0QBHomdFPb+2I5XMQ70Fc159welhBc/U++H1WJ8qlhMX+39I/wg==
X-Received: by 2002:a1c:9d90:: with SMTP id g138mr10989579wme.5.1602511900138;
        Mon, 12 Oct 2020 07:11:40 -0700 (PDT)
Received: from felia ([2001:16b8:2d57:fc00:8472:203c:3ecb:c442])
        by smtp.gmail.com with ESMTPSA id b63sm25593091wme.9.2020.10.12.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 07:11:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 12 Oct 2020 16:11:38 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
Message-ID: <alpine.DEB.2.21.2010121550300.6487@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Oct 2020, Sudip Mukherjee wrote:

> Add a comment explaining why find_tt() will not return error even though
> find_tt() is checking for NULL and other errors.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

I get the intent of the comment but there is a large risk that somebody 
could remove the find_tt() call before the calling the function and there 
is no chance to then see later that the comment is actually wrong.

I guess you want to link this comment here to a code line above and
request anyone touching the line above to reconsider the comment then.

But there is no 'concept' for such kind of requests to changes and 
comments.

So, the comment is true now, but might be true or wrong later.

I am wondering if such comment deserves to be included if we cannot check 
its validity later...

I would prefer a simple tool that could check that your basic assumption 
on the code is valid and if it the basic assumption is still valid, 
just shut up any stupid tool that simply does not get that these calls 
here cannot return any error.

We encountered this issue because of clang analyzer complaining, but it is 
clear that it is a false positive of that (smart but) incomplete tool.

Do you intend to add comment for all false positives from all tools or are 
we going to find a better solution than that?

I am happy to contribute to the smarter solution...
e.g., a cocci script that checks that the call is still there and then
always marking the related tool finding as false positive.

Lukas

> ---
>  drivers/usb/host/ehci-sched.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index 6dfb242f9a4b..0f85aa9b2fb1 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -244,6 +244,12 @@ static void reserve_release_intr_bandwidth(struct ehci_hcd *ehci,
>  
>  	/* FS/LS bus bandwidth */
>  	if (tt_usecs) {
> +		/*
> +		 * find_tt() will not return any error here as we have
> +		 * already called find_tt() before calling this function
> +		 * and checked for any error return. The previous call
> +		 * would have created the data structure.
> +		 */
>  		tt = find_tt(qh->ps.udev);
>  		if (sign > 0)
>  			list_add_tail(&qh->ps.ps_list, &tt->ps_list);
> @@ -1337,6 +1343,12 @@ static void reserve_release_iso_bandwidth(struct ehci_hcd *ehci,
>  			}
>  		}
>  
> +		/*
> +		 * find_tt() will not return any error here as we have
> +		 * already called find_tt() before calling this function
> +		 * and checked for any error return. The previous call
> +		 * would have created the data structure.
> +		 */
>  		tt = find_tt(stream->ps.udev);
>  		if (sign > 0)
>  			list_add_tail(&stream->ps.ps_list, &tt->ps_list);
> -- 
> 2.11.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#76): https://lists.elisa.tech/g/linux-safety/message/76
> Mute This Topic: https://lists.elisa.tech/mt/77448152/1714638
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> 
