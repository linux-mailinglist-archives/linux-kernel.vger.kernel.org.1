Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D712CEFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbgLDOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:43:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37731 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgLDOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:43:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id z1so6892568ljn.4;
        Fri, 04 Dec 2020 06:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ulvi+cJW73sNAQzYhXEuWReB9rnRQXnvkznBorTplew=;
        b=J+f6TBk1NdV2jprBpYpEqQahqtYGH8HiELgZLQnWd7NNnNbPxCDvsOUxKi3gGAL7NL
         N7cLPAXsCqSFwqhuC7QUv0EKCcRLTL6VbFE8BE2ZL7S00CN/vxMSA9racR8hiFEu+gGp
         d086Fn/acBj0o5E1bM9n/cMSNL8w4ZVRiwDkk04+zF9gzBuvhyCnebWd0lj1FTxjNYIn
         f8sN10/ej1a5te6Q4m5y4npSvNOce0dqdhRCUpHEZv4Yn95OPhsdQUQpjdshFdgoR9x2
         tnKaDKBJiFHESBgmSUBTtEXFswR6Bx9Ab/GhzbvTADf8+EeydiTYsGqq67xuWSvG/JAe
         eTEg==
X-Gm-Message-State: AOAM530eRp6RW4vUu0NYGvGvAT9eXjdiaOyLc2HhGIp2Yca8mrFp/OKv
        t1KhvhPCbscsgDN/Sfz5miY=
X-Google-Smtp-Source: ABdhPJzDHg0vXCoclSgX+VloGnxH9zJkmqeEnqi5owAxZ6csOHa1RXMMSVXiAWHR8j1XtWZlXVHmqg==
X-Received: by 2002:a2e:8011:: with SMTP id j17mr3717519ljg.325.1607092971879;
        Fri, 04 Dec 2020 06:42:51 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q13sm1783435lfp.2.2020.12.04.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:42:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1klCIv-0005MC-IZ; Fri, 04 Dec 2020 15:43:25 +0100
Date:   Fri, 4 Dec 2020 15:43:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] usb: misc: emi62: update to use
 usb_control_msg_send()
Message-ID: <X8pLDVCmLrhMi4No@localhost>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130012925.2579632-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130012925.2579632-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:59:25AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---

This driver looks like it shares origins with the emi26 one so the same
comments apply (and especially not put large structures on the stack).

Johan
