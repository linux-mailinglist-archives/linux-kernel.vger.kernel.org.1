Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3C2E6B80
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgL1Wz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgL1UXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:23:46 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F0C061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:23:06 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w79so9821333qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EpTdIYOFXIEGqAx9s+sFGrEVZtrYKtNXXy9SEY9qRE=;
        b=XzEoX7se7gdT+PPesqt7TRoQ5DJYbGHBQPFSEnWBTeaycsn8zErxFaVUwZ6O0/eBQX
         JvXxcj07SrGRt8NC+oCDbEX8H9ZEy8wQwyzMPGTYjfgh5PwbOjZCH4sux40D36rzbCl8
         a5zKHuOxyxEYgEc6rSpQIj9wvML1U7hH2O23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EpTdIYOFXIEGqAx9s+sFGrEVZtrYKtNXXy9SEY9qRE=;
        b=UfSplpnLpQ2LW15OULi05XklOyznU1UA4KRyS88+yakLhyvvuRaIECcosC+gvUMg+Z
         fA4hujxrz14KwfGJXMLALRHf3AVpQjRUrG7xKL7nGOFERK7YMxB8lSrdZ+3C0Z4wGBDN
         IFsRBdOXG6NIkPqsfApzd7QFAzrD3PHI6Cd2m8J3B/MqCqSnd/gRnfiZ3xCyuj213MMK
         Dk/nHBaoq4maeDEoTWHxen4Fum3+7hqwt8KIdCXvCuM4Pyrn9entMOiviPIsIBYCxxRO
         uXnJEtKCQUdMrTtjY7sFejHSfDI4YlPKVdKZFL6tGTGESQWXi5FJsJwGxcFysX9jwug/
         lrjg==
X-Gm-Message-State: AOAM5330cU9JkXD4I3qIJ/Zoj1LMel30q1NSO9/DuMTXQcBo08uBF5DI
        gJzbb0928Eh7NNvJ2BoBn5wPuw==
X-Google-Smtp-Source: ABdhPJxq/0XcSIyWLCuk2o5XNjIVM6Bureox3/RV7HCZzpMA0Y+pdx2v3wSOCsNVXetAzx3iObNPoQ==
X-Received: by 2002:a37:b543:: with SMTP id e64mr37520059qkf.10.1609186985195;
        Mon, 28 Dec 2020 12:23:05 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g26sm24036747qkl.60.2020.12.28.12.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:23:04 -0800 (PST)
Date:   Mon, 28 Dec 2020 15:23:02 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Fix memleak in ethoc_probe
Message-ID: <20201228202302.afkxtco27j4ahh6d@chatter.i7.local>
References: <20201223110615.31389-1-dinghao.liu@zju.edu.cn>
 <20201223153304.GD3198262@lunn.ch>
 <20201223123218.1cf7d9cb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201223210044.GA3253993@lunn.ch>
 <20201223131149.15fff8d2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <680850a9-8ab0-4672-498e-6dc740720da3@gmail.com>
 <20201223174146.37e62326@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201224180631.l4zieher54ncqvwl@chatter.i7.local>
 <fc7be127-648c-6b09-6f00-3542e0388197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc7be127-648c-6b09-6f00-3542e0388197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 01:57:40PM -0800, Florian Fainelli wrote:
> >> Konstantin, would you be willing to mod the kernel.org instance of
> >> patchwork to populate Fixes tags in the generated mboxes?
> > 
> > I'd really rather not -- we try not to diverge from project upstream if at all
> > possible, as this dramatically complicates upgrades.
> 
> Well that is really unfortunate then because the Linux developer
> community settled on using the Fixes: tag for years now and having
> patchwork automatically append those tags would greatly help maintainers.

I agree -- but this is something that needs to be implemented upstream.
Picking up a one-off patch just for patchwork.kernel.org is not the right way
to go about this.

-K
