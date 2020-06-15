Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E101F9E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgFOR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 13:28:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46373 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:31 -0400
Received: by mail-io1-f66.google.com with SMTP id t9so18777046ioj.13;
        Mon, 15 Jun 2020 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYImRG60d+Rk9sSAeNy5oAUfEqEV6FzOSefEkoMdz1A=;
        b=c6Q5k+Rfdu730zCRRld/lD30CrWWmoIAIK0lnGjzpL3igvV40WPNk9FRWSzJ16IEbv
         uU6lAS+IA035ly6sSgUzBWuJnxeAUJVnA6XIlx9zGWo0GSFS5vxHGOl1yvYLJCsZIfFK
         cvgrlhbL0XoPTdOzSeRvftGG1MBkib7QWdU6vjXreWoHgJaRfw6eULGVzHkk3KCm++lJ
         RQiPCpEfQdvSxIK8JKWhMGz9VLAlgMPBvY39sV0zY2Zc08q4H5po2zkICH8tBzusa9P2
         frAEpCh99XIicsaHqY5OXI65jO3PyeWVjyeBjruauM2+oZfqf81xs0kaaWbWD+Kl8uH1
         03hw==
X-Gm-Message-State: AOAM533xWWdjf7TNkesEmalps0BEYVkk5bdUvVCyTXIFL9Nuc3loYsBH
        JPKwc0ehy1DrRnYyP/wdEQ==
X-Google-Smtp-Source: ABdhPJwz5sp/TMnFaz83wtBaFbg7kfsSf/GiLBBdiXdjYa27eWvs6SUspoeUIqIBwTNfg4+zClzoEA==
X-Received: by 2002:a05:6602:228b:: with SMTP id d11mr26217595iod.98.1592242110735;
        Mon, 15 Jun 2020 10:28:30 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x18sm8170183ilq.46.2020.06.15.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:28:30 -0700 (PDT)
Received: (nullmailer pid 1996652 invoked by uid 1000);
        Mon, 15 Jun 2020 17:28:29 -0000
Date:   Mon, 15 Jun 2020 11:28:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: Fix typo in the too-many-regions
 message
Message-ID: <20200615172829.GA1996494@bogus>
References: <20200604054900.200317-1-danny@kdrag0n.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604054900.200317-1-danny@kdrag0n.dev>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020 22:49:00 -0700, Danny Lin wrote:
> Minor fix for a missing preposition in the error message that appears
> when there are too many reserved memory regions for the allocated array
> to store.
> 
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
