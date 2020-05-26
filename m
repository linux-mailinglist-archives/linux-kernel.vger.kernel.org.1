Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A921C48A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgEDU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:56:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40042 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:56:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id t199so7955694oif.7;
        Mon, 04 May 2020 13:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49JfRSu7Z45L3uW77qIV3cnaE4R+Gs8XMBvGAM5yqb8=;
        b=iDIgqdU3wy9GuOnU52cAiA9WO0lwQpA8nxqKgxLHjmg1z4Hj2jKFJR7rcJ2xKp+GdC
         NWVXuR2sjiEUE75gvqpEPBBvdDZX4Fd/CzdWPLUIStGJkqrhi0uOwE+4Ctw8gJUEpsPO
         lN5rr6ecG7uYcCcUpy5STykUyZcxmZiRCyycgPFs7yylcUSujz/lyGl3QmWN+FQGA+wW
         xqGn5SfXZbFTjpsNbnZ5wNByJqxhY4fCBtD3N/3e4JoLwrFjqprJm+PH5Wfsn0kPkYyb
         mkOnJiheiRe0ww+W56BqaKHXmdy/XHrouGQfKjIBnhKRoORwOBEXwuXDDtnXZ5RPAycp
         3TPg==
X-Gm-Message-State: AGi0PubEKgB0sUKZgvwH4K+9td2BwFxQxJ+ZOWoYPFjZN041x/JiGZXo
        xICmBq7K5fbL7SULFDT40A==
X-Google-Smtp-Source: APiQypIWX2xYvDQjFYR6eQ0iD5KkiHWoeuztyZC7eE31EXGGKhMkGdlopL7V7GjRzsRX4uxmkYMlcg==
X-Received: by 2002:aca:f50e:: with SMTP id t14mr205715oih.156.1588625792393;
        Mon, 04 May 2020 13:56:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm18906oop.40.2020.05.04.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:56:31 -0700 (PDT)
Received: (nullmailer pid 17194 invoked by uid 1000);
        Mon, 04 May 2020 20:56:31 -0000
Date:   Mon, 4 May 2020 15:56:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v2] of: Documentation: change overlay example to use
 current syntax
Message-ID: <20200504205631.GA15733@bogus>
References: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 06:37:18PM -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The overlay implementation details in the compiled (DTB) file are
> now properly implemented by the dtc compiler and should no longer
> be hard coded in the source file.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes since v1:
>   - fixed typo in patch comment (implementation)
> 
>  Documentation/devicetree/overlay-notes.txt | 85 ++++++++++++------------------
>  1 file changed, 35 insertions(+), 50 deletions(-)

Applied. Sorry this slipped thru the cracks.

Rob
